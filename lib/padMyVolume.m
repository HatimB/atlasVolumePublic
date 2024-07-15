function [VNew,padExtentNew] = padMyVolume(V,padsize,direction,padval,padExtent)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%padMyVolume Pads a volume using the padarray function. 
% It also updates the padExtent matrix


padExtentNew = padExtent;   % initialize new padExtent

switch direction
    case 'both'
        VNew = padarray(V,padsize,padval,'both');
        padExtentNew(:,1) = padExtentNew(:,1) + padsize'; % update pre limit
        padExtentNew(:,2) = padExtentNew(:,2) + padsize'; % update post limit
    case 'pre'
        VNew = padarray(V,padsize,padval,'pre');
        padExtentNew(:,1) = padExtentNew(:,1) + padsize'; % update pre limit
    case 'post'
        VNew = padarray(V,padsize,padval,'post');
        padExtentNew(:,2) = padExtentNew(:,2) + padsize'; % update post limit
    otherwise
        error('Invalid direction. Choose between both, pre or post.');
end


end