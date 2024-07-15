function [VNew,TNew] = rotateMyVolume(V,angle,dimension,T,method)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-30
% LAST MODIFIED: 2022-12-30
%
%rotateMyVolume Rotates a volume using the imrotate3 function. It also updates
%the transformation matrix

TNew = T;
switch dimension
    case 1
        R = rotx(angle);
        W = [1 0 0];
    case 2
        R = roty(angle);
        W = [0 1 0];
    case 3
        R = rotz(angle);
        W = [0 0 1];
    otherwise
        error('Select dimension between 1 and 3...')
end


TNew(1:3,1:3) = R*T(1:3,1:3); % update transformation matrix

VNew = imrotate3(V,angle,W,method); % rotate volume

end
