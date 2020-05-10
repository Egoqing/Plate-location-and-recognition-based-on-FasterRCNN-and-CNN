%% cnn_example
clear 
close all
clc
%% ��������
% digitDatasetPath = fullfile('D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\ʶ��code\train_num\testset_28_28\');
% imags = imageDatastore(digitDatasetPath, ...
%     'IncludeSubfolders',true,'LabelSource','foldernames');% �����ļ���������Ϊ���ݱ��
% % digitDatasetPath = fullfile('D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\ʶ��code\train_num\myDataset\');
% % imags = imageDatastore(digitDatasetPath, ...
% %     'IncludeSubfolders',true,'LabelSource','foldernames');% �����ļ���������Ϊ���ݱ��
train_path='D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\together\together\togetherv3.5\mydataset\';
test_path='D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\ʶ��code\train_num\testset_28_28\';
load cnn_param.mat
%% ����ѵ��������Լ�����֤��
[images_train ,labels_train]=myplateData(train_path,1);
[images_test,labels_test]=myplateData(test_path,1);
% img=images_train(:,:,1,1);
% cnn_param.size=size(img);
%% ������������ṹ
% layers = [
%     %�����
%     imageInputLayer([cnn_param.size,1]);
%     %conv1 �����1
%     convolution2dLayer(5,16,'Padding','same')
%     batchNormalizationLayer
%     reluLayer %�������
%     
%     %maxpooling ���ػ���
%     maxPooling2dLayer(2,'stride',2)
%     
%     %conv2 �����2
%     convolution2dLayer(5,32,'Padding','same')
%     batchNormalizationLayer
%     reluLayer %�������
%     
%     %maxpooling ���ػ���
%     maxPooling2dLayer(2,'stride',2)
%     
%     convolution2dLayer(5, 64)
%     batchNormalizationLayer
%     reluLayer
%     
%     %ȫ���Ӳ�
%     fullyConnectedLayer(34)
%     softmaxLayer
%     classificationLayer];

%% ����ѵ������
options=trainingOptions('sgdm', ...
    'MaxEpochs',300,...%�������� ��ȫ�����ݽ���һ��������ѵ����Ϊ��һ����
    'InitialLearnRate',1e-4, ...%ѧϰ����
    'MiniBatchsize',60,...%һ�ζ�ȡ60��ͼƬ ʹ��һС�������ݾ���ѵ�����򴫲��޸Ĳ�����Ϊ��һ����
    'ExecutionEnvironment','gpu');
%     'ValidationData', [], ...%iteration����һ��ͼƬ����һ��ѵ���Ĺ��̳�Ϊ��һ��ѵ����
%     'ValidationFrequency',50,...
%% ѵ������
% cnn_param.net = trainNetwork(images_train ,labels_train, layers ,options);
cnn_param.net = trainNetwork(images_train ,labels_train,cnn_param.net.Layers ,options);
%����ѵ������Ļ����ϼ���ѵ��
%% ��������
test_result=classify(cnn_param.net,images_test);
accuracy = sum(test_result==labels_test)/size(labels_test,1);
cnn_param.accuracy=accuracy;
disp(['���Լ���ʶ����ȷ�ʣ�',num2str(accuracy)])
save 'D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\ʶ��code\train_num\cnn_param_temp.mat' cnn_param