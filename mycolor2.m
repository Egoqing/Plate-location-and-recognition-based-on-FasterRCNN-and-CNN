function [index,k] = mycolor2(stats,Image)
index=0;
for i=1:length(stats)   
    bb = stats(i).BoundingBox;  % 取预判断的区域  
    s=Image(floor(bb(2))+1:floor(bb(2)+bb(4)),floor(bb(1))+1:floor(bb(1)+bb(3)),:);%    
      I= rgb2hsv(s);  
  [height,width,~] =size(I);
    ty=ceil(height/8);
    img_gray=rgb2gray(s);
    T=graythresh(img_gray);
    img_bw=imbinarize(img_gray,T);
    histcol1=sum(img_bw);      %计算垂直投影
   % figure; subplot(121),imshow(s); 
   
    [tm,tn]=size(histcol1);
    
    c=zeros(1,9);
    a=[ histcol1 c];
    tw=tn+2;
    b=zeros(tm,tw);
         for u=1:tn
            a(1,u)=(a(1,u)+a(1,u+1)+a(1,u+2)+a(1,u+3)+a(1,u+4)+a(1,u+5)+a(1,u+6)+a(1,u+7)+a(1,u+8)+a(1,u+9))/10;
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
   
 
  p=[0.56 0.663 0.3 1 0.1 1 0];
  tp=[0 0 0 0.1 0.8 1];
  count=0;  % 统计蓝色像素值的数量  
  count2=0;
   for h=1:height     
        for w=1:width 
            
        hij = I(h, w, 1);
        sij = I(h, w, 2);
        vij = I(h, w, 3);
        
            if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&& (vij>=p(5)&&vij<=p(6))  %判断该点像素是否为蓝色
            count=count+1;     %蓝色像素累加
            end
             if ( sij >=tp(3)&& sij<=tp(4))&& (vij>=tp(5)&&vij<=tp(6))  %判断该点像素是否为蓝色
            count2=count2+1;     %白色像素累加
            end
         end
    end
 pixel_sum = width*height;   
  ratio_std = 440/140;  
  
     r=width/height;
     if (r>ratio_std-1.9) && (r<ratio_std+1.8) 
         r=1;
     else
         r=0;
     end
       
    if (count>0.4*pixel_sum ) &&r&&(pixel_sum>10000)&&tf
        index = i;     
    end   
end
if index==0
    k=0;
else
    k=1;
end