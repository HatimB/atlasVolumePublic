function fuseMyVolumesSubplot(V1,V2,dimension,figureNumber,...
            figureTitle,subPlotSze,subPlotDim,cmap1,cmap2,alpha1)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%PLOTMIP Plots a maximum intensity projection (MIP) of a volume along the
%provided dimension. Provide the figureNumber and figureTitle

figure(figureNumber);
ax = subplot(subPlotSze(1),subPlotSze(2),subPlotDim);

set(ax,'color',[0 0 0])
set(gcf, 'InvertHardcopy', 'off')

V1 = V1-min(V1,[],'all');
V1 = V1./max(V1,[],'all');
V2 = V2-min(V2,[],'all');
V2 = V2./max(V2,[],'all');

alpha2 = 1-alpha1;
compression1 = 0.5;
compression2 = 0.5;

im1 = squeeze(mean(V1,dimension)).^(compression1);
im2 = squeeze(mean(V2,dimension)).^(compression2);

ax1 = ax;
subplot(subPlotSze(1),subPlotSze(2),subPlotDim,ax1)
C = imfuse(im1,im2,'falsecolor','Scaling','joint','ColorChannels',[1 2 1]);
imshow(C);set(ax1,'XColor',[1 1 1]); axis equal tight;
set(ax1,'YColor',[1 1 1]); 

switch dimension
    case 3
        xlabel('Dim 2'); ylabel('Dim 1');
    case 2
        xlabel('Dim 3'); ylabel('Dim 1');
    case 1
        xlabel('Dim 3'); ylabel('Dim 2');
end

% ax2 = axes;
% subplot(subPlotSze(1),subPlotSze(2),subPlotDim,ax2)
% imagesc(im2,'alphadata',alpha2);axis equal tight


% linkaxes([ax1,ax2]);

% ax2.Visible = 'off';
% ax2.XTick = [];
% ax2.YTick = [];

colormap(ax1,cmap1);
% colormap(ax2,cmap2);

% set(ax2,'color','none','visible','off');title(figureTitle);
axis equal tight


% ax1.Visible = 'off';
% ax1.XTick = [];
% ax1.YTick = [];

title(figureTitle);


end