function  [r,Image]=myedge(Image)
Img_cut = Image;
figure;imshow(Img_cut);title('������ɫ�и���ͼ��')

grayimg = rgb2gray(Img_cut);
figure;imshow(grayimg);title('�Ҷ�ͼ��')

H = fspecial('gaussian',5,3);%5��3�ĺ��壿
blurred = imfilter(grayimg,H,'replicate');
figure;imshow(blurred);title('��˹ģ��')

%s=strel('disk',13);
%Bgray=imopen(blurred,s);
%blurred=imsubtract(blurred,Bgray);

bw = edge(blurred,'sobel','vertical'); 
figure; imshow(bw);title('��Եͼ��');  % ��ֱ��Ե���
 
se1 = strel('rectangle',[35,48]);
bw_close=imclose(bw,se1);
%figure;imshow(bw_close);title('�ղ���');  
 
se2 = strel('rectangle',[23 18]);
bw_open = imopen(bw_close, se2);
%figure;imshow(bw_open);title('������');
 

bw_close = bwareaopen(bw_open,3000);  % �Ƴ�С����
%figure;imshow(bw_close);title('ȥ������');
 
se3 = strel('rectangle',[20,15]);
bw_dilate = imdilate(bw_close,se3);




figure;imshow(bw_dilate);title('��̬ѧ������'); 
 

stats = regionprops(bw_dilate,'BoundingBox','Centroid');
L = length(stats);
fprintf('���ƺ�ѡ���������:%d \n', L);
[index,r] = mycolor2(stats,Image); 
if (index==0)
    r=0;
 return 
end
bb = stats(index).BoundingBox; 
Image=Image(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);
figure;imshow(Image); title('����');



