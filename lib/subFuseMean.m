function subFuseMean(V,dimension,figureNumber,figureTitle,subPlotSze,subPlotDim,cmap,side)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%PLOTMIP Plots a maximum intensity projection (MIP) of a volume along the
%provided dimension. Provide the figureNumber and figureTitle

figure(figureNumber);
ax = subplot(subPlotSze(1),subPlotSze(2),subPlotDim);
im = squeeze(mean(V,dimension));
if side == 1
    im1 = im;
    im2 = zeros(size(im));
else
    im1 = zeros(size(im));
    im2 = im;
end

C = imfuse(im1,im2,'falsecolor','Scaling','joint','ColorChannels',[1 2 1]);
imshow(C)

% colormap(ax(1),cmap)
title(figureTitle)
axis equal tight

set(ax,'XColor',[1 1 1]); 
set(ax,'YColor',[1 1 1]); 

switch dimension
    case 3
        xlabel('Dim 2 [px]'); ylabel('Dim 1 [px]');
    case 2
        xlabel('Dim 3 [px]'); ylabel('Dim 1 [px]');
    case 1
        xlabel('Dim 3 [px]'); ylabel('Dim 2 [px]');
end

end