function [VNew,TNew] = moveMyVolume(V,dx,dy,dz,T)

% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%MOVEMYVOLUME Takes in a volume and moves it according to voxel
%displacements in the 1st dimension (dx), 2nd dimension (dy), and 3rd
%dimension (dz).
%It also updates the transformation matrix

VNew = single(zeros(size(V)));          % Initialize the new volume

%%% 1) Move the volume
if dx>=0 && dy>=0 && dz>=0      % x(+) y(+) z(+)
    VNew(1:(end-dx),1:(end-dy),1:(end-dz))    = V((dx+1):end,(dy+1):end,(dz+1):end);
elseif dx<0 && dy<0 && dz<0     % x(-) y(-) z(-)
    VNew((-dx+1):end,(-dy+1):end,(-dz+1):end) = V(1:(end+dx),1:(end+dy),1:(end+dz));
elseif dx>=0 && dy<0 && dz<0    % x(+) y(-) z(-)
    VNew(1:(end-dx),(-dy+1):end,(-dz+1):end)  = V((dx+1):end,1:(end+dy),1:(end+dz));
elseif dx<0 && dy>=0 && dz<0    % x(-) y(+) z(-)
    VNew((-dx+1):end,1:(end-dy),(-dz+1):end)  = V(1:(end+dx),(dy+1):end,1:(end+dz));
elseif dx<0 && dy<0 && dz>=0    % x(-) y(-) z(+)
    VNew((-dx+1):end,(-dy+1):end,1:(end-dz))  = V(1:(end+dx),1:(end+dy),(dz+1):end);
elseif dx>=0 && dy>=0 && dz<0   % x(+) y(+) z(-)
    VNew(1:(end-dx),1:(end-dy),(-dz+1):end)   = V((dx+1):end,(dy+1):end,1:(end+dz));
elseif dx<0 && dy>=0 && dz>=0   % x(-) y(+) z(+)
    VNew((-dx+1):end,1:(end-dy),1:(end-dz))   = V(1:(end+dx),(dy+1):end,(dz+1):end);
elseif dx>=0 && dy<0 && dz>=0   % x(+) y(-) z(+)
    VNew(1:(end-dx),(-dy+1):end,1:(end-dz))   = V((dx+1):end,1:(end+dy),(dz+1):end);

end

%%% 2) Update the transformation matrix
TNew = T;
TNew(1:3,4) = T(1:3,4)+ [dx;dy;dz]; 

end