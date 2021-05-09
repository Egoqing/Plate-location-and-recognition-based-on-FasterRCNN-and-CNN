function rgb1=mylight(rgb)
[m,n,~] = size(rgb); %读取图片大小 
hsv = rgb2hsv(rgb);  %颜色空间转换 
H = hsv(:,:,1); % 色调 
S = hsv(:,:,2); % 饱和度 
V = hsv(:,:,3); % 亮度

for i = 1:m     %遍历每一个像素点，可以根据需要选择自己需要处理的区域 
    for j = 1: n 
       hsv(i,j,3) =0.2+hsv(i,j,3);  
       if hsv(i,j,3)>=1
           hsv(i,j,3)=1;
       end
    end 
end

rgb1 = hsv2rgb(hsv);   %转为RGB，进行显示 

