
tic;

p=-9:1:8;
x=-9:.2:8;
t=[129,-32,-118,-138,-125,-97,-55,-23,-4,2,1,-31,-72,-121,-142,-174,-155,-77];
plot(p,t,'o');
hold on;

spread=1;

chdis=dist(x',p);
chgdis=exp(-chdis.^2/spread);
chgdis=chgdis';

y=t*chgdis./(sum(chgdis));

plot(x,y);

toc;
% [~,Q]=size(p);
% [R,S]=size(x);
% 
% yr=zeros(Q,S);
% for i=1:S
%     for j=1:Q
%         v=norm(x(:,i)-p(:,j));
%         yr(j,i)=exp(-v.^2/(2*spread.^2));
%     end
% end
%     
% ya=zeros(2,S);
% % ya(1,:)=t*yr;
% for i=1:S
%         ya(1,i)=sum(t(:,i)*yr(:,i)',2);
%         ya(2,i)=sum(yr(:,i));
% end
% 
% y=ya(1,:)./(eps+ya(2,:));
% 
% % dis=dist(x',x);
% % 
% % yr=exp(-dis.^2/(2*spread.^2));
% 
% % y1=sum(t*yr');
% % y2=sum(yr);
% % 
% % y=y1./y2;
% 
% 
% plot(x,y);

net=newgrnn(p,t,.5);
view(net);