function [ input ] = relu( input )
%RELU �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

[m,n]=size(input);
for i=1:m
    for j=1:n
        if(input(m,n)<0)
            input(m,n)=0;
        end
    end
end

end

