function [C3_OUT]=PROCESS_C3(C3_INPUT,C3_W,C3_B)

C3_OUT=[];
for i=1:16
    C3_OUT_temp=zeros(10,10);
    for j=1:6
        SUM_pre=zeros(10,10);
        C3_temp=C3_INPUT(:,((j-1)*14+1):j*14);
        W_temp=C3_W(((j-1)*5+1):j*5,((i-1)*5+1):i*5);
        for m=3:12
            for n=3:12
                sum=0;
                for k=-2:2
                    for l=-2:2
                        sum=sum+C3_temp(m+k,n+l)*W_temp(k+3,l+3);
                    end
                end
                SUM_pre(m-2,n-2)=sum;
            end
        end
        C3_OUT_temp=C3_OUT_temp+SUM_pre;
    end
    C3_OUT=[C3_OUT,C3_OUT_temp+C3_B(1,i)];
end


                


end

