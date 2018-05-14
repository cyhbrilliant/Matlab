clear all; close all;
addpath(['..', filesep, 'maxflow']);
addpath(['..', filesep, 'lib']);
CUT=115;
% %数据读取
% load('../data/medical_imgs.mat','brain_axial');
% img = brain_axial;
img_mha=mha_read_volume('0001.mha');
% img=img_mha(:,:,CUT);
% %归一化
% img = single(img);
% img_n = (img - min(img(:))) / (max(img(:)) - min(img(:)));



%定义大小；label数

numberOfLabels = 2;
V=mha_read_volume('test210_2.mha');


for CUT=90:120
    
    img=img_mha(:,:,CUT);
    %归一化
    img = single(img);
    img_n = (img - min(img(:))) / (max(img(:)) - min(img(:)));
%     img_n=imrotate(img_n,90);
    [sx, sy] = size(img_n);
    regions=V(:,:,CUT);
%     regions=imrotate(regions,90);
    for i=1:240
        for j=1:240
            if regions(i,j)>0
               regions(i,j)=1;
            end
        end
    end
    % regions(1:10,1:10) = 1;
    regions=regions+1;


    % 画边缘
    col = 'rgbcmyk';
    figure(); title('Initial regions');
    imshow(img_n,[]);
    hold on; 
    for i=1:numberOfLabels
       contour(regions == i,col(i));
    end
    hold off;
    drawnow();


    Ct = zeros(sx,sy,numberOfLabels);
    alpha = zeros(sx,sy,numberOfLabels-1);


    maxLevelSetIterations = 5; 
    tau = 50;
    w1 = 0.9;
    w2 = 0.1;


    for t=1:maxLevelSetIterations

        for i=1:numberOfLabels
            currRegion = regions == i;
            d_speed = ((1-currRegion).*bwdist(currRegion,'Euclidean'))./tau;
            m_int_inside = mean(mean(img_n(currRegion == 1)));
            d_int_inside = abs(img_n - m_int_inside);
            Ct(:,:,i) = w1.*(d_int_inside) + w2.*(d_speed);
        end
        alpha = 0.1.*ones(sx,sy,numberOfLabels-1);
        pars = [sx; sy; numberOfLabels; 200; 1e-5; 0.75; 0.16];

        [u, conv, numIt, time] = asetsIshikawa2D(Ct, alpha, pars);

        regions = ones(sx,sy);
        for i=1:numberOfLabels-1
            regions = regions + (u(:,:,i) > 0.5);
        end

        close all;
        figure();
        scrsz = get(0,'ScreenSize');
        set(gcf,'Position',scrsz);

        for i=1:numberOfLabels
    %         subplot(1,1,1); 
    %         imshow(Ct(:,:,i),[]); 
    %         title(['Ct(',num2str(i),')']);
            subplot(1,1,1); 
            imshow(img_n,[]); 
            hold on; 
            contour(regions == i, col(i)); 
            title(['R_',num2str(i)]);
    %         subplot(3,numberOfLabels,i+2*numberOfLabels); 
    %         imshow(regions == i,[]); 
        end
        drawnow();
        pause(0.5);
    end
    
    for i=1:240
        for j=1:240
            if regions(i,j)==1
                regions(i,j)=0;
            end
            
            if V(i,j,CUT)~=2
                if V(i,j,CUT)~=0
                   regions(i,j)=V(i,j,CUT); 
                end
            end
            
        end
    end
    
    V(:,:,CUT)=regions;
end







