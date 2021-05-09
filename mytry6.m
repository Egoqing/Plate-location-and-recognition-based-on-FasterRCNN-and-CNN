function imaget=mytry6(imaget)
I=imaget;
[row,col,dep]=size(I);                     
I3=zeros(row,col);                      
for i=1:row
    for j=1:col
        x=i;                        %水平镜像变换x的值不变
        y=col-j+1;                    %镜像变换后y的值
        I3(x,y)=I(i,j);
    end
end
%figure,subplot(1,2,1);imshow(I);title('原图');
%Ssubplot(1,2,2);imshow(I3,[]);title('水平镜像变换后的图片');
imaget=I3;
