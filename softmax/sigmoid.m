function sig = sigmoid( x )
    %logsigmoid
    sig=zeros(1,length(x));
    for i=1:length(x)
        sig(i)=1/(1+exp(-x(i)));
    end
    
end

