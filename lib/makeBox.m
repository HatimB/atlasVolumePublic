function box = makeBox(szeV,boxSize,boxLoc)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

box = zeros(szeV);

box(boxLoc(1)+[0:(boxSize(1)-1)],boxLoc(2),           boxLoc(3)           ) = 1;
box(boxLoc(1)+[0:(boxSize(1)-1)],boxLoc(2)+boxSize(2),boxLoc(3)           ) = 1;
box(boxLoc(1)+[0:(boxSize(1)-1)],boxLoc(2),           boxLoc(3)+boxSize(3)) = 1;
box(boxLoc(1)+[0:(boxSize(1)-1)],boxLoc(2)+boxSize(2),boxLoc(3)+boxSize(3)) = 1;

box(boxLoc(1),           boxLoc(2)+[0:(boxSize(2)-1)],boxLoc(3)           ) = 1;
box(boxLoc(1)+boxSize(1),boxLoc(2)+[0:(boxSize(2)-1)],boxLoc(3)           ) = 1;
box(boxLoc(1),           boxLoc(2)+[0:(boxSize(2)-1)],boxLoc(3)+boxSize(3)) = 1;
box(boxLoc(1)+boxSize(1),boxLoc(2)+[0:(boxSize(2)-1)],boxLoc(3)+boxSize(3)) = 1;

box(boxLoc(1),           boxLoc(2),           boxLoc(3)+[0:(boxSize(3)-1)]) = 1;
box(boxLoc(1),           boxLoc(2)+boxSize(2),boxLoc(3)+[0:(boxSize(3)-1)]) = 1;
box(boxLoc(1)+boxSize(1),boxLoc(2),           boxLoc(3)+[0:(boxSize(3)-1)]) = 1;
box(boxLoc(1)+boxSize(1),boxLoc(2)+boxSize(2),boxLoc(3)+[0:(boxSize(3)-1)]) = 1;

end