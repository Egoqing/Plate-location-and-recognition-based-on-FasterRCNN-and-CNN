function I7 = mycut(image,rot_theta)
% [filename,pathname]=uigetfile({'plate4.jpg','car1'});
% Filename = [pathname filename];
% image = imread(Filename);
% T = rbg2hsv(image);
% T
I = rgb2gray(image);
I2 = imbinarize(I);
% [x,y] = size(I1);
 figure(1)
 imshow(I2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%腐蚀操作
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

se1 = strel('square',3);%运用各种形状和大小构造元素，创建由指定形状shape对应的结构元素。用于膨胀腐蚀及开闭运算等操作的结构元素对象。
I3 =imerode(I2,se1);
figure(2);imshow(I3);title('腐蚀操作')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% A = sum(I1);
% figure(2)
% plot(A)
%%%%%% 3.去掉上下边框和铆钉（统计跳变次数）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 定位行的起始位置(从1/3处先上扫描行)
%%% 定位行的结束位置(从2/3处先下扫描行)
diff_row = diff(I3,1,2);  % 前一列减后一列
diff_row_sum = sum(abs(diff_row), 2);  
[rows, columns] = size(I3);
trows = ceil(rows*(1/3));
j = trows;
for i=1:trows
    if diff_row_sum(j,1)<10
        plate_rowa = j;
        break;
    end
    j = trows-i;
end

for i=2*trows:size(diff_row_sum,1)
    if diff_row_sum(i,1)<10
        plate_rowb = i;
        break;
    end
end
I4 = I3(plate_rowa:plate_rowb, :);
% I4=remove_extra_region(I4);
figure(3)
imshow(I4);title('去除上下边框和铆钉');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%判断是否需要旋转图片
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[row,column] = size(I4);
I4_sum = sum(I4,1);
for i = 1:column
    if I4_sum(i)>0
        I4_sum(i) = 1;
    end
end
I4_SUM = sum(I4_sum);
if I4_SUM>=round(3*column/4)
    %%%%如果投影区域为零的比例小于1/5，则进行旋转
    I4 = [zeros(round(column/2),column);I4;zeros(round(column/2),column)];
    I4 = imrotate(I4, -rot_theta, 'crop');  % 对图像进行旋转，校正图像
end
I5 = I4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 4.去除左右边框（投影法）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plate_projection_v = sum(I5,1);

for i=1:size(plate_projection_v, 2)
    if plate_projection_v(1,i) == 0
        plate_cola = i;
        break;
    end
end

for i=1:size(plate_projection_v, 2)
    j = size(plate_projection_v, 2) - i + 1;
    if plate_projection_v(1,j) == 0
        plate_colb = j;
        break;
    end
end
I6 = I5(:,plate_cola:plate_colb);
figure(5)
imshow(I6);title('去除左右边框');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 5.去除字符左右背景（投影法）
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppv1 = sum(I6,1);
for i=1:size(ppv1, 2)
    if ppv1(1,i) ~= 0
        pl_cola = i;
        break;
    end
end

for i=1:size(ppv1, 2)
    j = size(ppv1, 2) - i + 1;
    if ppv1(1,j) ~= 0
        pl_colb = j;
        break;
    end
end
I7 = I6(:,pl_cola:pl_colb);
figure(6)
imshow(I7);title('字符车牌');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%膨胀操作
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

se1 = strel('square',3);%运用各种形状和大小构造元素，创建由指定形状shape对应的结构元素。用于膨胀腐蚀及开闭运算等操作的结构元素对象。
I8 =imdilate(I7,se1);
figure(7);imshow(I8);title('膨胀操作')



