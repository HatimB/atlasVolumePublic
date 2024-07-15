function imfuseMyVolumesSubplot2(V1,V2,dimension,figureNumber,...
                            figureTitle,subPlotDim,compress)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%PLOTMIP Plots a maximum intensity projection (MIP) of a volume along the
%provided dimension. Provide the figureNumber and figureTitle

figure(figureNumber);
subplot(subPlotDim(1),subPlotDim(2),subPlotDim(3))
colormap turbo

% V1 = V1-min(V1,[],'all');
% V1 = V1./max(V1,[],'all');
% V2 = V2-min(V2,[],'all');
% V2 = V2./max(V2,[],'all');


C = imfuse(squeeze(max(V1,[],dimension).^compress), ...
           squeeze(max(V2,[],dimension).^compress),...
    'falsecolor','Scaling','joint','ColorChannels',[2 0 1]);
imshow(C);
title(figureTitle);
axis equal tight



switch dimension
    case 3
        xlabel('Dim 2'); ylabel('Dim 1');
    case 2
        xlabel('Dim 3'); ylabel('Dim 1');
    case 1
        xlabel('Dim 3'); ylabel('Dim 2');
end

end