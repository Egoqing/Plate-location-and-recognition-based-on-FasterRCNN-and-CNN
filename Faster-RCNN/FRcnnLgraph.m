function lgraph=FRcnnLgraph(imgsize,anchorBoxes)
%% �����
net=resnet50;
lgraph = layerGraph(net);
imputLayer=imageInputLayer(imgsize,'Name','imageData');
lgraph=replaceLayer(lgraph,'input_1',imputLayer);
%����avg_pool �����С��ƥ������
NewAvgPool = averagePooling2dLayer(2,'Name','avg_pool','stride',2);
lgraph=replaceLayer(lgraph,'avg_pool',NewAvgPool);
% ȥ������������
layersToRemove = {
    'fc1000'
    'fc1000_softmax'
    'ClassificationLayer_fc1000'
    };
lgraph = removeLayers(lgraph,layersToRemove);
numClasses = 1;
numClassesPlusBackground = numClasses +1;
%�����µ�classification��
newlayers = [
    fullyConnectedLayer(numClassesPlusBackground,'Name','rcnnFC')
    softmaxLayer('Name','rcnnSoftmax')
    classificationLayer('Name','rcnnClassification')
    ];
lgraph = addLayers(lgraph,newlayers);
lgraph = connectLayers(lgraph,'avg_pool','rcnnFC');
%����ȫ���Ӳ�����
numOutputs = 4*numClasses;%������ο���ĸ�����
%���� boxRegress layer
boxRegressionLayers = [
    fullyConnectedLayer(numOutputs,'Name','rcnnBoxFC')
    rcnnBoxRegressionLayer('Name','rcnnBoxDeltas')
    ];
lgraph = addLayers(lgraph,boxRegressionLayers);
lgraph = connectLayers(lgraph,'avg_pool','rcnnBoxFC');
%ѡ��������ȡ��
featureExtractionLayer = 'activation_40_relu';
% Disconnect the layers attached to the selected feature extraction layer.
lgraph = disconnectLayers(lgraph, featureExtractionLayer,'res5a_branch2a');
lgraph = disconnectLayers(lgraph, featureExtractionLayer,'res5a_branch1');
% Add ROI max pooling layer.
outputSize = [6 8];
roiPool = roiMaxPooling2dLayer(outputSize,'Name','roiPool');
lgraph = addLayers(lgraph, roiPool);
% Connect feature extraction layer to ROI max pooling layer.
lgraph = connectLayers(lgraph, featureExtractionLayer,'roiPool/in');
% Connect the output of ROI max pool to the disconnected layers from above.
lgraph = connectLayers(lgraph, 'roiPool','res5a_branch2a');
lgraph = connectLayers(lgraph, 'roiPool','res5a_branch1');
% � RPN,���ӵ�������ȡ��
%anchorBoxes
proposalLayer=regionProposalLayer(anchorBoxes,'Name','regionProposal');
lgraph = addLayers(lgraph, proposalLayer);
numAnchors = size(anchorBoxes,1);
numFilters = 256;
rpnLayers = [
    convolution2dLayer(3,numFilters,'padding',[1,1],'Name','rpnConv3x3')
    reluLayer('Name','rpnRelu')
    ];
lgraph = addLayers(lgraph, rpnLayers);
lgraph = connectLayers(lgraph, featureExtractionLayer, 'rpnConv3x3');
%���RPN��������� ��������֡�ǰ����
rpnClsLayers = [
   convolution2dLayer(1,numAnchors*2,'Name','rpnConv1x1ClsScores') 
   rpnSoftmaxLayer('Name','rpnSoftmax')
   rpnClassificationLayer('Name','rpnClassifiction')
];
lgraph = addLayers(lgraph, rpnClsLayers);
lgraph = connectLayers(lgraph, 'rpnRelu', 'rpnConv1x1ClsScores');
%���RPN�ع��
rpnRegLayers = [
    convolution2dLayer(1,numAnchors*4,'Name','rpnConv1x1BoxDeltas')
    rcnnBoxRegressionLayer('Name','rpnBoxDeltas')
];
lgraph = addLayers(lgraph, rpnRegLayers);
lgraph = connectLayers(lgraph, 'rpnRelu', 'rpnConv1x1BoxDeltas');
%��󣬽�����ͻع�����ӳ�����ӵ�����������룬�� ROI �㼯�����ӵ�����������
lgraph = connectLayers(lgraph, 'rpnConv1x1ClsScores', 'regionProposal/scores');
lgraph = connectLayers(lgraph, 'rpnConv1x1BoxDeltas', 'regionProposal/boxDeltas');
lgraph = connectLayers(lgraph, 'regionProposal', 'roiPool/roi');

