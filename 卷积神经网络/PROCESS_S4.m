function [S4_OUT]=PROCESS_S4(S4_INPUT,S4_W,S4_B);

S4_OUT=[];
for conv=1:16
    S4_temp=zeros(5,5);
    INPUT_temp=S4_INPUT(:,((conv-1)*10+1):conv*10);
    for i=0:4
        for j=0:4
            sum=0;
            for m=1:2
                for n=1:2
                    sum=sum+INPUT_temp(i*2+m,j*2+n);
                end
            end
            S4_temp(i+1,j+1)=sum/4*S4_W(1,conv)+S4_B(1,conv);
        end
    end
    S4_OUT=[S4_OUT,S4_temp];
end

end

