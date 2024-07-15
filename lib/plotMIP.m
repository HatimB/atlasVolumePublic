function plotMIP(V,dimension,figureNumber,figureTitle)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%PLOTMIP Plots a maximum intensity projection (MIP) of a volume along the
%provided dimension. Provide the figureNumber and figureTitle

figure(figureNumber);clf
colormap turbo
imagesc(squeeze(max(V,[],dimension)));
title(figureTitle)
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