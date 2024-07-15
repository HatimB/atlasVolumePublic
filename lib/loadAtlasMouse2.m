function [VLabel,VIntensity,Labels,vx_size] = loadAtlasMouse()
%loadAtlasData Loads data
    warning off


    % VIntensity:   whole     brain
    % VLabel:       labeled   brain
    % Labels:       labels
    
    
    load_previous_data = 1;

    %% Load from scratch
    if load_previous_data == 0
        addpath(genpath('/home/hatim/Documents/Github/npy-matlab'))
        addpath(genpath('/home/hatim/Documents/Github/allenCCF'))
        vx_size = 10;
    
        sanitizeStructureTree('query.csv', 'structure_tree_safe_2017.csv');
    %     Labels = loadStructureTree('structure_tree_safe_2017.csv');
        VIntensity = readNPY('template_volume_10um.npy'); % grey-scale "background signal intensity"
        VLabel = nrrdread('/home/hatim/Documents/Github/allenCCF/annotation_10.nrrd');
        %% Downsample
        downsample_factor = 0.25;
        VIntensity  = imresize3(VIntensity,downsample_factor,'nearest');
        VLabel      = imresize3(VLabel,downsample_factor,'nearest');
        vx_size = vx_size/downsample_factor;

        Labels = loadStructureTree('structure_tree_safe.csv');
        save('/home/hatim/Documents/DATA/mouse_atlas.mat',...
            'vx_size','VIntensity','VLabel','Labels','downsample_factor',...
            '-v7.3')
    end
   %% Load previous data
   if load_previous_data == 1
        load('data/mouse_atlas.mat');
   end

   clear filename

end