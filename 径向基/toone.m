function [ dataone ] = toone(data )
dataavg=sum((data'))/length(data(1,:));

for i=1:length(data(1,:))
    data(:,i)=data(:,i)-dataavg';
end

datastd=zeros(1,length(data(:,1)));
for i=1:length(data(:,1))
    datastd(i)=std(data(i,:));
    data(i,:)=data(i,:)/datastd(i);
end

dataone=[data;
    ones(1,length(data(1,:)))];


end

