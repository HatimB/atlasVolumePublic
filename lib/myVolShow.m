function myVolShow(V,viewer,objectConfig,azimuth,elevation)
v = volshow(V,objectConfig,Parent=viewer);
viewer.CameraUpVector = [0 -1 0];
% Change orientation
r = norm(viewer.CameraPosition - viewer.CameraTarget); % Distance from camera to target
[az, el] = deal(deg2rad(azimuth), deg2rad(elevation)); % Convert angles to radians
[x, y, z] = sph2cart(az, el, r); % Spherical to Cartesian conversion
newCameraPosition = viewer.CameraTarget + [x, y, z];
viewer.CameraPosition = newCameraPosition;
viewer.CameraUpVector = [0 -1 0];
end