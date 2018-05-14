% f1=feedforwardnet([3,5,2,4]);
% view(f1);
% 
% f2=cascadeforwardnet([3,5,4,2]);
% view(f2);
% f3=cascadeforwardnet([3,5]);
% view(f3);


% [data,label]=getdataxls('成绩汇总.xlsx');
% data=data';



% data=[0,0,1,1;
%     0,1,0,1];
% 
% label=[1,0,0,1];


data=-5:.5:5;
randn('state',2);
label=sin(2*data)+randn(1,length(data));
plot(data,label,'o');
hold on;
data=[data;
    ones(1,length(data))];

net.nIn=1;
net.nHidden=3;
net.nOut=1;

w=2*(rand(net.nHidden,net.nIn)-1/2);
b=2*(rand(net.nHidden,1)-1/2);
net.w1=[w,b];

W=2*(rand(net.nOut,net.nHidden)-1/2);
B=2*(rand(net.nOut,1)-1/2);
net.w2=[W,B];



% data=toone(data);

maxiterator=10000;
eb=0.001;
sigma=0.01;  %学习率
alpha=0.8;  %动态因子

errf=ones(1,length(data(1,:)));

w2foward=net.w2;
w1foward=net.w1;
seeline=zeros(1,maxiterator);
for i=1:maxiterator
    
    input1=net.w1*data;
    out1=logsig(input1);
    input2_temp=[out1;
        ones(1,length(out1(1,:)))];
    
    input2=net.w2*input2_temp;
    out2=input2;
    
    err=label-out2;err
    see=sumsqr(err);out2
    
    
    if see<eb
        break;
    end
    
    deltaw2=sigma*(1-alpha)*(err)*input2_temp'+alpha*w2foward;
    deltaw1=sigma*(1-alpha)*(net.w2(:,1:end-1)'*err.*dlogsig(input1,out1))*data'+alpha*w1foward;
    
    if i==1
        deltaw2=sigma*err*input2_temp';
        deltaw1=sigma*(net.w2(:,1:end-1)'*err.*dlogsig(input1,out1))*data';
    end
    
    net.w2=net.w2+deltaw2;
    net.w1=net.w1+deltaw1;
    
    
    
    w2foward=deltaw2;
    w1foward=deltaw1;
    
    if sumsqr(errf-err)<10^-5
        break;
    end
        
    seeline(i)=see;
    
    
end

chdata=-5:.1:5;
chdata=[chdata;
    ones(1,length(chdata))];
chinput1=net.w1*chdata;
chout1=logsig(chinput1);
chinput2_temp=[chout1;
    ones(1,length(chout1(1,:)))];

chinput2=net.w2*chinput2_temp;

plot(chdata,chinput2,'-');

% [chdata,chlabel]=checkdata('成绩汇总.xlsx');
% 
% chdata=chdata';
% 
% chdata=toone(chdata);
% 
% chinput1=net.w1*chdata;
% chout1=logsig(chinput1);
% chinput2_temp=[chout1;
%     ones(1,length(chout1(1,:)))];
% 
% chinput2=net.w2*chinput2_temp;
% 
% cherr=chlabel-chinput2;
% 
% ch=char(1,42);
% 
% for i=1:42
%     if(chinput2(i)>0.5)
%        ch(i)='男' ;
%     else
%         ch(i)='女';
%     end
%     
% end


