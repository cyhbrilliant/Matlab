function [data,label] = checkdata( filename)
    data=xlsread(filename,'c3:l44');
    label=zeros(1,length(data(:,1)));
    
    for i=13:42
        label(i)=1;
    end
end

