
close all; home
clear all;


directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';
directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/figures_updated_20190219/newpanels/';

cd(directories.database)
load('envdata')
cd(directories.analysis)
load('database_MECbygridscore_goodunique_removeduplicates')

fontsize = 12;


figure; set(gcf,'Units','Inches','Position',[4 4 4 4])

envind = 1;
cellsums = sum(database.envcelldata(envind).cue.viscueviswall.fields_sorted,2);
goodinds = find(~isnan(cellsums));

subplot('Position',[.225 .715 .7 .05]); hold on;
text(400,4.8,'Cue Cell Population','FontSize',fontsize+2,'HorizontalAlignment','Center')
text(400,3.5,'Firing Field Distribution','FontSize',fontsize+2,'HorizontalAlignment','Center')
text(0,2,'Environment 1','FontSize',fontsize,'HorizontalAlignment','Left')
make_patch_plot(2.5:5:800,envdata(envind).viscueviswall.templates.cue,[.3 .4 .7])

subplot('Position',[.225 .55 .7 .15]); hold on;
goodcells_fields = database.envcelldata(envind).cue.viscueviswall.fields_sorted(goodinds,:);
fielddist = sum(database.envcelldata(envind).cue.viscueviswall.fields_sorted(goodinds,:))/length(goodinds);
patch([0  2.5:5:800   800 0   ],[0 fielddist 0 0],[0 0 0]);
set(gca,'YTick',[0 1],'XTick',0:400:800, 'XLim',[0 800],'YLim',[0 1],'FontSize',fontsize);
text(400,-.5,'Distance along track (cm)','FontSize',fontsize,'HorizontalAlignment','Center')
text(-150, .5,'Population','FontSize',fontsize,'Rotation',90,'HorizontalAlignment','Center')
text(-100, .5,'fraction','FontSize',fontsize,'Rotation',90,'HorizontalAlignment','Center')

envind = 7;
cellsums = sum(database.envcelldata(envind).cue.viscueviswall.fields_sorted,2);
goodinds = find(~isnan(cellsums));

subplot('Position',[.225 .295 .7 .05]); hold on;
text(0,2,'Environment 7','FontSize',fontsize,'HorizontalAlignment','Left')
make_patch_plot(2.5:5:800,envdata(envind).viscueviswall.templates.cue,[.3 .4 .7])

subplot('Position',[.225 .125 .7 .15]); hold on;
goodcells_fields = database.envcelldata(envind).cue.viscueviswall.fields_sorted(goodinds,:);
fielddist = sum(database.envcelldata(envind).cue.viscueviswall.fields_sorted(goodinds,:))/length(goodinds);
patch([0 2.5:5:800 800 0],[0 fielddist 0 0],[0 0 0]);
set(gca,'YTick',[0 1],'XTick',0:400:800, 'XLim',[0 800],'YLim',[0 1],'FontSize',fontsize);
text(400,-.5,'Distance along track (cm)','FontSize',fontsize,'HorizontalAlignment','Center')
text(-150, .5,'Population','FontSize',fontsize,'Rotation',90,'HorizontalAlignment','Center')
text(-100, .5,'fraction','FontSize',fontsize,'Rotation',90,'HorizontalAlignment','Center')

cd(directories.figure); print('-dsvg', '-r300', 'fig_1d');close all;
