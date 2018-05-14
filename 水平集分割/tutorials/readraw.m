function g=readraw(filename,num)
fid=fopen(filename);
fsize=ftell(fid);
 fsize
temp=fread(fid,181*181*num);
images=reshape(temp,181*181,num);
path='d:\data\';
for i=1:num
    image=images(:,i);
    image=reshape(image,181,181);
    image=uint8(image);
    figure
    imshow(image);
    saveas(gca,[path,num2str(i)],'jpg');
    close
end
g=image;
fclose(fid);
