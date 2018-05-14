x=[0,0,1,1;
    0,1,0,1];
y=[1,0,0,0];


p=[-1,1;-1,1];
t=1;


net=newp(p,t);
net=train(net,x,y);
last=sim(net,[0;1]);
