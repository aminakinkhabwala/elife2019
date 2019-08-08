
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

figure; set(gcf,'Units','Inches','Position',[5 3 1.4 1.125]); 
set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;
subplot('Position',[.25 .4 .6 .6]); hold on;

numcells = length(database.clusterlist);
bar(.5,100*(length(database.celltypes.clusterlisti.cue)/numcells),'Facecolor',cuecolor)
bar(1.5,100*(length(database.celltypes.clusterlisti.border)/numcells),'Facecolor',bordercolor)
bar(2.5,100*(length(database.celltypes.clusterlisti.grid)/numcells),'Facecolor',gridcolor)
bar(3.5,100*(length(database.celltypes.clusterlisti.head)/numcells),'Facecolor',headcolor)
axis([0 4 0 max(100*(length(database.celltypes.clusterlisti.head)/numcells))+2]);
set(gca,'XTick',[]); set(gca,'YTick',[0 10 20 30 40])
text(-1.3,20,'Percent','Rotation',90,'HorizontalAlignment','Center','FontSize',fontsize)
text(.2,-3,' Cue','Rotation',90,'HorizontalAlignment','Right','FontSize',fontsize)
 text(1.2,-3,'Border','Rotation',90,'HorizontalAlignment','Right','FontSize',fontsize)
text(2.2,-3,'Grid','Rotation',90,'HorizontalAlignment','Right','FontSize',fontsize)

text(3.2,-3,'Head','Rotation',90,'HorizontalAlignment','Right','FontSize',fontsize)

%  cd(directories.figure); print('-dsvg', '-r300', 'fig_3b');close all;
