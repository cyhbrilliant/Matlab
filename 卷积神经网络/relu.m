function [ input ] = relu( input )
%RELU 此处显示有关此函数的摘要
%   此处显示详细说明

[m,n]=size(input);
for i=1:m
    for j=1:n
        if(input(m,n)<0)
            input(m,n)=0;
        end
    end
end

end

