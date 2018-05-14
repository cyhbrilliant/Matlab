
for k=1:20;
    sigma=0.5*k;

    x=-10:1:10;
    y=-10:1:10;

    for i=1:20
        for j=1:20
            z(i,j)=exp(-(x(i)^2+y(j)^2)/(2*sigma^2));
        end
    end
    
    surf(z);
end






