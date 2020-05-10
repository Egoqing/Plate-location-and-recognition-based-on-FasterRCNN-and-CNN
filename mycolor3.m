function  Imaget=mycolor3(Imaget)
Image=im2double(Imaget);

I=rgb2hsv(Image);
[y,x,z]=size(I);
Blue_y = zeros(y, 1);
white_y = zeros(y, 1);
 
p=[0.56 0.68 0.4 1 0.3 1 3];  %��ɫ�����ǵ���Ӱ��Ӱ�죬�ſ������ȵ�����
  wp=[0 0 0 0.1 0.9 1];   %��ɫ��hsv����
figure;
for i = 1 : y
    for j = 1 : x
        hij = I(i, j, 1);
        sij = I(i, j, 2);
        vij = I(i, j, 3);
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&& (vij>=p(5)&&vij<=p(6))  %�жϸõ������Ƿ�Ϊ��ɫ
            Blue_y(i, 1) = Blue_y(i, 1) + 1;     %��ɫ�����ۼ�
        end
       if( sij >=wp(3)&& sij<=wp(4))&& (vij>=wp(5)&&vij<=wp(6))  %�жϸõ�����Ϊ��ɫ
            white_y(i, 1)=white_y(i, 1) + 1;
        end
    end
    if white_y(i,1)>=5
       white_y(i,1)=1;
    else
        white_y(i,1)=0;
   end
end
 Bluewhite_y=Blue_y .*white_y ;
[bulelong, MaxY] = max(Blue_y);   %�ҵ���ɫ���ؿ�����һ��
Th = p(7);
PY1 = MaxY;
while ((Blue_y(PY1,1)>Th) && (PY1>1))  %����Ѱ����Ȼ������ɫɫ�������
    PY1 = PY1 - 1;
end
PY2 = MaxY;
while ((Blue_y(PY2,1)>Th) && (PY2<y))   %����Ѱ����Ȼ������ɫɫ�������
    PY2 = PY2 + 1;
end
PY1 = PY1 - 5;
PY2 = PY2 + 5;
if PY1 < 1
    PY1 = 1;
end
if PY2 > y
    PY2 = y;   %��ֹ������������ά��
end
It=Image(PY1:PY2,:,:);
subplot(231),imshow(It);
IY = I(PY1:PY2, :, :);
subplot(232),imshow(IY);
I2=im2bw(IY,0.5);
subplot(233),imshow(I2);   %ȷ������Ӧ������

[y1,x1,z1]=size(IY);
Blue_x=zeros(1,x1);
for j = 1 : x1
    for i = 1 : y1
        hij = IY(i, j, 1);
        sij = IY(i, j, 2);
        vij = IY(i, j, 3);
        if (hij>=p(1) && hij<=p(2)) &&( sij >=p(3)&& sij<=p(4))&&(vij>=p(5)&&vij<=p(6))
            Blue_x(1, j) = Blue_x(1, j) + 1; 
        end
    end
end

[~, MaxX] = max(Blue_x);
PX1=1;
PX2=x1;


while ((Blue_x(1,PX1)<1) && (PX1<MaxX))
    PX1 = PX1 + 1;
end

while ((Blue_x(1,PX2)<1) && (PX2>MaxX))
    PX2 = PX2 - 1;
end
if PX1 < 1
    PX1 = 1;
end
if PY2 > x1
    PY2 = x1;   %��ֹ������������ά��
end
Ita=Image(PY1:PY2,PX1:PX2,:);
subplot(234),imshow(Ita);
IX = I(PY1:PY2, PX1:PX2, :);
subplot(235),imshow(IX);
I3=im2bw(IX,0.5);
subplot(236),imshow(I3);   %ȷ���ö�Ӧ������
Imaget=Image(PY1:PY2,PX1:PX2,:);

%weigth=PY2-PY1;
%length=PX2-PX1;
%ratio_std = 440/140;  
%r=length*weigth;
     
    end