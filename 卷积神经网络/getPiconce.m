function [ pic,label ] = getPiconce( filename,number )
pic=[];
label=[];
finlist=fopen(filename);
while ~feof(finlist)
    pline=fgetl(finlist);
    txttrain='trainingDigits/';
    txttrain=[txttrain,pline];
    fin=fopen(txttrain);                               % ��ͼƬtxt�ļ�
    photo=[];
    while ~feof(fin)                                      % �ж��Ƿ�Ϊ�ļ�ĩβ
        tline=fgetl(fin);                         % ���ļ�����
        phototemp=zeros(1,32);
        for i=1:32
            phototemp(1,i)=tline(i)-48;
        end
        photo=[photo;
            phototemp];
    end
    pic=[pic,photo];
    label=[label,number];
    fclose(fin);
end


end

