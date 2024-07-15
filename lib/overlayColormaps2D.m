function overlayColormaps2D(im1,im2,cmap1,cmap2,alpha1,alpha2)
%overlayColormaps2D Overlays 2 images (im1 and im2) using imagesc on top of eachother and
%with transparencies alpha1 and alpha2

% Example code
% load mri;D = squeeze(D);D2 = zeros(size(D));
% D2(round(end/3:end/2),round(end/3:2*end/3),:) = D(round(end/3:end/2),round(end/3:2*end/3),:);
% im1 = mean(D,3);im2 = mean(D2,3);
% alpha = 0.5;
% figure;
% overlayColormaps2D(im1,im2,'gray','hot',1-alpha,alpha)

    ax1 = axes;
    imagesc(im1,'alphadata',alpha1);axis equal tight
    
    ax2 = axes;
    imagesc(im2,'alphadata',alpha2);axis equal tight
    
    linkaxes([ax1,ax2]);

    ax2.Visible = 'off';
    ax2.XTick = [];
    ax2.YTick = [];

    colormap(ax1,cmap1);
    colormap(ax2,cmap2);

    set(ax2,'color','none','visible','off');
    
    ax1.Visible = 'off';
    ax1.XTick = [];
    ax1.YTick = [];

    % Sources:
    % https://www.mathworks.com/matlabcentral/answers/475448-how-to-overlay-two-colormaps-using-imagesc-command
    % https://www.mathworks.com/matlabcentral/answers/272371-how-can-i-overlay-pseudocolor-images-with-different-colormaps
end