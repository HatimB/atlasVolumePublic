function [VLabel,VIntensity,scaninfo1,vx_size] = loadAtlasMouseVascular()
%loadAtlasData Loads data
    warning off


    % VIntensity:   whole     brain
    % VLabel:       labeled   brain
    % Labels:       labels
    
    
    %% Load mouse vascular atlas
    addpath('lib')
    filename = 'data/cba_vasculature_labels.mnc';
    [VLabel,scaninfo1] = loadminc(filename);
    %% Load mouse brain atlas
    addpath('lib')
    filename = 'data/cba_brain_labels.mnc';
    [VIntensity,scaninfo2] = loadminc(filename);

    %% Plot vasculature
    VLabel(VLabel==117) = 0;  % Remove background from data
    % volshow(VLabel)
    
    %% Plot brain
    VIntensity(VIntensity==134) = 0;  % Remove background from data
    % volshow(VIntensity)

    vx_size = 32; %[um]

   clear filename

end