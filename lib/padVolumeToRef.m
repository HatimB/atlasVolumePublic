function [VNew,VRefNew,padExtentNew,padExtentRefNew] = padVolumeToRef(V,VRef,padval,padExtent,padExtentRef)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-30
% LAST MODIFIED: 2022-12-30
%
%padMyVolume Pads a volume using the padarray function compared to a 
% reference volume. It also updates the padExtent matrix

VSize = size(V);            % get size of current volume
VrefSize = size(VRef);      % get size of ref     volume

sizeDiff = VrefSize-VSize;  % get difference in size

padExtentNew = padExtent;           % initialize new padExtent
padExtentRefNew = padExtentRef;     % initialize new padExtentRef

padVector = [1 0 0;0 1 0;0 0 1];

VNew = V;
VRefNew = VRef;

for dim = 1:3
    if mod(sizeDiff(dim),2)==0 % if even pad size
        if sizeDiff(dim) >=0 % if positive, pad the volume
            VNew = padarray(VNew,sizeDiff(dim)/2*padVector(dim,:),padval,'both');
            padExtentNew(dim,:) = padExtentNew(dim,:) + sizeDiff(dim)/2;
        else % if negative, pad the reference volume
            VRefNew = padarray(VRefNew,-sizeDiff(dim)/2*padVector(dim,:),padval,'both');
            padExtentRefNew(dim,:) = padExtentRefNew(dim,:) - sizeDiff(dim)/2;
        end
    else % odd pad size
        if sizeDiff(dim) >=0 % if positive, pad the volume
            VNew = padarray(VNew,floor(sizeDiff(dim)/2)*padVector(dim,:),padval,'both');
            padExtentNew(dim,:) = padExtentNew(dim,:) + floor(sizeDiff(dim)/2);
    
            VNew = padarray(VNew,1*padVector(dim,:),padval,'post');
            padExtentNew(dim,2) = padExtentNew(dim,2) + 1;% add to the end
         else % if negative, pad the reference volume
            VRefNew = padarray(VRefNew,floor(-sizeDiff(dim)/2)*padVector(dim,:),padval,'both');
            padExtentRefNew(dim,:) = padExtentRefNew(dim,:) - floor(sizeDiff(dim)/2);
    
            VRefNew = padarray(VRefNew,1*padVector(dim,:),padval,'post');
            padExtentRefNew(dim,2) = padExtentRefNew(dim,2) + 1;% add to the end
        end   
    end

end


end