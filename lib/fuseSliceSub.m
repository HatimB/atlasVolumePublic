function fuseSliceSub(V1,V2,sliceIndex,sliceThickness,dimension,...
                    figureNumber,figureTitle,subPlotSze,subPlotDim,...
                    cmap1,cmap2,alpha1)
%
% HATIM BELGHARBI
% CREATED: 2023-01-04
% LAST MODIFIED: 2023-01-04
%
%OVERLAYSLICESUB Overlays a maximum intensity projection (MIP) of two volumes along the
%provided dimension. Provide the figureNumber, figureTitle, and subplot
%index.
%
% Untested example code for volumes V1 and V2 (same size):
% cmap1 = 'gray';
% cmap2 = 'hot';
% alpha1 = 0.35; % transparency of V1
% slice_pad1 = round(size(V1,3)/4);; % Half pad size
% slice_index1 = round(size(V1,3)/2);
% overlaySliceSub(V1,V2,slice_index1,slice_pad1,...
%         3,1,['Slice ',num2str(slice_index1)],[1,1],1,...
%         cmap1,cmap2,alpha1);

figure(figureNumber);
set(gcf,'color',[0 0 0])
set(gcf, 'InvertHardcopy', 'off')


V1 = V1-min(V1,[],'all');
V1 = V1./max(V1,[],'all');
V2 = V2-min(V2,[],'all');
V2 = V2./max(V2,[],'all');

pad = sliceThickness; % volume slice thickness
alpha2 = 1-alpha1;
compression1 = 1;
compression2 = 1;

switch dimension
    case 3
        im1 = squeeze(mean(V1(:,:,sliceIndex+(-pad:pad)),dimension)).^compression1;
        im1 = im1./max(im1,[],'all');
        im2 = squeeze(mean(V2(:,:,sliceIndex+(-pad:pad)),dimension)).^compression2;
        im2 = im2./max(im2,[],'all');
        
    case 2
        im1 = squeeze(mean(V1(:,sliceIndex+(-pad:pad),:),dimension)).^compression1;
        im2 = squeeze(mean(V2(:,sliceIndex+(-pad:pad),:),dimension)).^compression2;
    
    case 1
        im1 = squeeze(mean(V1(sliceIndex+(-pad:pad),:,:),dimension)).^compression1;
        im2 = squeeze(mean(V2(sliceIndex+(-pad:pad),:,:),dimension)).^compression2;

end

subplot(subPlotSze(1),subPlotSze(2),subPlotDim)
C = imfuse(im1,im2,'falsecolor','Scaling','joint','ColorChannels',[1 2 1]);
imshow(C);

% imagesc(im1,'alphadata',alpha1);axis equal tight;clim([0 0.8])
% imagesc(im2,'alphadata',alpha2);axis equal tight


% set(gcf,'color','none','visible','off');title(figureTitle);
axis equal tight


% set(gcf,'Visible','off');
% ax1.XTick = [];
% ax1.YTick = [];


switch dimension
    case 3
        % xlabel('Dim 2'); ylabel('Dim 1');
    case 2
        % xlabel('Dim 3'); ylabel('Dim 1');
    case 1
        % xlabel('Dim 3'); ylabel('Dim 2');
end


end