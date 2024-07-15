function [V,px_size] = loadVolumeMouseVascular(file_path, file_name)
%LOADVOLUME Loads data
    
%     load('/home/hatim/Documents/DATA/Rebecca_rat_SR_11282022/im.mat');
    load([file_path, file_name,'.mat'])
    
    V = MIP_Vol;
    clear im;
    
%     res = (deps(2)-deps(1))/depupsamp;
    res = dX;
    px_size = res*1e6; % um

end