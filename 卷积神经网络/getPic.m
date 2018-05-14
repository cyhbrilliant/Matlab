function [ pic,label ] = getPic()

pic=[];
label=[];
[piconce0,labelonce0]=getPiconce('trainingDigits/trainLIST0.TXT',0);
[piconce1,labelonce1]=getPiconce('trainingDigits/trainLIST1.TXT',1);
[piconce2,labelonce2]=getPiconce('trainingDigits/trainLIST2.TXT',2);
[piconce3,labelonce3]=getPiconce('trainingDigits/trainLIST3.TXT',3);
[piconce4,labelonce4]=getPiconce('trainingDigits/trainLIST4.TXT',4);
[piconce5,labelonce5]=getPiconce('trainingDigits/trainLIST5.TXT',5);
[piconce6,labelonce6]=getPiconce('trainingDigits/trainLIST6.TXT',6);
[piconce7,labelonce7]=getPiconce('trainingDigits/trainLIST7.TXT',7);
[piconce8,labelonce8]=getPiconce('trainingDigits/trainLIST8.TXT',8);
[piconce9,labelonce9]=getPiconce('trainingDigits/trainLIST9.TXT',9);

pic=[piconce0,piconce1,piconce2,piconce3,piconce4,piconce5,piconce6,piconce7,piconce8,piconce9];
label=[labelonce0,labelonce1,labelonce2,labelonce3,labelonce4,labelonce5,labelonce6,labelonce7,labelonce8,labelonce9];
end

