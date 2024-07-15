function plotMIPGrid(V,figureNumber,figureTitle)
% 
% HATIM BELGHARBI
% CREATED: 2022-12-31
% LAST MODIFIED: 2022-12-31
%
%PLOTMIPGrid Plots a maximum intensity projection (MIP) of a 
%volume along the 3 dimensions. Provide the figureNumber and figureTitle

figure(figureNumber);clf

counter = 1;
for dimension = 3:-1:1
    subplot(2,2,counter)
    
    colormap turbo
    imagesc(squeeze(max(V,[],dimension)));
    title(figureTitle)
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