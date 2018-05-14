function s=showmha(images,num)
path='d:\datas\';
for i=1:num
    image=images(:,:,i);
    %image=reshape(image,x,y);
    %image=uint8(image);
    figure
    %imshow(image);
    imshow(squeeze(images(:,:,i)),[]);
    saveas(gca,[path,num2str(i)],'jpg');
    close
end
s=image;
