% 
% [data,label]=getdataxls('成绩汇总.xlsx');
% data=data';
% % data=toone(data);
% 
% net=newgrnn(data,label);
% 
% 
% [chdata,chlabel]=checkdata('成绩汇总.xlsx');
% chdata=chdata';
% % chdata=toone(chdata);
% out=sim(net,chdata);

% data=[0,0,1,1;
%     0,1,0,1];
% label=[1,0,0,1];

% net=newrb(data,label);
% y=sim(net,data)
tic;
data=-9:1:8;
x=-9:.2:8;
label=[129,-32,-118,-138,-125,-97,-55,-23,-4,2,1,-31,-72,-121,-142,-174,-155,-77];

spread=5;

plot(data,label,'o');
hold on;
dis=dist(data',data);

gdis=exp(-dis.^2/spread);%gauss

G=[gdis,ones(length(data(1,:)),1)];%广义rbf网络

w=G\label';


y=G*w;

chdis=dist(x',data);
chgdis=exp(-chdis.^2/spread);
chG=[chgdis,ones(length(x(1,:)),1)];
chy=chG*w;
plot(x,chy);
toc;
