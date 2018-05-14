function [ ] = WriteData( pic,label )
    
Tfid=fopen('trainData.txt','w');
Lfid=fopen('trainLabel.txt','w');
for P=0:1933
    for i=1:32
        for j=1:32
            fprintf(Tfid,'%d',pic(i,P*32+j));            
        end
    end
    fprintf(Lfid,'%d',label(1,P+1));
    fprintf(Tfid,'\n');
end

            


end
