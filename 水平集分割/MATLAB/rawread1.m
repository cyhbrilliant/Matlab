function f=rawread1(filename,num)
fid=fopen(filename);
fsize=ftell(fid);
temp=fread(fid,181*217*181);
images=reshape(temp,217*181,181);
path='d:\data\';
for i=1:num
    image=images(:,i);
    image=reshape(image,181,217);
    image=uint8(image);
    figure
    imshow(image);
    saveas(gca,[path,num2str(i)],'jpg');
    close
end
g=image;
fclose(fid);

