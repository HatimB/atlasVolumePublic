function subPlotMIPNoLabels(V,dimension,figureNumber,figureTitle,subPlotDim)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%PLOTMIP Plots a maximum intensity projection (MIP) of a volume along the
%provided dimension. Provide the figureNumber and figureTitle

figure(figureNumber);
subaxis(subPlotDim(1),subPlotDim(2),subPlotDim(3),...
    'SpacingVert',0,'MR',0,...
    'SpacingHoriz',0,'MT',0)

colormap turbo
imagesc(squeeze(max(V,[],dimension)));
% title(figureTitle)
axis equal tight
set(gca,'XTick',[])
set(gca,'YTick',[])

% switch dimension
%     case 3
%         xlabel('Dim 2'); ylabel('Dim 1');
%     case 2
%         xlabel('Dim 3'); ylabel('Dim 1');
%     case 1
%         xlabel('Dim 3'); ylabel('Dim 2');
% end

end