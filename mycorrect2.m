function [Image_corrrct,rot_theta]=mycorrect2(Imagek,I2)

I3 = edge(I2, 'canny','vertical');
figure,subplot(121), imshow(I3); 
theta = 0 : 179;
r = radon(I3, theta);
[m, n] = size(r);
c = 1;
for i = 1 : m  
    for j = 1 : n   
        if r(1,1) < r(i,j)     
            r(1,1) = r(i,j);      
            c = j;    
        end
    end
end
rot_theta = 90 - c;
I5 = imrotate(Imagek, rot_theta, 'loose');
Image_corrrct=I5;
subplot(122), imshow(I5);title('Ðý×ªºóµÄÍ¼Æ¬');
