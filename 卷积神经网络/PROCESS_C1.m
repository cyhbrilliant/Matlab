function [C1_OUT]=PROCESS_C1(C1_INPUT,C1_W,C1_B)

C1_OUT=[];
for conv=1:6
    W_temp=C1_W(:,((conv-1)*5+1):conv*5); 
    C1_temp=zeros(28,28);
    for i=3:30
        for j=3:30
            sum=0;       
            for m=-2:2
                for n=-2:2
                    sum=sum+W_temp(m+3,n+3)*C1_INPUT(i+m,j+n);
                end
            end
            C1_temp(i-2,j-2)=sum; 
        end
    end
    C1_temp=C1_temp+C1_B(1,conv);
    C1_OUT=[C1_OUT,C1_temp];
end



end

