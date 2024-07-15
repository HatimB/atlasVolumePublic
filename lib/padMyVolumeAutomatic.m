function [VNew,padExtentNew] = padMyVolumeAutomatic(V,amountToPad,padval,padExtent)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%padMyVolumeAutomatic Pads a volume using the padMyVolume and padarray 
%function.It also updates the padExtent matrix

dimVector = [1,0,0;0,1,0;0,0,1];
VNew = V;
padExtentNew = padExtent;
for dim = 1:3
    if amountToPad(dim,1)>0     % lower limit
        [VNew,padExtentNew] = padMyVolume(VNew,amountToPad(dim,1)*dimVector(dim,:),'pre',padval,padExtentNew);
    elseif amountToPad(dim,2)>0 % upper limit
        [VNew,padExtentNew] = padMyVolume(VNew,amountToPad(dim,2)*dimVector(dim,:),'post',padval,padExtentNew);
    end
end


end