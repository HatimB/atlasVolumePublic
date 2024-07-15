function imfuseSlice(V1,V2,sliceIndex,sliceThickness,dimension,figureNumber,figureTitle)
% 
% HATIM BELGHARBI
% CREATED: 2023-01-04
% LAST MODIFIED: 2023-01-04
%
%IMFUSESLICE Plots a maximum intensity projection (MIP) of a volume along the
%provided dimension. Provide the figureNumber and figureTitle

figure(figureNumber);clf
colormap turbo

V1 = V1-min(V1,[],'all');
V1 = V1./max(V1,[],'all');
V2 = V2-min(V2,[],'all');
V2 = V2./max(V2,[],'all');

pad = sliceThickness; % volume slice thickness

% C = imfuse(squeeze(max(V1(:,:,:),[],dimension)).^(1/3), ...
%            squeeze(max(V2,[],dimension)).^(1/4),...
%     'falsecolor','Scaling','joint','ColorChannels',[2 0 1]);
switch dimension
    case 3
        C = imfuse(squeeze(mean(V1(:,:,sliceIndex+(-pad:pad)),dimension)).^(1/2),...
               squeeze(mean(V2(:,:,sliceIndex+(-pad:pad)),dimension)).^(1/8),...
                'falsecolor','Scaling','joint','ColorChannels',[2 0 1]);
    case 2
        C = imfuse(squeeze(mean(V1(:,sliceIndex+(-pad:pad),:),dimension)).^(1/2),...
               squeeze(mean(V2(:,sliceIndex+(-pad:pad),:),dimension)).^(1/8),...
                'falsecolor','Scaling','joint','ColorChannels',[2 0 1]);
end
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