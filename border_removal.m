function img_temp=border_removal(img)
% % % img=imread('D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\�ָ�code\380EA3.jpg');

% img=imread('D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\�ָ�code\380EA4.jpg');
% img=blue_cut(img);
if length(size(img)) == 3
    img_gray=rgb2gray(img);
else
    img_gray=img;
end
img_gray=imresize(img_gray,[140,440]);
T=graythresh(img_gray);
img_bw=imbinarize(img_gray,T);
figure(2);imshow(img_bw);title('��ֵ��')
% %% ȥ�����±߿��í��
% %����ˮƽ�߿�ˮƽ����仯���ḻ
% %ͳ�������������ˮƽ����仯�ḻ��
% diff_row=diff(img_bw,1,2);% ǰһ�м���һ��
% diff_row_sum = sum(abs(diff_row), 2);  %ÿ��ͼ��仯�ķḻ��
% figure(3);plot(diff_row_sum);title('ˮƽ�仯�ḻ��')
% [row,col]=size(img_bw);
% %����ֵ
% 
% row_down=round(1*row/3);
% row_up=round(2*row/3);
% while row_up >1
%     if diff_row_sum(row_up)<10 %�������Ӧ����ֵ��
%         break;
%     else
%         row_up=row_up-1;
%     end
% end
% while row_down <row
%     if diff_row_sum(row_down)<10
%         break;
%     else
%         row_down=row_down+1;
%     end
% end
% %% ��
% % [row,col]=size(img_bw);
% % flag_row=false;
% % while ~flag_row
% %     [~,row_max]=max(diff_row_sum);
% %     row_down=row_max;
% %     row_up=row_max;
% %     while row_up >1
% %         if diff_row_sum(row_up)<10 %�������Ӧ����ֵ��
% %             break;
% %         else
% %             row_up=row_up-1;
% %         end
% %     end
% %     while row_down <row
% %         if diff_row_sum(row_down)<10
% %             break;
% %         else
% %             row_down=row_down+1;
% %         end
% %     end
% %     if row_down-row_up<50
% %         diff_row_sum(row_max)=0;%���ڱ仯��ḻ�����ڳ�������
% %         flag_row=false;
% %     else
% %         flag_row=true;%ȷʵ�и�������±߿�
% %     end
% % end
img_temp=hborder_removal(img_bw);
%figure(3);imshow(img_bw);title('��ת����')
%figure(4);imshow(img_temp);title('ȥ�����±߿�')
%% ȥ�������ɫ����
[row,col]=size(img_temp);
one_col=zeros(1,col);
for j = 1: col
    for i = 1:row
        if img_temp(i,j)==1
            one_col(1,j)=one_col(1,j)+1;
        end
    end
end
% figure(5);plot(one_col);title('��ֱͶӰ')
col_left=round(col/2);
col_right=round(col/2);
min_col=min(one_col);
temp_col=sort(one_col);
thresh_char=sum(temp_col(end-1:end)); %�򵥵��ַ����ص�����ֵ
while one_col(col_left)>min_col || sum(one_col(1:col_left))>thresh_char
    if col_left == 1
        break;
    else
        col_left=col_left-1;
    end
end
while one_col(col_right)>min_col || sum(one_col(col_right:end))>thresh_char
    if col_right == col
        break;
    else
        col_right=col_right+1;
    end
end
img_temp=img_temp(:,col_left:col_right);
img_temp=imresize(img_temp,[140,440]);
%figure(6);imshow(img_temp);title('�����')
% figure(4);imshow(img_temp);title('ȥ�����±߿��í��')


