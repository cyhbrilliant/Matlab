clc
clear
x=[10,20,30,40];
y=[5,10,15,20];
x=[x',ones(1,length(x))'];
[b,bint,r,rint,stats]=regress(y',x);

