function VNew = cropMyVolume(sze,V,padExtent,padExtentRef,T)
% 
% HATIM BELGHARBI
% CREATED: 2023-01-04
% LAST MODIFIED: 2023-01-05
%
%CROPMYVOLUME Removes the pad using the padExtent matrix

dx = T(1,4); dy = T(2,4); dz = T(3,4);

%%% Account for padding and translation
idx_sta_1 = 1 + padExtent(1,1) - dx; % start
idx_sta_2 = 1 + padExtent(2,1) - dy;
idx_sta_3 = 1 + padExtent(3,1) - dz;

%%% Calculate end index (easy since we know the original size)
idx_end_1 = idx_sta_1 + sze(1) - 1;
idx_end_2 = idx_sta_2 + sze(2) - 1;
idx_end_3 = idx_sta_3 + sze(3) - 1;

%%% Crop
VNew = V(idx_sta_1:idx_end_1,...
         idx_sta_2:idx_end_2,...
         idx_sta_3:idx_end_3);

end
