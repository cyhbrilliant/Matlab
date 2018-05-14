x=[4.1,1.8,0.5,2.9,4.0,0.6,3.8,4.3,3.2,1.0,3.0,3.6,3.8,3.7,3.7,8.6,9.1,7.5,8.1,9.0,6.9,8.6,8.5,9.6,10.0,9.3,6.9,6.4,6.7,8.7];
y=[8.1,5.8,8.0,5.2,7.1,7.3,8.1,6.0,7.2,8.3,7.4,7.8,7.0,6.4,8.0,3.5,2.9,3.8,3.9,2.6,4.0,2.9,3.2,4.9,3.5,3.3,5.5,5.0,4.4,4.3];

data=[x;
    y];

[dataone]=mapminmax(data);
x=dataone(1,:);
y=dataone(2,:);

w=rand(2,2);
sigma=0.2;

maxiterator=2000;
for i=1:maxiterator
    k=randi(30);
    ds=dataone(:,k);
    out=w*ds;
    [~,ind]=max(out);
    w(ind,:)=w(ind,:)+sigma*(ds'-w(ind,:)); 
end



x0=[w(1,1),w(2,1)];
y0=[w(1,2),w(2,2)];
plot(x0,y0,'pk');
hold on;
Tout=w*data;
[~,Tind]=max(Tout);

x1=dataone(:,Tind==1);
x2=dataone(:,Tind==2);

plot(x1(1,:),x1(2,:),'o');
plot(x2(1,:),x2(2,:),'*');