x=-5:1:5;
y=6*x+3;
randn('state',2);
y=y+randn(1,length(x));
plot(x,y,'o');
hold on;

x=[x;
    ones(1,length(x))];


w=[0,0];  %����ƫ��һ����ά����

lr=0.01; %ѧϰ��

maxiterator=20000;

wr=[10,10];

for i=1:maxiterator
    
    fprintf('�������� %d',i);
    t=w*x;
    e=y-t;
    e  %������
    if (sum(e.^2)/length(e))<0.5
        break;
    end
    
    
        
        
    w=w+lr*e*x';
    w  %���wȨֵ
    
    
    if abs(sum((wr-w).^2))<10^-20;
        break;
    end
    
    
    wr=w;
    
%     lr=0.9999^i*lr;
    
    
    
end



p=-5:.2:5;
o=w(1)*p+w(2);
plot(p,o,'-');
