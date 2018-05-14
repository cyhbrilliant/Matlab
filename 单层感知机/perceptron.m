terminalnum=2000;

x=[0,0,1;
    0,1,1;
    1,0,1;
    1,1,1];
y=[1;0;0;0];

w1=randn(3,5);
w2=randn(6,1);
sigma=0.01;

for i=1:terminalnum


    L1=x*w1;
    L1_x=[L1,ones(4,1)];
    L2=L1_x*w2;
    L2=sgn(L2);
    
    error=y-L2;
    
    w2=w2+sigma*(error'*L1_x)';
    
    delta1=(w2(1:end-1,:)*error')';  
    w1=w1+sigma*(delta1'*x)';
    
    
end