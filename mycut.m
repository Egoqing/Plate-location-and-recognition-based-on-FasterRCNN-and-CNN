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
%%%%%%%%%%%%%%%%��ʴ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

se1 = strel('square',3);%���ø�����״�ʹ�С����Ԫ�أ�������ָ����״shape��Ӧ�ĽṹԪ�ء��������͸�ʴ����������Ȳ����ĽṹԪ�ض���
I3 =imerode(I2,se1);
figure(2);imshow(I3);title('��ʴ����')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% A = sum(I1);
% figure(2)
% plot(A)
%%%%%% 3.ȥ�����±߿��í����ͳ�����������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ��λ�е���ʼλ��(��1/3������ɨ����)
%%% ��λ�еĽ���λ��(��2/3������ɨ����)
diff_row = diff(I3,1,2);  % ǰһ�м���һ��
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
imshow(I4);title('ȥ�����±߿��í��');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%�ж��Ƿ���Ҫ��תͼƬ
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
    %%%%���ͶӰ����Ϊ��ı���С��1/5���������ת
    I4 = [zeros(round(column/2),column);I4;zeros(round(column/2),column)];
    I4 = imrotate(I4, -rot_theta, 'crop');  % ��ͼ�������ת��У��ͼ��
end
I5 = I4;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 4.ȥ�����ұ߿�ͶӰ����
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
imshow(I6);title('ȥ�����ұ߿�');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 5.ȥ���ַ����ұ�����ͶӰ����
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
imshow(I7);title('�ַ�����');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%���Ͳ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

se1 = strel('square',3);%���ø�����״�ʹ�С����Ԫ�أ�������ָ����״shape��Ӧ�ĽṹԪ�ء��������͸�ʴ����������Ȳ����ĽṹԪ�ض���
I8 =imdilate(I7,se1);
figure(7);imshow(I8);title('���Ͳ���')



