%function mymain

close all
[filename,pathname]=uigetfile({'*.jpg','car1'});
if(filename==0),return,end
global FILENAME   %����ȫ�ֱ���

 FILENAME=[pathname filename];
 img=imread(FILENAME); 
 Image=img;
 figure,imshow(Image);
 title('ԭͼ��');
 step=1;
[PY1,PY2,PX1,PX2,k,Imageb] =mycolor(Image);
 if(k==0)
   %  Imageb=Image(PY1:PY2,:,:);
    [r,Imagec]=myedge(Imageb);      
         if (r==0)
            close all
        Image(PY1:PY2,PX1:PX2)=zeros(PY2-PY1+1,PX2-PX1+1);
        [~,~,~,~,k2,Imaged] =mycolor(Image);
                     if(k2==0)
                        [r2,Imagee]=myedge(Imaged);   
                         Imagek=Imagee;
                         if r2==0
                             step=0;
                         end
                     else
                         Imagek=Imaged;
                    end
         else
             Imagek=Imagec;
         end       
 else
 Imagek=Imageb;
 end
               
Image1=rgb2hsv(Imagek);
Image2=im2bw(Image1,0.5);
 [Image_corrrct,rot_theta]=mycorrect2(Imagek,Image2);
 Image_corrrct=mylight(Image_corrrct);
 Imaget=mycolor3(Image_corrrct);

        if step==0  %δ�ҵ����ʳ�������
%                           close all
            if exist('FRcnn','var')>0
                fprintf('��ͳ����ʧЧ������Faster-RCNN����\n')
            else
                fprintf('��ͳ����ʧЧ������Faster-RCNN���磬���Ժ�\n')
                tic;load FRcnn480.mat;etime=toc;
                fprintf(['���������ʱ',num2str(etime),'��\n'])  
            end
          	Imagek=FRcnnDetect(img,FRcnn);
            Image1=rgb2hsv(Imagek);
            Image2=im2bw(Image1,0.5);
            [Image_corrrct,rot_theta]=mycorrect2(Imagek,Image2);
            Image_corrrct=mylight(Image_corrrct);
            Imaget=mycolor3(Image_corrrct);
        else
        tk=myjudg(Imaget);
            if   tk==0   %�ҵ��������򣬵���������������
            if exist('FRcnn','var')>0
                fprintf('��ͳ����ʧЧ������Faster-RCNN����\n')
            else
                fprintf('��ͳ����ʧЧ������Faster-RCNN���磬���Ժ�\n')
                tic;load FRcnn480.mat;etime=toc;
                fprintf(['���������ʱ',num2str(etime),'��\n'])  
            end            	
                Imagek=FRcnnDetect(img,FRcnn);
                Image1=rgb2hsv(Imagek);
                Image2=im2bw(Image1,0.5);
                [Image_corrrct,rot_theta]=mycorrect2(Imagek,Image2);
                Image_corrrct=mylight(Image_corrrct);
                Imaget=mycolor3(Image_corrrct);
            end
        end
Image4=rgb2hsv(Imaget);
Image5=im2bw(Image4,0.5);
           
     if  rot_theta>0
         Imaget=mytry6(Imaget);
            Image5=mytry6(Image5);
     end
[row,col,dy,Imaget,Image5]=mytry5(Imaget,Image5,rot_theta);
    if  rot_theta>0
         Imaget=mytry6(Imaget);
        Image5=mytry6(Image5);
    end
  [Imagew,rot_theta2]=mycorrect2(Imaget, Image5);
  if rot_theta*rot_theta2<0
  Imagew=Imaget;
  end
 figure(30),imshow(Imagew),title('�����������ͼƬ');
recognition(Imaget);
% end
% imwrite(Imagew,'D:\��Ѷ\Tencent Files\�ۺϿ���\����ʶ�����\�ָ�code\���⳵��2\866MV.jpg')