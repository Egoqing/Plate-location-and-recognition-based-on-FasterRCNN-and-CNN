function rgb1=mylight(rgb)
[m,n,~] = size(rgb); %��ȡͼƬ��С 
hsv = rgb2hsv(rgb);  %��ɫ�ռ�ת�� 
H = hsv(:,:,1); % ɫ�� 
S = hsv(:,:,2); % ���Ͷ� 
V = hsv(:,:,3); % ����

for i = 1:m     %����ÿһ�����ص㣬���Ը�����Ҫѡ���Լ���Ҫ��������� 
    for j = 1: n 
       hsv(i,j,3) =0.2+hsv(i,j,3);  
       if hsv(i,j,3)>=1
           hsv(i,j,3)=1;
       end
    end 
end

rgb1 = hsv2rgb(hsv);   %תΪRGB��������ʾ 

