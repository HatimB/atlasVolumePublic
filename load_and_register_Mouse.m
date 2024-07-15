%% Adjustment variables
% Atlas scaling
K = [1 1 1.1]; 
% Atlas rotation [degrees]
Rx = 20; %20
Ry = 0;
Rz = 0;
% Moving volume
dx = 9;% up is positive%7
dy = 0;
dz = 5; % forward is positive%-5
%% System variables
f = filesep; % File separator for the current system
%% Initializing Essential Variables
%%% Transformation matrices
T_Atlas             = eye(4,4);
T_AtlasIntensity    = eye(4,4);
T_Volume            = eye(4,4);

%%% Sampling
Sampling_Atlas  = [1 1 1];
Sampling_Volume = [1 1 1];

%%% Padding extent                    % | X       Y
Padding_Atlas           = zeros(3,2); % |left , right
Padding_AtlasIntensity  = zeros(3,2); % |left , right
Padding_Volume          = zeros(3,2); % |left , right

%% Load Volume
% Here, we load in a .mat file that contains a Volume with 3 dimensions
% where the 1st one is the depth, 2nd is the lateral dimension, and the 3rd
% is the elevation dimension (in ultrasound imaging). The VolumeVoxelSize
% is in micrometers. Please use your own data loading and assign the same
% variable names. (Volume and VolumeVoxelSize)

disp('Loading Volume...');
file_path = '/fakePath/toData/';
file_name = 'myExperimentName';
[Volume,VolumeVoxelSize] = loadVolumeMouse(file_path, file_name);

%% Load Atlas

% https://download.alleninstitute.org/informatics-archive/current-release/mouse_ccf/annotation/ccf_2017/
% https://figshare.com/articles/dataset/Modified_Allen_CCF_2017_for_cortex-lab_allenCCF/25365829

%%%%%%%%%%% allenCCF GitHub repository information %%%%%%%%%%%%%%
% https://github.com/cortex-lab/allenCCF/tree/master

%%%%%%%%%%% npy-matlab GitHub repository information %%%%%%%%%%%%%%
% https://github.com/kwikteam/npy-matlab

disp('Loading Atlas...');
% We used allenCCF and npy-matlab GitHub repositories

% The external files from the mouse atlas we used are:
% 1) structure_tree_safe.csv
% 2) template_volume_10um.npy
% 3) annotation_10.nrrd

% AtlasLabeled is the labeled mouse brain atlas volume from annotation_10.nrrd
% AtlasIntensity is the MRI scan of the mouse brain from template_volume_10um.npy
% AtlasLabels is a structure with labels and brain regions' descriptions from structure_tree_safe.csv
% AtlasVoxelSize is in micrometers

[AtlasLabeled,AtlasIntensity,AtlasLabels,AtlasVoxelSize] = loadAtlasMouse;

%% Plot original volumes
plotMIP(Volume,3,21,'Volume');
plotMIP(Volume,2,22,'Volume');
plotMIP(Volume,1,23,'Volume');
%% Original sizes
OriginalSizeAtlas   = size(AtlasLabeled);
OriginalSizeVolume  = size(Volume);

%% Match sampling
disp("Resampling...")
Sampling_Atlas = Sampling_Atlas*AtlasVoxelSize/VolumeVoxelSize;
N = round(Sampling_Atlas.*OriginalSizeAtlas); % New number of elements
AtlasLabeled    = imresize3(single(AtlasLabeled),N,'nearest');
AtlasIntensity  = imresize3(single(AtlasIntensity),N,'nearest');

%% Scale Atlas
disp("Scaling...")
[AtlasLabeled,T_Atlas] = warpMyVolume(AtlasLabeled,K,T_Atlas,'nearest');
[AtlasIntensity,T_AtlasIntensity] = warpMyVolume(AtlasIntensity,K,T_AtlasIntensity,'linear');

%% Rotate Atlas
disp("Rotating...")
%%% Necessary rotations
[AtlasLabeled,T_Atlas] = rotateMyVolume(AtlasLabeled,90,1,T_Atlas,'nearest');
[AtlasLabeled,T_Atlas] = rotateMyVolume(AtlasLabeled,-90,3,T_Atlas,'nearest');
[AtlasLabeled,T_Atlas] = rotateMyVolume(AtlasLabeled,180,2,T_Atlas,'nearest');

[AtlasIntensity,T_AtlasIntensity] = rotateMyVolume(AtlasIntensity,90,1,T_AtlasIntensity,'linear');
[AtlasIntensity,T_AtlasIntensity] = rotateMyVolume(AtlasIntensity,-90,3,T_AtlasIntensity,'linear');
[AtlasIntensity,T_AtlasIntensity] = rotateMyVolume(AtlasIntensity,180,2,T_AtlasIntensity,'linear');
%%% Adjustment rotations
[AtlasLabeled,T_Atlas] = rotateMyVolume(AtlasLabeled,Rx,1,T_Atlas,'nearest');
[AtlasLabeled,T_Atlas] = rotateMyVolume(AtlasLabeled,Ry,2,T_Atlas,'nearest');
[AtlasLabeled,T_Atlas] = rotateMyVolume(AtlasLabeled,Rz,3,T_Atlas,'nearest');

[AtlasIntensity,T_AtlasIntensity] = rotateMyVolume(AtlasIntensity,Rx,1,T_AtlasIntensity,'linear');
[AtlasIntensity,T_AtlasIntensity] = rotateMyVolume(AtlasIntensity,Ry,2,T_AtlasIntensity,'linear');
[AtlasIntensity,T_AtlasIntensity] = rotateMyVolume(AtlasIntensity,Rz,3,T_AtlasIntensity,'linear');

%% Pad volume
disp("Padding...")
[Volume,AtlasLabeled,Padding_Volume,Padding_Atlas] = ...
    padVolumeToRef(Volume,AtlasLabeled,0,Padding_Volume,Padding_Atlas);
[Volume,AtlasIntensity,Padding_Volume,Padding_AtlasIntensity] = ...
    padVolumeToRef(Volume,AtlasIntensity,0,Padding_Volume,Padding_AtlasIntensity);

%% Move volume
disp("Moving...")
[needToPad,amountToPad] = calculateNeededPad(...
                Padding_Volume,Padding_Atlas,dx,dy,dz,T_Volume);
if needToPad
    disp("More padding...")
    [Volume,Padding_Volume] = padMyVolumeAutomatic(Volume,amountToPad,0,Padding_Volume);
    [AtlasLabeled,Padding_Atlas] = padMyVolumeAutomatic(AtlasLabeled,amountToPad,0,Padding_Atlas);
    [AtlasIntensity,Padding_AtlasIntensity] = padMyVolumeAutomatic(AtlasIntensity,amountToPad,0,Padding_AtlasIntensity);
end
[Volume, T_Volume] = moveMyVolume(Volume,dx,dy,dz,T_Volume);

%% Plot volumes
% plotMIPGrid(Volume,3,'Volume Padded');
% plotMIPGrid(AtlasLabeled,4,'AtlasLabeled Padded');
% plotMIPGrid(AtlasIntensity,5,'AtlasIntensity Padded');

%% Plot superimposed volumes
imfuseMyVolumesGrid(AtlasIntensity,Volume.^2,6,'Superimposition');
%% Show slice
slice_index = round(size(Volume,3)/2);
% imfuseSlice(AtlasLabeled,Volume,slice_index,10,3,13,'Superimposition - Slice');

%% Crop
% Remove volume padding
VolumeCrop = cropMyVolume(OriginalSizeVolume,Volume,Padding_Volume,Padding_Atlas,T_Volume);
AtlasCrop = cropMyVolume(OriginalSizeVolume,AtlasLabeled,Padding_Volume,Padding_Atlas,T_Volume);
AtlasIntensityCrop = cropMyVolume(OriginalSizeVolume,AtlasIntensity,Padding_Volume,Padding_AtlasIntensity,T_Volume);
%%
imfuseMyVolumesGrid(AtlasIntensityCrop,VolumeCrop.^2,7,'Superimposition - Crop');
%% UI Save files
save_whole_volumes = 0;
save_cropped_volumes = 0;

if save_whole_volumes
%     path = uigetdir('','Select directory where to save data');
    if ~exist([file_path,file_name]);mkdir([file_path,file_name]);end
    save([file_path,file_name,f,'Volume.mat'],'Volume','T_Volume','Padding_Volume',...
        'OriginalSizeVolume','Sampling_Volume','VolumeVoxelSize','-v7.3');

    save([file_path,file_name,f,'AtlasLabeled.mat'],'AtlasLabeled','T_Atlas','Padding_Atlas',...
        'OriginalSizeAtlas','Sampling_Atlas','AtlasVoxelSize','AtlasLabels','-v7.3');

    save([file_path,file_name,f,'AtlasIntensity.mat'],'AtlasIntensity','T_AtlasIntensity','Padding_AtlasIntensity',...
        'OriginalSizeAtlas','Sampling_Atlas','AtlasVoxelSize','AtlasLabels','-v7.3');
end

if save_cropped_volumes
%     path = uigetdir('','Select directory where to save data');
    if ~exist([file_path,file_name]);mkdir([file_path,file_name]);end
    save([file_path,file_name,f,'VolumeCrop.mat'],'VolumeCrop','T_Volume','Padding_Volume',...
        'OriginalSizeVolume','Sampling_Volume','VolumeVoxelSize','-v7.3');

    save([file_path,file_name,f,'AtlasCrop.mat'],'AtlasCrop','T_Atlas','Padding_Atlas',...
        'OriginalSizeAtlas','Sampling_Atlas','AtlasVoxelSize','AtlasLabels','-v7.3');

    save([file_path,file_name,f,'AtlasIntensityCrop.mat'],'AtlasIntensityCrop','T_AtlasIntensity','Padding_AtlasIntensity',...
        'OriginalSizeAtlas','Sampling_Atlas','AtlasVoxelSize','AtlasLabels','-v7.3');
end

%% Find Mouse Regions
if save_cropped_volumes
    findMouseRegions(file_path,file_name,AtlasLabels,AtlasCrop)
end
%% Save figures
if save_cropped_volumes
    figure(6)
    saveas(gcf,[file_path,file_name,'\Figure_6.png'])
    figure(7)
    saveas(gcf,[file_path,file_name,'\Figure_7.png'])
end









