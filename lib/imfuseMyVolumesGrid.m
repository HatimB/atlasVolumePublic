function imfuseMyVolumesGrid(V1,V2,figureNumber,figureTitle)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%imfuseMyVolumesGrid Plots a maximum intensity projection (MIP) 
%of a volume along the all dimensions. 
%Provide the figureNumber and figureTitle
figure(figureNumber);clf
counter = 1;
for dimension = 3:-1:1
    subplot(2,2,counter)

    colormap turbo
    
    V1 = V1-min(V1,[],'all');
    V1 = V1./max(V1,[],'all');
    V2 = V2-min(V2,[],'all');
    V2 = V2./max(V2,[],'all');
    
    
    C = imfuse(squeeze(max(V1(:,:,:),[],dimension)).^(1/3), ...
               squeeze(max(V2,[],dimension)).^(1/4),...
        'falsecolor','Scaling','joint','ColorChannels',[1 2 1]);
    imshow(C);
    title(figureTitle);
    axis equal tight
    
    
    % labels
    switch dimension
        case 3
            xlabel('Dim 2'); ylabel('Dim 1');
        case 2
            xlabel('Dim 3'); ylabel('Dim 1');
        case 1
            xlabel('Dim 3'); ylabel('Dim 2');
    end
    counter = counter + 1;
end



end