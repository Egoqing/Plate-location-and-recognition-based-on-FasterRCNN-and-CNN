function Ipchar=char_correct(Ipchar)
img_edg=edge(Ipchar, 'canny');
theta=0:179;
R=radon(img_edg,theta);%���㷨ʵ���Ͻ�����theta����90��ʱ����yp��ת���˵������ޣ���yp��ת����һ���޵�Ч
R1=max(R);
[~,theta_max]=find(R>=max(R1));
if theta_max <= 10 %Ĭ��ԭͼ�񲻿��ܳ���10����Ϊ֮ǰ�����Ѿ����й���б������
    theta_max=-theta_max;%yp���ڵڶ����ޣ���ͼ����ڶ������ᣬ��ʱӦ��˳ʱ����ת��Ӧ��theta��
    Ipchar=imrotate(Ipchar,theta_max,'bilinear','crop');
elseif theta_max>=169
    theta_max=180-theta_max;%ͼ�����һ�����ᣬӦ��˳ʱ����ת180-theta
    Ipchar=imrotate(Ipchar,theta_max,'bilinear','crop');
end

