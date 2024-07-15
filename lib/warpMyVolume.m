function [VNew,TNew] = warpMyVolume(V,K,T,method)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-29
% LAST MODIFIED: 2022-12-29
%
%WARPMYVOLUME Scales a volume V at scale K using the warp function. 
%It also updates the transformation matrix T

TNew = T;

TNew(1,1) = T(1,1)*K(1);
TNew(2,2) = T(2,2)*K(2);
TNew(3,3) = T(3,3)*K(3);

tform = affinetform3d(TNew);



OutputView = affineOutputView(size(V),tform,"BoundsStyle","CenterOutput");

VNew = imwarp(V,tform,"OutputView",OutputView,'interp',method);

end