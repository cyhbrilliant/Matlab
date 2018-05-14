x=50;
% y=x^2;


sigma=0.005;
yr=10^5;

for i=1:10000;
    y=x^3+8*x^2+2*x;
    if abs(y-yr)<10^-100
        break;
    end
    
    x=x-sigma*(3*x^2+8*x+2);
    x
    yr=y;
    
%     sigma=0.9999^i*sigma;
end


fprintf('µü´ú´ÎÊý %d',i);

