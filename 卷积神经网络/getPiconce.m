function [ pic,label ] = getPiconce( filename,number )
pic=[];
label=[];
finlist=fopen(filename);
while ~feof(finlist)
    pline=fgetl(finlist);
    txttrain='trainingDigits/';
    txttrain=[txttrain,pline];
    fin=fopen(txttrain);                               % 打开图片txt文件
    photo=[];
    while ~feof(fin)                                      % 判断是否为文件末尾
        tline=fgetl(fin);                         % 从文件读行
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

