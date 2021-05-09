function  [r,Image]=myedge(Image)
Img_cut = Image;
figure;imshow(Img_cut);title('根据颜色切割后的图像')

grayimg = rgb2gray(Img_cut);
figure;imshow(grayimg);title('灰度图像')

H = fspecial('gaussian',5,3);%5，3的含义？
blurred = imfilter(grayimg,H,'replicate');
figure;imshow(blurred);title('高斯模糊')

%s=strel('disk',13);
%Bgray=imopen(blurred,s);
%blurred=imsubtract(blurred,Bgray);

bw = edge(blurred,'sobel','vertical'); 
figure; imshow(bw);title('边缘图像');  % 垂直边缘检测
 
se1 = strel('rectangle',[35,48]);
bw_close=imclose(bw,se1);
%figure;imshow(bw_close);title('闭操作');  
 
se2 = strel('rectangle',[23 18]);
bw_open = imopen(bw_close, se2);
%figure;imshow(bw_open);title('开操作');
 

bw_close = bwareaopen(bw_open,3000);  % 移除小对象
%figure;imshow(bw_close);title('去除噪声');
 
se3 = strel('rectangle',[20,15]);
bw_dilate = imdilate(bw_close,se3);




figure;imshow(bw_dilate);title('形态学处理结果'); 
 

stats = regionprops(bw_dilate,'BoundingBox','Centroid');
L = length(stats);
fprintf('车牌候选区域的数量:%d \n', L);
[index,r] = mycolor2(stats,Image); 
if (index==0)
    r=0;
 return 
end
bb = stats(index).BoundingBox; 
Image=Image(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);
figure;imshow(Image); title('车牌');



