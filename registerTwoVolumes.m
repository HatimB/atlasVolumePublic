clear
f = filesep; % File separator for the current system
%% Addpath
curDir = dir;
addpath(genpath(curDir(1).folder));
file_path = [curDir(1).folder,f,'registerTwoVolumes',f];
mkdir(file_path)
save_figures = 0;
save_whole_volumes = 0;
save_cropped_volumes = 0;
%% Adjustment variables
downSamp = 1; % downsample for faster iterating
% Atlas scaling
K = [1 1 1]; %[length width height]
% Atlas rotation [degrees]
Rx = 0;
Ry = 0;
Rz = -20;
% Moving volume
dx = 0;% up is positive
dy = 0;
dz = 0; % forward is positive
compress = 1; % Compress image for visualization
alpha1 = 0.5; % V1 overlay transparency (alpha2 = 1-alpha1)

colormap1 = gray;
colormap2 = copper;
%% System variables
f = filesep; % File separator for the current system
%% Initializing Essential Variables
%%% Transformation matrices
T1 = eye(4,4);
T2 = eye(4,4);

%%% Sampling
Sampling1 = [1 1 1];
Sampling2 = [1 1 1];

%%% Padding extent      % | X       Y
Padding1  = zeros(3,2); % |left , right
Padding2  = zeros(3,2); % |left , right

%% Load Volumes
disp('Loading Volume...');
%%%%%%%%%%%% LOAD V1 AND V2 HERE %%%%%%%%%%%%%
%%%%%%%%%% We move V1 to match V2 %%%%%%%%%%%%
%%%%%%%% V2 is the reference volume %%%%%%%%%%
% Example volumes
load mri
V1 = squeeze(D);
V2 = V1;
V1(:,round(1:end/2)  ,:) = 0;
[V1,~] = rotateMyVolume(V1,20,3,eye(4),'linear');
V2(:,round(end/2:end),:) = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V1VoxelSize = 1;
V2VoxelSize = V1VoxelSize;
%%% Downsample volumes
V1 = V1(1:downSamp:end,1:downSamp:end,1:downSamp:end);
V2 = V2(1:downSamp:end,1:downSamp:end,1:downSamp:end);

V2VoxelSize = V2VoxelSize*downSamp;
V1VoxelSize = V1VoxelSize*downSamp;
dx = round(dx/downSamp);% up is positive
dy = round(dy/downSamp);
dz = round(dz/downSamp); % forward is positive

%% Plot original volumes
figure(1);clf
set(gcf,'color',[0 0 0])
set(gcf, 'InvertHardcopy', 'off')
idx = 1;
subPlotMean(V1,3,1,'V1',[2,3],idx,colormap1);idx = idx+1;
subPlotMean(V1,2,1,'V1',[2,3],idx,colormap1);idx = idx+1;
subPlotMean(V1,1,1,'V1',[2,3],idx,colormap1);idx = idx+1;
subPlotMean(V2.^compress,3,1,'V2',[2,3],idx,colormap2);idx = idx+1;
subPlotMean(V2.^compress,2,1,'V2',[2,3],idx,colormap2);idx = idx+1;
subPlotMean(V2.^compress,1,1,'V2',[2,3],idx,colormap2);idx = idx+1;

%% Start figure 2
size1 = 2;
size2 = 11;
figure(2);clf
set(gcf,'color',[0 0 0])
set(gcf, 'InvertHardcopy', 'off')

subPlotMean(V2.^compress,3,2,'',[size1,size2],size2+1,colormap2);
subPlotMean(V1,3,2,'Original',[size1,size2],1,colormap1);
set(gcf,'units','normalized','outerposition',[0 0 1 1])

%% Original sizes
OriginalSizeV1 = size(V1);
OriginalSizeV2 = size(V2);

%% Match sampling
disp("Resampling...")
Sampling1 = Sampling1*V1VoxelSize/V2VoxelSize;
N = round(Sampling1.*OriginalSizeV1); % New number of elements
V1  = imresize3(single(V1),N,'linear');

subPlotMean(V2.^compress,3,2,'',[size1,size2],size2+2,colormap2);
subPlotMean(V1,3,2,'Match sampling',[size1,size2],2,colormap1);
%% Scale Atlas
disp("Scaling...")
[V1,T1] = warpMyVolume(V1,K,T1,'linear');
subPlotMean(V2.^compress,3,2,'',[size1,size2],size2+3,colormap2);
subPlotMean(V1.^compress,3,2,'',[size1,size2],3,colormap1);
%% Rotate Atlas
disp("Rotating...")
%%% Adjustment rotations
[V1,T1] = rotateMyVolume(V1,Rx,1,T1,'linear');
[V1,T1] = rotateMyVolume(V1,Ry,2,T1,'linear');
[V1,T1] = rotateMyVolume(V1,Rz,3,T1,'linear');

subPlotMean(V2.^compress,3,2,'',[size1,size2],size2+4,colormap2);
subPlotMean(V1,3,2,'Rotate',[size1,size2],4,colormap1);

%% Pad volume
disp("Padding...")
[V2,V1,Padding2,Padding1] = padVolumeToRef(V2,V1,0,Padding2,Padding1);

subPlotMean(V2.^compress,3,2,'',[size1,size2],size2+5,colormap2);
subPlotMean(V1,3,2,'Pad',[size1,size2],5,colormap1);

compress1 = 1;
compress2 = 1;
imfuseMyVolumesSubplot(V1.^compress2,V2.^compress1,3,2,'Superimpose',...
    [size1,size2],[6 7 size2+6 size2+7],colormap1,colormap2,alpha1)
% imfuseMyVolumesSubplot(AtlasPlot,Volume.^compress,2,2,'',[size1,size2],size2+6)
%% Move volume
disp("Moving...")
[needToPad,amountToPad] = calculateNeededPad(...
                Padding2,Padding1,dx,dy,dz,T2);
if needToPad
    disp("More padding...")
    [V2,Padding2] = padMyVolumeAutomatic(V2,amountToPad,0,Padding2);
    [V1,Padding1] = padMyVolumeAutomatic(V1,amountToPad,0,Padding1);
end
[V2, T2] = moveMyVolume(V2,dx,dy,dz,T2);

imfuseMyVolumesSubplot(V1,V2.^compress,3,2,'Move',...
    [size1,size2],[8 9 size2+8 size2+9],colormap1,colormap2,alpha1)
% imfuseMyVolumesSubplot(AtlasPlot,Volume.^compress,2,2,'',[size1,size2],size2+7)
%% Plot volumes
figure(3);clf
set(gcf,'color',[0 0 0])
set(gcf, 'InvertHardcopy', 'off')
imfuseMyVolumesSubplot(V1,V2.^compress,3,3,'',[1,3],1,colormap1,colormap2,alpha1);
imfuseMyVolumesSubplot(V1,V2.^compress,2,3,'',[1,3],2,colormap1,colormap2,alpha1);
imfuseMyVolumesSubplot(V1,V2.^compress,1,3,'',[1,3],3,colormap1,colormap2,alpha1);

%% Show slice
slice_index = round(size(V2,3)/2)-0;
slice_index2 = round(size(V2,2)/2)-0;

% imfuseSlice(AtlasLabeled,Volume,slice_index,50,3,13,'Superimposition - Slice');
% imfuseSlice(AtlasLabeled,Volume,slice_index2,50,2,14,'Superimposition - Slice');
%%

%% Crop
% Remove volume padding
V2Crop = cropMyVolume(OriginalSizeV2,V2,Padding2,Padding1,T2);
V1Crop = cropMyVolume(OriginalSizeV2,V1,Padding2,Padding1,T2);
%%
imfuseMyVolumesSubplot(V1Crop,V2Crop.^compress,3,2,'Crop',...
    [size1,size2],[10 11 size2+10 size2+11],colormap1,colormap2,alpha1)
% imfuseMyVolumesSubplot(AtlasCrop,VolumeCrop.^compress,2,2,'',[size1,size2],size2+8)
%% Plot going through volume
nblocks = 20;
slice_pad1 = floor(size(V2Crop,3)/(nblocks/2));
slice_pad2 = floor(size(V2Crop,2)/(nblocks/2));
slice_pad3 = floor(size(V2Crop,1)/(nblocks/2));

% nplots = round((size(VolumeCrop,3)-2*slice_pad-1)/skip);
nplots = 4;
subplotSize = [2,round(nplots/2)];
skip = ceil(size(V2Crop,3)/(nplots))-4;

cmap1 = colormap1;
cmap2 = colormap2;
compress = 1;
figure(4);clf
figure(5);clf
figure(6);clf
for idx = 1:nplots
    slice_index1 = idx+slice_pad1+(idx-1)*(skip-1);
    slice_index2 = idx+slice_pad2+(idx-1)*(skip-1);
    slice_index3 = idx+slice_pad3+(idx-1)*(skip-1);

    overlaySliceSub(V1Crop,V2Crop.^compress,slice_index1,slice_pad1,...
        3,4,['Slice ',num2str(slice_index1)],subplotSize,idx,...
        cmap1,cmap2,alpha1);
    overlaySliceSub(V1Crop,V2Crop.^compress,slice_index2,slice_pad2,...
        2,5,['Slice ',num2str(slice_index2)],subplotSize,idx,...
        cmap1,cmap2,alpha1);
    overlaySliceSub(V1Crop,V2Crop.^compress,slice_index3,slice_pad3,...
        1,6,['Slice ',num2str(slice_index3)],subplotSize,idx,...
        cmap1,cmap2,alpha1);
end

%%
if save_figures
    figures_numbers = 1:6;
    for figureNum = figures_numbers
        figure(figureNum);
        saveas(gcf,[file_path,'figure_',num2str(figureNum),'.png'])
        saveas(gcf,[file_path,'figure_',num2str(figureNum),'.svg'])
        saveas(gcf,[file_path,'figure_',num2str(figureNum),'.epsc'])
    end
end
%% UI Save files

if save_whole_volumes
%     path = uigetdir('','Select directory where to save data');
    if ~exist([file_path,file_name]);mkdir([file_path,file_name]);end
    save([file_path,file_name,f,'Volume.mat'],'V2','T2','Padding2',...
        'OriginalSizeV2','Sampling2','V2VoxelSize','-v7.3');

    save([file_path,file_name,f,'AtlasLabeled.mat'],'AtlasLabeled','T_Atlas','Padding_Atlas',...
        'OriginalSizeAtlas','Sampling1','AtlasVoxelSize','AtlasLabels','-v7.3');

    save([file_path,file_name,f,'AtlasIntensity.mat'],'V1','T1','Padding1',...
        'OriginalSizeAtlas','Sampling1','AtlasVoxelSize','AtlasLabels','-v7.3');
end

if save_cropped_volumes
%     path = uigetdir('','Select directory where to save data');
    if ~exist([file_path,file_name]);mkdir([file_path,file_name]);end
    save([file_path,file_name,f,'VolumeCrop.mat'],'V2Crop','T2','Padding2',...
        'OriginalSizeV2','Sampling2','V2VoxelSize','-v7.3');

    save([file_path,file_name,f,'AtlasCrop.mat'],'AtlasCrop','T_Atlas','Padding_Atlas',...
        'OriginalSizeAtlas','Sampling1','AtlasVoxelSize','AtlasLabels','-v7.3');

    save([file_path,file_name,f,'AtlasIntensityCrop.mat'],'V1Crop','T1','Padding1',...
        'OriginalSizeAtlas','Sampling1','AtlasVoxelSize','AtlasLabels','-v7.3');
end

% 
% 
