input1=randn(160,30);
addone=ones(160,1);

input1=[input1,addone];




w1=rand(31,400)*0.01;
w2=rand(401,500)*0.01;
w3=rand(501,200)*0.01;
w4=rand(201,10)*0.01;


label=[1,0,0,0,0,0,0,0,0,0;
    0,1,0,0,0,0,0,0,0,0;
    0,0,1,0,0,0,0,0,0,0;
    0,0,0,1,0,0,0,0,0,0;
    0,0,0,0,1,0,0,0,0,0;
    0,0,0,0,0,1,0,0,0,0;
    0,0,0,0,0,0,1,0,0,0;
    0,0,0,0,0,0,0,1,0,0;
    0,0,0,0,0,0,0,0,1,0;
    0,0,0,0,0,0,0,0,0,1];
label=[label;label;label;label;label;label;label;label;label;label;label;label;label;label;label;label];
% label=[label;label;label;label;label;label;label;label;label;label];
maxiter=100000;
yita=0.00003;

errx=ones(8,10);

tic;
for iter=1:100000
    num=randi(128);
    
   out1=input1*w1;
   input2_te=relu(out1);
   
   
   input2=[input2_te,addone];
   out2=input2*w2;
   input3_te=relu(out2);
   
   input3=[input3_te,addone];
   out3=input3*w3;
   input4_te=relu(out3);
   
   input4=[input4_te,addone];
   out4=input4*w4;
   
   p=exp(out4);
   
   for i=1:160
        p(i,:)=p(i,:)./sum(p(i,:));
   end

   err=label-p;
   
   
   
   delta4=err;
   dwx4=yita*delta4'*input4;
   w4=w4+dwx4';
   delta3=delta4*w4(1:end-1,:)';
   dwx3=yita*delta3'*input3;
   w3=w3+dwx3';
   delta2=delta3*w3(1:end-1,:)';
   dwx2=yita*delta2'*input2;
   w2=w2+dwx2';
   delta1=delta2*w2(1:end-1,:)';
   dwx1=yita*delta1'*input1;
   w1=w1+dwx1';
   
   errx=err;
   
   det3=sum(sum(errx.*errx))
%    det1=sum(sum(delta1.*delta1))
   if sum(sum(errx.*errx))<10^-4
       break;
   end
end


toc;