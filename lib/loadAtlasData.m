function [VLabel,VIntensity,Labels,vx_size] = loadAtlasData()
%loadAtlasData Loads data
    warning off

    vx_size = 60; % [um]

    % VIntensity:   whole     brain
    % VLabel:       labeled   brain
    % Labels:       labels
    % https://www.nature.com/articles/s41598-020-63965-x
    % https://www.zenodo.org/record/3700210#.Yv0np39KiV4
    filename = '/home/hatim/Downloads/Fischer344_nii_v3/Fischer344_nii_v3/Fischer344_template.nii';
    VIntensity = niftiread(filename);
    filename = '/home/hatim/Downloads/Fischer344_nii_v3/Fischer344_nii_v3/Fischer344_labels_v3.nii';
    VLabel = niftiread(filename);
    filename = '/home/hatim/Downloads/Fischer344_nii_v3/Fischer344_nii_v3/Fischer344_Label_Hierarchy.xlsx';
    Labels = readtable(filename);
    
    clear filename

end