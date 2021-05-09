function [row,col,dy ,imaget,Image5]=mytry5(imaget,Image5,rot_theta)
I=imaget;
[row,col,~]=size(I); 

I4=zeros(row,col);
dy=0;
line=zeros(1,46);
for i=0:45
    dy=i/100;
for m=1:row
    for n=1:col
        x = round(m);
        y = round(n + dy * m);
        I4(x,y)=I(m,n);
    end
end
 T=graythresh(I4);
  img_bw=imbinarize(I4,T);
  histcol1=sum(img_bw);      %计算垂直投影
  outline=find(histcol1>13);
  inline=histcol1(outline);
  [tm,tn]=size(inline);
  line(i+1)=tn;
end
[M,W]=min(line);
dy=(W-1)/100;
theta=abs(rot_theta);
bilibili=col/row;
if theta<3&&bilibili>3.7
    dy=0;
end

for m=1:row
    for n=1:col
        x = round(m);
        y = round(n + dy * m);
        I5(x,y)=I(m,n);
    end
end
figure,subplot(1,2,1);imshow(I);title('原图');
subplot(1,2,2);imshow(I5,[]);title('垂直错切后的图片');
imaget=I5;


I=Image5;
[row,col,~]=size(I); 
I6=zeros(row,col);
for m=1:row
    for n=1:col
        x = round(m);
        y = round(n + dy * m);
        I6(x,y)=I(m,n);
    end
end
Image5=I6;
%figure,imshow(Image5);