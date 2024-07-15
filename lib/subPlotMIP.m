function subPlotMIP(V,dimension,figureNumber,figureTitle,subPlotSze,subPlotDim,cmap)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%PLOTMIP Plots a maximum intensity projection (MIP) of a volume along the
%provided dimension. Provide the figureNumber and figureTitle

figure(figureNumber);
ax = subplot(subPlotSze(1),subPlotSze(2),subPlotDim);
imagesc(squeeze(max(V,[],dimension)));
colormap(ax(1),cmap)
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