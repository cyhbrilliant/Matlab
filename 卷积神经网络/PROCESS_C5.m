function [C5_OUT]=PROCESS_C5(C5_INPUT,C5_W,C5_B)


C5_OUT=[];
for i=1:120
    C5_OUT_temp=zeros(1,1);
    for j=1:16
        SUM_pre=zeros(1,1);
        C5_temp=C5_INPUT(:,((j-1)*5+1):j*5);
        W_temp=C5_W(((j-1)*5+1):j*5,((i-1)*5+1):i*5);
        sum=0;
        for k=-2:2
            for l=-2:2
                sum=sum+C5_temp(3+k,3+l)*W_temp(k+3,l+3);
            end
        end
        SUM_pre(1,1)=sum;
        C5_OUT_temp=C5_OUT_temp+SUM_pre;
    end
    C5_OUT=[C5_OUT,C5_OUT_temp+C5_B(1,i)];
end


end

