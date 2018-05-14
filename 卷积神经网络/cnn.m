% 读入训练图片列表
finlist0=fopen('trainingDigits/trainLIST0.TXT');
finlist1=fopen('trainingDigits/trainLIST1.TXT');
finlist2=fopen('trainingDigits/trainLIST2.TXT');
finlist3=fopen('trainingDigits/trainLIST3.TXT');
finlist4=fopen('trainingDigits/trainLIST4.TXT');
finlist5=fopen('trainingDigits/trainLIST5.TXT');
finlist6=fopen('trainingDigits/trainLIST6.TXT');
finlist7=fopen('trainingDigits/trainLIST7.TXT');
finlist8=fopen('trainingDigits/trainLIST8.TXT');
finlist9=fopen('trainingDigits/trainLIST9.TXT');
[pic,label]=getPic();

WriteData(pic,label);
%定义目标向量
% labels=[1,1,1,1,1,0,0,0,0,0;
%     0,1,1,1,1,1,0,0,0,0;
%     0,0,1,1,1,1,1,0,0,0;
%     0,0,0,1,1,1,1,1,0,0;
%     0,0,0,0,1,1,1,1,1,0;
%     0,0,0,0,0,1,1,1,1,1;
%     1,0,0,0,0,0,1,1,1,1;
%     1,1,0,0,0,0,0,1,1,1;
%     1,1,1,0,0,0,0,0,1,1;
%     1,1,1,1,0,0,0,0,0,1];
labels=[1,0,0,0,0,0,0,0,0,0;
    0,1,0,0,0,0,0,0,0,0;
    0,0,1,0,0,0,0,0,0,0;
    0,0,0,1,0,0,0,0,0,0;
    0,0,0,0,1,0,0,0,0,0;
    0,0,0,0,0,1,0,0,0,0;
    0,0,0,0,0,0,1,0,0,0;
    0,0,0,0,0,0,0,1,0,0;
    0,0,0,0,0,0,0,0,1,0;
    0,0,0,0,0,0,0,0,0,1];

%定义各层权值
C1_W=randn(5,30)./10;
C1_B=randn(1,6)./10;
S2_W=randn(1,6)./10;
S2_B=randn(1,6)./10;
C3_W=randn(30,80)./10;
C3_B=randn(1,16)./10;
S4_W=randn(1,16)./10;
S4_B=randn(1,16)./10;
C5_W=randn(80,600)./10;
C5_B=randn(1,120)./10;
F6_W=randn(121,2000)./10;
F7_W=randn(2001,10)./10;


%定义各控制变量
iter=1000000;
yita=0.00001;



 

%函数处理
for iterator=1:iter 
%     if iterator>500
%        yita=yita/(iter*1/500); 
%     end
        
    %总样本中抽取随机的样本
    choosenum=randi(1934);
    trainpic=pic(:,((choosenum-1)*32+1):choosenum*32);
    trainlabel=label(choosenum);
    C1_INPUT=trainpic;

    %卷积1层
    [C1_OUT]=PROCESS_C1(C1_INPUT,C1_W,C1_B);
    S2_INPUT=C1_OUT;  

    %池化2层
    [S2_OUT]=PROCESS_S2(S2_INPUT,S2_W,S2_B);
    C3_INPUT=relu(S2_OUT);
    %卷积3层
    [C3_OUT]=PROCESS_C3(C3_INPUT,C3_W,C3_B);
    S4_INPUT=C3_OUT;   
    %池化4层
    [S4_OUT]=PROCESS_S4(S4_INPUT,S4_W,S4_B);
    C5_INPUT=relu(S4_OUT);
    %卷积5层
    [C5_OUT]=PROCESS_C5(C5_INPUT,C5_W,C5_B);
    F6_INPUT=C5_OUT; 
    %全连接6层
    [F6_OUT]=PROCESS_F6(F6_INPUT,F6_W);
    F7_INPUT=logsig(F6_OUT);
    %全连接7层
    [F7_OUT]=PROCESS_F7(F7_INPUT,F7_W);
    SOFTMAX_INPUT=F7_OUT;
    %SOFTMAX
    [SOFTMAX_OUT]=PROCESS_SOFTMAX(SOFTMAX_INPUT);
    
    LABEL_OUT=labels(trainlabel+1,:);
    
    %误差反向传播
    ERROR=LABEL_OUT-SOFTMAX_OUT;
    F7_DELTA=ERROR;
    F7_W=F7_W+(yita*F7_DELTA'*[F7_INPUT,1])';
     
    F6_DELTA=F7_DELTA*F7_W(1:end-1,:)'.*dlogsig(1,F7_INPUT);
    F6_W=F6_W+(yita*F6_DELTA'*[F6_INPUT,1])';
    
    C5_DELTA=F6_DELTA*F6_W(1:end-1,:)';
    C5_WDC=[];
    for i=1:120
        C5_WDC=[C5_WDC,C5_INPUT'*C5_DELTA(1,i)];
    end
    C5_W=C5_W+yita*C5_WDC;
    C5_B=C5_B+yita*C5_DELTA;
    
    
    S4_DELTA=zeros(5,80);
    for i=1:120
       S4_DELTA=(S4_DELTA'+C5_DELTA(1,i)*C5_W(:,((i-1)*5+1):(i*5)))';
    end
    S4_INPUT_temp=[];
    for i=1:16
       S4_INPUT_temp=[S4_INPUT_temp,(S4_OUT(:,(i-1)*5+1:i*5)-S4_B(1,i))/S4_W(1,i)]; 
    end
    S4_DW=S4_DELTA.*S4_INPUT_temp; 
    for i=1:16
        S4_W(1:i)=S4_W(1:i)+yita*sum(sum(S4_DW(:,(i-1)*5+1:i*5)));
        S4_B(1:i)=S4_B(1:i)+yita*sum(sum(S4_DELTA(:,(i-1)*5+1:i*5)));
    end
    
    
    C3_DELTA=zeros(10,160);
    for i=1:16
        for m=1:5
            for n=1:5
                C3_DELTA((m-1)*2+1:m*2,(i-1)*10+(n-1)*2+1:(i-1)*10+n*2)=S4_DELTA(m,(i-1)*5+n)*S4_W(1,i);
            end
        end
    end
    C3_WDC=[];
    for i=1:16
        C3_DELTA_temp=C3_DELTA(:,(i-1)*10+1:i*10); 
        C3_WDC_temp=[];
        for j=1:6
            C3_INPUT_temp=C3_INPUT(:,(j-1)*14+1:j*14);
            C3_WDC_Dtemp=zeros(5,5);
            for m=3:12
                for n=3:12
                    C3_WDC_Dtemp=C3_WDC_Dtemp+C3_INPUT_temp(m-2:m+2,n-2:n+2)*C3_DELTA_temp(m-2,n-2);
                end
            end
            C3_WDC_temp=[C3_WDC_temp;C3_WDC_Dtemp];
        end
        C3_WDC=[C3_WDC,C3_WDC_temp];
    end
    C3_BDC=[];
    for i=1:16
        C3_BDC=[C3_BDC,sum(sum(C3_DELTA(:,(i-1)*10+1:i*10)))];
    end
    C3_W=C3_W+yita*C3_WDC;
    C3_B=C3_B+yita*C3_BDC;
        
    
    S2_DELTA=[];
    for i=1:6
        S2_DELTA_temp=zeros(14,14);
        for j=1:16
            C3_W_temp=C3_W((i-1)*5+1:i*5,(j-1)*5+1:j*5);
            C3_DELTA_temp=C3_DELTA(:,(j-1)*10+1:j*10);
            for m=3:12
                for n=3:12
                    S2_DELTA_temp(m-2:m+2,n-2:n+2)=S2_DELTA_temp(m-2:m+2,n-2:n+2)+C3_DELTA_temp(m-2,n-2)*C3_W_temp;
                end
            end
        end
        S2_DELTA=[S2_DELTA,S2_DELTA_temp];
    end
    S2_INPUT_temp=[];
    for i=1:6
        S2_INPUT_temp=[S2_INPUT_temp,(S2_OUT(:,(i-1)*14+1:i*14)-S2_B(1,i))/S2_W(1,i)];
    end
    S2_DW=S2_DELTA.*S2_INPUT_temp;
    for i=1:6
        S2_W(1:i)=S2_W(1:i)+yita*sum(sum(S2_DW(:,(i-1)*14+1:i*14)));
        S2_B(1:i)=S2_B(1:i)+yita*sum(sum(S2_DELTA(:,(i-1)*14+1:i*14)));
    end
    
    
    C1_DELTA=zeros(28,168);
    for i=1:6
        for m=1:14
            for n=1:14
                C1_DELTA((m-1)*2+1:m*2,(i-1)*28+(n-1)*2+1:(i-1)*28+n*2)=S2_DELTA(m,(i-1)*14+n)*S2_W(1,i);
            end
        end
    end
    C1_WDC=[];
    for i=1:6
        C1_DELTA_temp=C1_DELTA(:,(i-1)*28+1:i*28); 
        C1_WDC_temp=zeros(5,5);
        for m=3:30
            for n=3:30
                C1_WDC_temp=C1_WDC_temp+C1_INPUT(m-2:m+2,n-2:n+2)*C1_DELTA_temp(m-2,n-2);
            end
        end
        C1_WDC=[C1_WDC,C1_WDC_temp];
    end
    C1_BDC=[];
    for i=1:6
        C1_BDC=[C1_BDC,sum(sum(C1_DELTA(:,(i-1)*28+1:i*28)))];
    end
    C1_W=C1_W+yita*C1_WDC;
    C1_B=C1_B+yita*C1_BDC;
    Gra7=sum(sum(F7_DELTA.*F7_DELTA))
    Gra6=sum(sum(F6_DELTA.*F6_DELTA))
    Gra5=sum(sum(C5_DELTA.*C5_DELTA))
    Gra4=sum(sum(S4_DELTA.*S4_DELTA))
    Gra3=sum(sum(C3_DELTA.*C3_DELTA))
    Gra2=sum(sum(S2_DELTA.*S2_DELTA))
    Gra1=sum(sum(C1_DELTA.*C1_DELTA))
%     OUT=ones(10,10);
%     
%     OUT(trainlabel+1,:)=ERROR;
%     sum(sum(OUT.*OUT))
    AGra=sum(ERROR.*ERROR)
end

















