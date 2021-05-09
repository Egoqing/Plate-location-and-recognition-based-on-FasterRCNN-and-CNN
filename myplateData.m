function [images ,labels]=myplateData(path,p)
% flag='0123456789ABCDEFGHJKLMNPQRSTUVWXYZ';
flag='藏川鄂甘赣贵桂沪黑吉冀津晋京辽鲁蒙闽宁青琼陕苏皖湘新渝豫粤云浙';
% num=length(flag)*N;
% images=zeros(25,15,num);
num=0;
i=1;
while i<=length(flag) 
    char=flag(i);
    imgpath=[path,char,'\'];%D:\腾讯\Tencent Files\综合课设\车牌识别代码\识别code\train_num\trainset_28_28\
    imgDir=dir([imgpath,'*.jpg']);
    num=num+round(numel(imgDir)*p);
    i=i+1;
end
images=zeros(28,28,1,num);
labels=strings(num,1);
% labels_test='';
i=1;
n=1;
% test_n=1;
while i<=length(flag) 
    char=flag(i);
    imgpath=[path,char,'\'];
    imgDir=dir([imgpath,'*.jpg']);
    N=round(numel(imgDir)*p);
    seq=randperm(numel(imgDir));
    seq_train=seq(1:N);
%     seq_test=seq(N:end);
    for j=1:length(seq_train)
        img=imread([imgpath,imgDir(seq_train(j)).name]);
        images(:,:,1,n)=im2double(img);
        labels(n,1)=char;
        n=n+1;
    end
%     for j=1:length(seq_test)
%         img=imread([imgpath,imgDir(seq_test(j)).name]);
%         images_test(:,:,1,test_n)=im2double(img);
%         labels_test=[labels_test,char];
%         test_n=test_n+1;
%     end
    i=i+1;
end
labels=categorical(cellstr(labels));
% labels_test=categorical(cellstr(labels_test));
% train={images_train categorical(cellstr(labels_train))};
% test={images_test categorical(cellstr(labels_test))};
clear N num i test_n  j img char imgDir imgpath seq test_n  seq_train seq_test train_n 
