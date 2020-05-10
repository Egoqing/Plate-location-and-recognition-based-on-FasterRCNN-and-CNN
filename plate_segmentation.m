function Ipcrop=plate_segmentation(img)
% [filename,pathname]=uigetfile({'*.jpg'});
% global FILENAME   %����ȫ�ֱ���
% FILENAME=[pathname filename];
% img=imread(FILENAME);
img=imresize(img,[140,440]);
figure(50);imshow(img);title('����ǰ')
Ipbw=border_removal(img);
Ippcrop=double(Ipbw);
figure(51);imshow(Ippcrop);title('�����')
[~,col]=size(Ippcrop);
one_col = sum(Ippcrop);
interval={331:440,222:330,111:220,1:110};
temp_thresh=zeros(1,4);
temp_col=sort(one_col);
for i=1:4
    temp_col=sort(one_col(interval{i}));
    temp_thresh(i)=temp_col(19);
end
thresh = round(mean(temp_thresh)); %�򵥵�����Ӧ��ֵ
thresh_char=sum(temp_col(end-7:end))+thresh*20;%�򵥵�����Ӧ�ַ����ص���ֵ
Ipcrop=cell(1,7);
head=col;%�ַ��������
tail=col;%�ַ��Ҳ�����
temph=col;%���ڼ����ַ����
heigh = zeros(1,6);%��¼������ĸ�߶ȣ������������ָ߶�
width=50;%�ַ����
j=1;
flag=false;
sum_char=zeros(1,7);
while j <=7
    if head < 1  || tail < 1
        break
    end
    while one_col(1,tail)<=thresh && tail>1
         tail=tail-1;
    end
    head=tail;
    while one_col(1,head)>thresh && head>1 && (tail-head)<1.1*width
         head=head-1;
    end
    
    if j<7 %JС��7˵�����Ǻ���
        while (tail-head)<width && tail < col  &&(tail+1)<=temph && head>1 && one_col(1,head)<=thresh  %��ֹճ�ϱ���ַ�
            tail=tail+1;
            head=head-1;
        end
    else
        while (tail-head)<width-3 && head>1 %�������⣬�м���ܻ��п�϶
            head=head-1;%���ڴ���tail���������
        end
        tail=tail+3;
    end
    if  sum(one_col(1,head:tail))>thresh_char%���ص�������Ҫ��ľ���Ϊ��һ���ַ�;
        flag=true;
    end
    if flag  
        if (tail-head)<width
            temp_n=round((50-(tail-head))/2);
            padding=false(140,temp_n);
            temp_img=[padding,Ipbw(:,head:tail),padding];
        else
            temp_img=Ipbw(:,head:tail);
        end
        if j<7
            [temp_img,heigh(j)]=num_correct(temp_img);
        else
           meanRow=mean(heigh);
            [temp_img,~]=num_correct(temp_img,meanRow);
        end
        Ipcrop{j}=temp_img;
        figure(8); subplot(1,7,j); imshow(Ipcrop{j})
        sum_char(1,j)=sum(one_col(head:tail));
        j=j+1;
        flag=false;
        tail=head;
        temph=head;
    else
        tail=head;%����������ַ�������ֵ��˵���Ǹ��ţ��ų�֮
    end
end
