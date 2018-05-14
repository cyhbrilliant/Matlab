function [S2_OUT]=PROCESS_S2(S2_INPUT,S2_W,S2_B)

S2_OUT=[];
for conv=1:6
    S2_temp=zeros(14,14);
    INPUT_temp=S2_INPUT(:,((conv-1)*28+1):conv*28);
    for i=0:13
        for j=0:13
            sum=0;
            for m=1:2
                for n=1:2
                    sum=sum+INPUT_temp(i*2+m,j*2+n);
                end
            end
            S2_temp(i+1,j+1)=sum/4*S2_W(1,conv)+S2_B(1,conv);
        end
    end
    S2_OUT=[S2_OUT,S2_temp];
end






end

