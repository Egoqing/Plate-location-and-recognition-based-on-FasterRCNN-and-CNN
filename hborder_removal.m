function img_bw=hborder_removal(img_bw)
diff_row=diff(img_bw,1,2);% ǰһ�м���һ��
diff_row_sum = sum(abs(diff_row), 2);  %ÿ��ͼ��仯�ķḻ��
% figure(3);plot(diff_row_sum);title('ˮƽ�仯�ḻ��')
[row,~]=size(img_bw);
row_down=round(1*row/2);
row_up=round(1*row/2);
while row_up >1
    if diff_row_sum(row_up)<10 %�������Ӧ����ֵ��
        break;
    else
        row_up=row_up-1;
    end
end
while row_down <row
    if diff_row_sum(row_down)<10
        break;
    else
        row_down=row_down+1;
    end
end
img_bw=img_bw(row_up:row_down,:);