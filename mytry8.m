function imaget=mytry8(imge)
[H,W]=size(imge);
En=ones(1,W);
Ed=H*ones(1,W);
for i=1:W
    for j=1:H
          En(i)=j;
          if imge(j,i)==1  
            break;
         end
    end
end
for i=1:W
    for j=1:H
        k=H+1-j;
          Ed(i)=j;
          if imge(k,i)==1  
            break;
         end
    end
end
[c,lags]=xcorr(En,Ed);
figure(60),plot(lags,c);

[~,I]=max(c);
n0=I-440;
 if n0>0
    imge=mytry6(imge);
 end
 
I=imge;
[row,col,~]=size(I); 

I4=zeros(row,col);
I5=zeros(row,col);

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

  img_bw=I4;
  histcol1=sum(img_bw);      %计算垂直投影
  outline=find(histcol1>5);
  inline=histcol1(outline);
  [~,tn]=size(inline);
  line(i+1)=tn;
end
[~,W]=min(line);
dy=(W-1)/100;

for m=1:row
    for n=1:col
        x = round(m);
        y = round(n + dy * m);
        I5(x,y)=I(m,n);
    end
end
figure,subplot(1,2,1);imshow(I);title('原图');
subplot(1,2,2);imshow(I5,[]);title('垂直错切后的图片');
imge=I5;
 if n0>0
  imge=mytry6(imge);
 end
 imaget=imge;
 imaget=imresize(imaget,[140,440]);
end