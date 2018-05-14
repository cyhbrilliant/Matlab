clear all; close all;
addpath(['..', filesep, 'maxflow']);
addpath(['..', filesep, 'lib']);

% %数据读取
% load('../data/medical_imgs.mat','brain_axial');
% img = brain_axial;
img_mha=mha_read_volume('0001.mha');
img=img_mha;


%归一化
img = single(img);
img_n = (img - min(img(:))) / (max(img(:)) - min(img(:)));


%定义大小；label数
[sx, sy,sz] = size(img_n);
numberOfLabels = 5;

% %初始化边缘
% regions = ones(size(img_n),'like', img_n); % background
% for i=2:numberOfLabels
%     d = 20*i;
%     regions(d:sx-d,d:sy-d) = i; % linearly ordered region ids i
% end

V=mha_read_volume('test210_2.mha');
regions=V;
% regions(1:10,1:10,1:10) = 1;
regions=regions+1;


% % 画边缘
% col = 'rgbcmyk';
% figure(); title('Initial regions');
% imshow(img_n,[]);
% hold on; 
% for i=1:numberOfLabels
%    contour(regions == i,col(i));
% end
% hold off;
% drawnow();
% 
% 
Ct = zeros(sx,sy,sz,numberOfLabels);
alpha = zeros(sx,sy,sz,numberOfLabels-1);
% 
% 
maxLevelSetIterations = 15; 
tau = 50;
w1 = 0.8;
w2 = 0.3;
% 
% 
for t=1:maxLevelSetIterations
    
    for i=1:numberOfLabels
        currRegion = regions == i;
        d_speed = ((1-currRegion).*bwdist(currRegion,'Euclidean'))./tau;
        m_int_inside = mean(mean(img_n(currRegion == 1)));
        d_int_inside = abs(img_n - m_int_inside);
        Ct(:,:,:,i) = w1.*(d_int_inside) + w2.*(d_speed);
    end
    alpha = 0.1.*ones(sx,sy,sz,numberOfLabels-1);
    pars = [sx; sy;sz; numberOfLabels; 200; 1e-5; 0.75; 0.16];
    
    [u, conv, numIt, time] = asetsIshikawa3D(Ct, alpha, pars);
% 
%     regions = ones(sx,sy);
%     for i=1:numberOfLabels-1
%         regions = regions + (u(:,:,i) > 0.5);
%     end
%     
%     close all;
%     figure();
%     scrsz = get(0,'ScreenSize');
%     set(gcf,'Position',scrsz);
% 
%     for i=1:3
% %         subplot(1,1,1); 
% %         imshow(Ct(:,:,i),[]); 
% %         title(['Ct(',num2str(i),')']);
%         subplot(1,1,1); 
%         imshow(img_n,[]); 
%         hold on; 
%         contour(regions == i, col(i)); 
%         title(['R_',num2str(i)]);
% %         subplot(3,numberOfLabels,i+2*numberOfLabels); 
% %         imshow(regions == i,[]); 
%     end
%     drawnow();
%     pause(0.5);
        
end
