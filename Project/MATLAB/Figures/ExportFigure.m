function ExportFigure(dir, filename, fig)
%% ExportFigure()
% Inputs    dir: directory to save figure in
%           filename: filename of saved figure (exclude .png)
%           fig: the handle for the figure to be saved
%
% Action    saves specified figure to directory as .png file
%
% Return    none

filePath = [dir,'\',filename,'.png'];
exportgraphics(fig,filePath,'Resolution',300);

end