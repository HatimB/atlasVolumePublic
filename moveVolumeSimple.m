%% Saving
save_whole_volumes      = 0;   % 1: save | 0: do not save
save_cropped_volumes    = 0;   % 1: save | 0: do not save
%% System variables
f = filesep; % File separator for the current system
%% Initializing Essential Variables
%%% Transformation matrices
T_V2 = eye(4,4);
T_V1 = eye(4,4);

%%% Sampling
Sampling_V2     = [1 1 1];
Sampling_V1     = [1 1 1];

%%% Padding extent                  % | X       Y
Padding_V2          = zeros(3,2);   % |left , right
Padding_V1          = zeros(3,2);   % |left , right

%% Load V1 (Reference)
disp('Loading Volume 1...');
load mri;
D   = double(squeeze(D));
D2 = D(15:end,12:114,:);
V1 = D;
V1VoxelSize = 1;
plotMIPGrid(V1,1,'V1 - Original');

%% Load V2 (Moving)
disp('Loading Volume 2...');
V2 = D2;
V2(:,:,end:end+10) = 0;V2(:,end:end+10,:) = 0;V2(end:end+10,:,:) = 0;
V2VoxelSize = 1;
plotMIPGrid(V2,2,'V2 - Original');

%% Original sizes
OriginalSizeV2 = size(V2);
OriginalSizeV1 = size(V1);

%% Pad volume
disp("Padding...")
[V1,V2,Padding_V1,Padding_V2] = ...
    padVolumeToRef(V1,V2,0,Padding_V1,Padding_V2);

%% Move volume
disp("Moving...")
dx = 12;% up is positive
dy = 5;
dz = 6; % forward is positive
[needToPad,amountToPad] = calculateNeededPad(...
                Padding_V1,Padding_V2,dx,dy,dz,T_V1);
if needToPad
    disp("More padding...")
    [V1,Padding_V1] = padMyVolumeAutomatic(V1,amountToPad,0,Padding_V1);
    [V2,Padding_V2] = padMyVolumeAutomatic(V2,amountToPad,0,Padding_V2);
end
[V1, T_V1] = moveMyVolume(V1,dx,dy,dz,T_V1);
%% Plot volumes
plotMIPGrid(V1,3,'V1 Padded');
plotMIPGrid(V2,4,'V2 Padded');

%% Plot superimposed volumes
imfuseMyVolumes(V2,V1,3,5,'Superimposition');

%% Show slice
slice_index = round(size(V1,3)/2);
imfuseSlice(V2,V1,slice_index,10,3,13,'Superimposition - Slice');

%% Crop to V1's original size
% Remove volume padding
V1Crop = cropMyVolume(OriginalSizeV1,V1,Padding_V1,Padding_V2,T_V1);
V2Crop = cropMyVolume(OriginalSizeV1,V2,Padding_V1,Padding_V2,T_V1);

imfuseMyVolumesGrid(V2Crop,V1Crop,6,'Crop');
plotMIPGrid(V1Crop,7,'Crop');

%% UI Save files

if save_whole_volumes
    path = uigetdir('','Select directory where to save data');

    save([path,f,'V1.mat'],'V1','T_V1','Padding_V1',...
        'OriginalSizeV1','Sampling_V1','V1VoxelSize','-v7.3');

    save([path,f,'V2.mat'],'V2','T_V2','Padding_V2',...
        'OriginalSizeV2','Sampling_V2','V2VoxelSize','AtlasLabels','-v7.3');
end

if save_cropped_volumes
    path = uigetdir('','Select directory where to save data');

    save([path,f,'V1Crop.mat'],'V1Crop','T_V1','Padding_V1',...
        'OriginalSizeV1','Sampling_V1','V1VoxelSize','-v7.3');

    save([path,f,'V2Crop.mat'],'V2Crop','T_V2','Padding_V2',...
        'OriginalSizeV2','Sampling_V2','V2VoxelSize','AtlasLabels','-v7.3');

end













