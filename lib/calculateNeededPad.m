function [needToPad,amountToPad] = calculateNeededPad(padExtent,padExtentRef,dx,dy,dz,T)

% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%calculateNeededPad Calculates if the Reference Volume needs to be padded

amountToPad = zeros(3,2); % dim1 is xyz, and dim2 is [lower upper] limits
needToPad = false;

dX = dx+T(1,4);
dY = dy+T(2,4);
dZ = dz+T(3,4);


%%% X
marg_low = (padExtent(1,1)); % margin
marg_high = (padExtent(1,2));% margin
if dX > marg_low 
    needToPad = true;
    amountToPad(1,1) = dX - marg_low;
elseif -dX > marg_high 
    needToPad = true;
    amountToPad(1,2) = -dX - marg_high;
end

%%% Y
marg_low = (padExtent(2,1));
marg_high = (padExtent(2,2));
if dY > marg_low
    needToPad = true;
    amountToPad(2,1) = dY - marg_low;
elseif -dY > marg_high
    needToPad = true;
    amountToPad(2,2) = -dY - marg_high;
end

%%% Z
marg_low = (padExtent(3,1));
marg_high = (padExtent(3,2));
if dZ > marg_low
    needToPad = true;
    amountToPad(3,1) = dZ - marg_low;
elseif -dZ > marg_high
    needToPad = true;
    amountToPad(3,2) = -dZ - marg_high;
end



end