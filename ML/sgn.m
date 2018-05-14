function a = sgn( x )
a=zeros(length(x),1);
for i = 1:length(x)
    if x(i)>0.5
        a(i)=1;
    else
        a(i)=0;
    end
end
end

