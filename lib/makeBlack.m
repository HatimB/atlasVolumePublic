function makeBlack()

% get(0,'Factory')

set(gcf,'InvertHardcopy','off')
set(gcf,'color','k')
set(gca,'color','k')

% set(gca,'Xcolor','w');set(gca,'Ycolor','w');set(gca,'Zcolor','w');
% set(gca,'Xtick',[]);set(gca,'Ytick',[]);set(gca,'Ztick',[]);

% set(0,'defaultfigurecolor',[1 1 1])
set(0,'DefaultFigureColor',[0 0 0])
set(0,'DefaultAxesColor',[0 0 0])
set(0,'DefaultAxesXColor',[1 1 1])
set(0,'DefaultAxesYColor',[1 1 1])
set(0,'DefaultAxesZColor',[1 1 1])
set(0,'DefaultTextColor',[1 1 1])
set(0,'DefaultAxesGridColor',[1 1 1])
set(0,'defaultAxesXGrid','off')
set(0,'defaultAxesYGrid','off')
set(gca, 'Color','k', 'XColor','w', 'YColor','w', 'ZColor','w')

hLegend = findobj(gcf, 'Type', 'Legend');
set(hLegend,'color','k')
set(hLegend,'textcolor','w')
set(hLegend,'edgecolor','w')

%% White background
% set(0,'DefaultFigureColor',[1 1 1])
% set(0,'DefaultAxesColor',[1 1 1])
% set(0,'DefaultAxesXColor',[0 0 0])
% set(0,'DefaultAxesYColor',[0 0 0])
% set(0,'DefaultAxesZColor',[0 0 0])
% set(0,'DefaultTextColor',[0 0 0])
% set(0,'DefaultAxesGridColor',[0 0 0])
% set(0,'defaultAxesXGrid','off')
% set(0,'defaultAxesYGrid','off')

end