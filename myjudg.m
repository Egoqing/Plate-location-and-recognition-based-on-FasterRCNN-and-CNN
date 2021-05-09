function tf=myjudg(s)
 [height,width,~] =size(s);
    ty=ceil(height/8);
img_gray=rgb2gray(s);
    T=graythresh(img_gray);
    img_bw=imbinarize(img_gray,T);
    histcol1=sum(img_bw);      %计算垂直投影
   % figure; subplot(121),imshow(s); 
   
    [tm,tn]=size(histcol1);
    
    c=zeros(1,5);
    a=[ histcol1 c];
    tw=tn+2;
    b=zeros(tm,tw);
         for u=1:tn
            a(1,u)=(a(1,u)+a(1,u+1)+a(1,u+2)+a(1,u+3)+a(1,u+4)+a(1,u+5))/6;
         end
       %  subplot(122),bar(a);title('垂直投影（含边框）');%输出垂直投影
     for uzi=8:ty
        y=uzi*4;
        for u=1:tw
            if a(u)>y
                b(u)=1;
            end
        end
        count1=0;
        count2=0;
    for u=1:tw-1
        tk=b(u+1)-b(u);
        if tk>0
            count1=count1+1;
        end
        if tk<0
            count2=count2+1;
        end
    end
    n=max(count1,count2);
    if 5<=n&&n<=15
        tf=1;  %判决值
    else
        tf=0;
    end
    if tf==1
        break;
    end
     end
    r=width/height;
    if r>2.74
        r=1;
    else 
        r=0;
    end
    tf=tf*r;
    