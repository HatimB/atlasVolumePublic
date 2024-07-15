function savefigs(figureHandle, path, saveName)
exts = ['fig'; 'png'; 'svg'];
for i = 1:length(exts)
  paths(i,:) = [path exts(i,:) '/'];
  if ~exist(paths(i,:)); eval(['!mkdir -p ' paths(i,:)]); end
  names(i,:) = [paths(i,:) char(saveName) '.' exts(i,:)];
  names(i,:)
%   if i ~= length(exts)
    saveas(figureHandle, names(i,:));
%   end
end
end