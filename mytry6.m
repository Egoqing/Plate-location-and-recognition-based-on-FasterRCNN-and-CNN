function imaget=mytry6(imaget)
I=imaget;
[row,col,dep]=size(I);                     
I3=zeros(row,col);                      
for i=1:row
    for j=1:col
        x=i;                        %ˮƽ����任x��ֵ����
        y=col-j+1;                    %����任��y��ֵ
        I3(x,y)=I(i,j);
    end
end
%figure,subplot(1,2,1);imshow(I);title('ԭͼ');
%Ssubplot(1,2,2);imshow(I3,[]);title('ˮƽ����任���ͼƬ');
imaget=I3;
