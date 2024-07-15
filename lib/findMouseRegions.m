function findMouseRegions(file_path,file_name,st,Volume)
%findMouseRegions Finds regions in mouse atlas
%st: Labels
% Volume: Labeled atlas



%% Finding regions and plotting
%% structure_id_path
% NAMES_Thalamus = [];
% for ii = 1:size(st,1)
%     a = contains(char(table2cell(st(ii,16))),' thalamus');
%     if sum(a)>0
%         disp(char(table2cell(st(ii,16))))
%         NAMES_Thalamus = vertcat(NAMES_Thalamus,{char(table2cell(st(ii,16)))})
%     end
% end      
%
NAMES_Thalamus = [];
for ii = 1:size(st,1)
    a = contains(char(st.structure_id_path(ii)),'/549/');
    if sum(a)>0
        disp(char(table2cell(st(ii,16))))
        NAMES_Thalamus = vertcat(NAMES_Thalamus,{char(table2cell(st(ii,16)))})
    end
end   
whos NAMES_Thalamus
%
R_Thalamus = [];
C_Thalamus = [];
D_Thalamus = [];
for idx = 1:size(NAMES_Thalamus,1)
    structure_name = char(NAMES_Thalamus(idx));
    structure_id = st.id(find(strcmp(structure_name,st.safe_name)));
    [r,c,d] = ind2sub(size(Volume),find(Volume==structure_id)); % [row,col,depth]
%     r = r + dx; % Compensate for moving the volume
%     c = c + dy; % Compensate for moving the volume
%     d = d + dz; % Compensate for moving the volume
    
    R_Thalamus = vertcat(R_Thalamus,r); % Row
    C_Thalamus = vertcat(C_Thalamus,c); % Column
    D_Thalamus = vertcat(D_Thalamus,d); % Slice
end
% figure(8);clf
% markersize = 30;
% fontsize = 16;
% scatter3(R_Thalamus,C_Thalamus,D_Thalamus,markersize,'filled');hold on
% axis equal tight
%%
whos R_Thalamus


% NAMES_Hippo = [];
% for ii = 1:size(st,1)
%     a = contains(char(table2cell(st(ii,16))),'hippo');
%     if sum(a)>0
%         disp(char(table2cell(st(ii,16))))
%         NAMES_Hippo = vertcat(NAMES_Hippo,{char(table2cell(st(ii,16)))})
%     end
%     a = contains(char(table2cell(st(ii,16))),'Hippo');
%     if sum(a)>0
%         disp(char(table2cell(st(ii,16))))
%         NAMES_Hippo = vertcat(NAMES_Hippo,{char(table2cell(st(ii,16)))})
%     end
% end   
NAMES_Hippo = [];
for ii = 1:size(st,1)
    a = contains(char(st.structure_id_path(ii)),'/1080/');
    if sum(a)>0
        disp(char(table2cell(st(ii,16))))
        NAMES_Hippo = vertcat(NAMES_Hippo,{char(table2cell(st(ii,16)))})
    end
end  

R_Hippo = [];
C_Hippo = [];
D_Hippo = [];
for idx = 1:size(NAMES_Hippo,1)
    structure_name = char(NAMES_Hippo(idx));
    structure_id = st.id(find(strcmp(structure_name,st.safe_name)));
    [r,c,d] = ind2sub(size(Volume),find(Volume==structure_id)); % [row,col,depth]
%     r = r + dx; % Compensate for moving the volume
%     c = c + dy; % Compensate for moving the volume
%     d = d + dz; % Compensate for moving the volume
    
    R_Hippo = vertcat(R_Hippo,r);
    C_Hippo = vertcat(C_Hippo,c);
    D_Hippo = vertcat(D_Hippo,d);
end
whos R_Hippo
% figure(8);clf
% markersize = 30;
% fontsize = 16;
% scatter3(R_Hippo,C_Hippo,D_Hippo,markersize,'filled');hold on
% axis equal tight
%%
% NAMES_Entorhinal = [];
% for ii = 1:size(st,1)
%     a = contains(char(table2cell(st(ii,16))),'Entorhinal');
%     if sum(a)>0
%         disp(char(table2cell(st(ii,16))))
%         NAMES_Entorhinal = vertcat(NAMES_Entorhinal,{char(table2cell(st(ii,16)))})
%     end
% end 
NAMES_Entorhinal = [];
for ii = 1:size(st,1)
    a = contains(char(st.structure_id_path(ii)),'/909/');
    if sum(a)>0
        disp(char(table2cell(st(ii,16))))
        NAMES_Entorhinal = vertcat(NAMES_Entorhinal,{char(table2cell(st(ii,16)))})
    end
end  
R_Entorhinal = [];
C_Entorhinal = [];
D_Entorhinal = [];
for idx = 1:size(NAMES_Entorhinal,1)
    structure_name = char(NAMES_Entorhinal(idx));
    structure_id = st.id(find(strcmp(structure_name,st.safe_name)));
    [r,c,d] = ind2sub(size(Volume),find(Volume==structure_id)); % [row,col,depth]
%     r = r + dx; % Compensate for moving the volume
%     c = c + dy; % Compensate for moving the volume
%     d = d + dz; % Compensate for moving the volume
    
    R_Entorhinal = vertcat(R_Entorhinal,r);
    C_Entorhinal = vertcat(C_Entorhinal,c);
    D_Entorhinal = vertcat(D_Entorhinal,d);
end
whos R_Entorhinal
% figure(8);clf
% markersize = 30;
% fontsize = 16;
% scatter3(R_Entorhinal,C_Entorhinal,D_Entorhinal,markersize);hold on
% axis equal tight
%%
% NAMES_Frontal = [{'Frontal pole cerebral cortex'}];
% NAMES_Frontal = [];
% for ii = 1:size(st,1)
%     a = contains(char(table2cell(st(ii,16))),'Front');
%     if sum(a)>0
%         disp(char(table2cell(st(ii,16))))
%         NAMES_Frontal = vertcat(NAMES_Frontal,{char(table2cell(st(ii,16)))})
%     end
% end 
NAMES_Frontal = [];
for ii = 1:size(st,1)
    a = contains(char(st.structure_id_path(ii)),'/184/');
    if sum(a)>0
        disp(char(table2cell(st(ii,16))))
        NAMES_Frontal = vertcat(NAMES_Frontal,{char(table2cell(st(ii,16)))})
    end
end 
R_Frontal = [];
C_Frontal = [];
D_Frontal = [];
for idx = 1:size(NAMES_Frontal,1)
    structure_name = char(NAMES_Frontal(idx));
    structure_id = st.id(find(strcmp(structure_name,st.safe_name)));
    [r,c,d] = ind2sub(size(Volume),find(Volume==structure_id)); % [row,col,depth]
%     r = r + dx; % Compensate for moving the volume
%     c = c + dy; % Compensate for moving the volume
%     d = d + dz; % Compensate for moving the volume
    
    R_Frontal = vertcat(R_Frontal,r);
    C_Frontal = vertcat(C_Frontal,c);
    D_Frontal = vertcat(D_Frontal,d);
end
whos R_Frontal
% figure(8);clf
% markersize = 30;
% fontsize = 16;
% scatter3(R_Frontal,C_Frontal,D_Frontal,markersize,'filled');hold on
% axis equal tight
%%
% NAMES_Parietal = [{'Thalamus polymodal association cortex related'};...
%          {'Thalamus sensory-motor cortex related'}];
% NAMES_Parietal = [];
% for ii = 1:size(st,1)
%     a = contains(char(table2cell(st(ii,16))),'parietal');
%     if sum(a)>0
%         disp(char(table2cell(st(ii,16))))
%         NAMES_Parietal = vertcat(NAMES_Parietal,{char(table2cell(st(ii,16)))})
%     end
% end 
NAMES_Parietal = [];
for ii = 1:size(st,1)
    a = contains(char(st.structure_id_path(ii)),'/22/');
    if sum(a)>0
        disp(char(table2cell(st(ii,16))))
        NAMES_Parietal = vertcat(NAMES_Parietal,{char(table2cell(st(ii,16)))})
    end
end 
R_Parietal = [];
C_Parietal = [];
D_Parietal = [];
for idx = 1:size(NAMES_Parietal,1)
    structure_name = char(NAMES_Parietal(idx));
    structure_id = st.id(find(strcmp(structure_name,st.safe_name)));
    [r,c,d] = ind2sub(size(Volume),find(Volume==structure_id)); % [row,col,depth]
%     r = r + dx; % Compensate for moving the volume
%     c = c + dy; % Compensate for moving the volume
%     d = d + dz; % Compensate for moving the volume
    
    R_Parietal = vertcat(R_Parietal,r);
    C_Parietal = vertcat(C_Parietal,c);
    D_Parietal = vertcat(D_Parietal,d);
end
whos R_Parietal
% figure(8);clf
% markersize = 30;
% fontsize = 16;
% scatter3(R_Parietal,C_Parietal,D_Parietal,markersize,'filled');hold on
% axis equal tight
%%
% NAMES_Cortex = [{'Cerebral cortex'};...
%                 {'Frontal pole cerebral cortex'};...
%                 {'Frontal pole cerebral cortex'};...
%                 {'Layer 6b isocortex'};...
%                 {'grooves of the cerebral cortex'}];
NAMES_Cortex = [];
for ii = 1:size(st,1)
    a = contains(char(table2cell(st(ii,16))),'cortex');
    if sum(a)>0
        disp(char(table2cell(st(ii,16))))
        NAMES_Cortex = vertcat(NAMES_Cortex,{char(table2cell(st(ii,16)))})
    end
end 
R_Cortex = [];
C_Cortex = [];
D_Cortex = [];
for idx = 1:size(NAMES_Cortex,1)
    structure_name = char(NAMES_Cortex(idx));
    structure_id = st.id(find(strcmp(structure_name,st.safe_name)));
    [r,c,d] = ind2sub(size(Volume),find(Volume==structure_id)); % [row,col,depth]
%     r = r + dx; % Compensate for moving the volume
%     c = c + dy; % Compensate for moving the volume
%     d = d + dz; % Compensate for moving the volume
    
    R_Cortex = vertcat(R_Cortex,r);
    C_Cortex = vertcat(C_Cortex,c);
    D_Cortex = vertcat(D_Cortex,d);
end
whos R_Cortex
%% Plot
figure(8);clf
markersize = 30;
fontsize = 16;
scatter3(R_Thalamus,C_Thalamus,D_Thalamus,markersize,'filled');hold on
scatter3(R_Hippo,C_Hippo,D_Hippo,markersize,'filled');hold on
scatter3(R_Entorhinal,C_Entorhinal,D_Entorhinal,markersize,'filled');hold on
scatter3(R_Frontal,C_Frontal,D_Frontal,markersize,'filled');hold on
scatter3(R_Parietal,C_Parietal,D_Parietal,markersize,'filled');hold on
% scatter3(R_Cortex,C_Cortex,D_Cortex,markersize,'filled');hold on
axis equal tight
xlabel('x [px]');ylabel('y [px]');zlabel('z [px]')
set(gca,'fontsize',fontsize)
legend( 'Thalamus','Hippocampal','Entorhinal',...
        'Frontal','Parietal')
%% Saving
save([file_path,file_name,'/','Regions.mat'],...
    'st',...
    'R_Thalamus',   'C_Thalamus',   'D_Thalamus',...
    'R_Hippo',      'C_Hippo',      'D_Hippo',...
    'R_Entorhinal', 'C_Entorhinal', 'D_Entorhinal',...
    'R_Frontal',    'C_Frontal',    'D_Frontal',...
    'R_Parietal',   'C_Parietal',   'D_Parietal',...
    'R_Cortex',     'C_Cortex',     'D_Cortex',...
    'NAMES_Thalamus','NAMES_Hippo','NAMES_Entorhinal',...
    'NAMES_Frontal','NAMES_Parietal','NAMES_Cortex',...
    'Volume',...
    '-v7.3')
end