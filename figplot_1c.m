
close all; home
clear all;


directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';

directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/figures_updated_20190219/newpanels/';

cuecolor     = 'r';
gridcolor    = [0 .6 .2];
bordercolor  = [0 .4 .8];
headcolor = 'k';
allcellcolor = [.4 .4 .4];
shufflecolor = [.7 .7 .7];

fontsize = 9;
cd(directories.analysis)
load('database_shuffles_MECbygridscore_goodunique_removeduplicates')
load('database_MECbygridscore_goodunique_removeduplicates')

numbins = 75;
range = [min(database.scores.cue) max(database.scores.cue)];
binwidth = diff(range)/numbins;
binedges = range(1):binwidth:range(2);
bincenters = binedges(1:end-1)+0.5*binwidth;
hist = histc(database.scores.cue,binedges);hist(end) = [];
shuffledhist = histc(database_shuffles.cue,binedges);shuffledhist(end) = [];
shuffleprobhist = 100*shuffledhist/length(database_shuffles.cue); 

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CUE SCORE HISTOGRAM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% FIGURE 1C
figure; set(gcf,'Units','Inches','Position',[3 6 2.25 1.75]);%,'Renderer','zbuffer');
% set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;

celltype = 'Cue Score';
scoretype = 'cue'; color = eval([scoretype 'color']);
subplot('Position',[.2 .55 0.775 .32]); hold on;
bar(bincenters,hist,'FaceColor',allcellcolor,'EdgeColor',allcellcolor)
abovethreshinds = find(bincenters>=round(100*database_shuffles.thresholds.cue)/100);
bar(bincenters(abovethreshinds),hist(abovethreshinds),'FaceColor',color,'EdgeColor',color)
text(.25,1.25*max(hist),celltype,'HorizontalAlignment','Center','FontSize',11)
line([round(100*database_shuffles.thresholds.cue)/100; round(100*database_shuffles.thresholds.cue)/100],[0 max(hist)],'Color','k','LineWidth',1.1);
set(gca,'XTick',[-1 -.5 0 .5 1],'YTick',0:20:400,'FontSize',fontsize)
axis([range(1) 1 0 max(hist)]);
text(-.65,.5*max(hist),'Num. cells','Rotation',90,'HorizontalAlignment','Center','FontSize',fontsize);

subplot('Position',[.2 .11 0.775 .32]); hold on;
bar(bincenters,shuffleprobhist,'FaceColor',shufflecolor,'EdgeColor',shufflecolor)
line([round(100*database_shuffles.thresholds.cue)/100; round(100*database_shuffles.thresholds.cue)/100],[0 max(hist)],'Color','k','LineWidth',1.1);
text(.7,.75*max(shuffleprobhist),num2str(round(100*database_shuffles.thresholds.cue)/100),'HorizontalAlignment','Center','FontSize',11)
set(gca,'XTick',[-1 -.5 0 .5 1],'YTick',0:1:10,'FontSize',fontsize)
axis([range(1) 1 0 max(shuffleprobhist)])
text(-.65,.5*max(shuffleprobhist),'Percent','Rotation',90,'HorizontalAlignment','Center','FontSize',fontsize);

% cd(directories.figure); print('-dsvg', '-r300', 'fig_1C');close all;
