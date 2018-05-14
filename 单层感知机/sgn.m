function a = sgn( input )
    
    a=zeros(length(input),1);
    
    for i=1:length(input)
        temp=input(i);
        if temp>0
            a(i)=1;
        else
            a(i)=0;
        end
    end
    
end

