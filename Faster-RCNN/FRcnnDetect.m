% clear 
% close all
% load FRcnn480.mat
[filename,pathname]=uigetfile({'*.jpg','car1'});
if(filename==0),return,end
global FILENAME   %����ȫ�ֱ���
FILENAME=[pathname filename];
img=imread(FILENAME); 
% img=imread('D:\��Ѷ\Tencent Files\�ۺϿ���\Part2���ͼƬ��\����ʶ��ѵ����\sub_test_pics\����ʶ����Կ�\90.jpg');
img_temp=imresize(img,FRcnn.imgsize(1:2));
[row,col,~]=size(img);
ky=FRcnn.imgsize(1)/row;
kx=FRcnn.imgsize(2)/col;
tic
bbox_temp= detect(FRcnn.net,img_temp);
if size(bbox_temp,1)>1
    bbox_temp=bbox_temp(2,:);
end
% if  bbox_temp(3)>=bbox_temp(4) && bbox_temp(4)/bbox_temp(3)>=0.8
%     if bbox_temp(1)-round(bbox_temp(4)/3)>1
%         bbox_temp(3)=bbox_temp(3)+round(bbox_temp(4)/2);
%         bbox_temp(1)=bbox_temp(1)-round(bbox_temp(4)/4);
%     else
%         bbox_temp(3)=bbox_temp(3)+round(3*bbox_temp(4)/4);
%     end
% elseif bbox_temp(4)>=bbox_temp(3) && bbox_temp(3)/bbox_temp(4)>=0.8
%     if bbox_temp(2)-round(bbox_temp(3)/2)>1
%         bbox_temp(4)=bbox_temp(4)+round(bbox_temp(3)/2);
%         bbox_temp(2)=bbox_temp(2)-round(bbox_temp(3)/4);
%     else
%         bbox_temp(4)=bbox_temp(3)+round(3*bbox_temp(4)/4);
%     end
% end
v=[1/kx;1/ky;1/kx;1/ky];
T=diag(v);
bbox=(T*bbox_temp')';
bbox(3)=bbox(3)-kx+1;
bbox(4)=bbox(4)-ky+1;
bbox=round(bbox);
detectedImg_temp = insertShape(img_temp,'Rectangle',bbox_temp,'LineWidth',4);
detectedImg = insertShape(img,'Rectangle',bbox,'LineWidth',15);
figure(1);imshow(detectedImg_temp);title(['ͼ���һ��-',filename])
figure(2);imshow(detectedImg);title(['ԭͼ��-',filename])
toc
% up=bbox_temp(2);down=bbox_temp(2)+bbox_temp(4)-1;
% left=bbox_temp(1);right=bbox_temp(1)+bbox_temp(3)-1;
% plate= img(up:down,left:right,:);
% % plate=imresize(plate,4*[size(plate,1),size(plate,2)]);
% figure(3),imshow(plate);title('����')