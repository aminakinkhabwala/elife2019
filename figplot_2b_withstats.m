
close all; home
clear all;

directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';
directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/figures_updated_20190219/newpanels/';

% the first cue becomes not visible at either 217 cm or 250 cm (bins 43 to 50)
% so lets choose:
startbins = 1:43;
pathintbins = 51:160;

cd(directories.database)
 load('envdata')
cd(directories.analysis)

 load('database_MECbygridscore_goodunique_removeduplicates.mat')

celltype = 'cue';

celllist = database.celltypes.clusterlisti.(celltype);
numbins     = 160;
virmencolor = [.6 .6 .6];
fontsize    = 12;


% allcells.start_flowvis_maxfrates = []; allcells.start_flowdis_maxfrates = []; allcells.pathint_flowvis_maxfrates = []; allcells.pathint_flowdis_maxfrates = [];
% allcells.start_flowvis_meanfrates = []; allcells.start_flowdis_meanfrates = [];allcells.pathint_flowvis_meanfrates = []; allcells.pathint_flowdis_meanfrates = [];

allcells.start_flowvis_fields = [];
allcells.start_flowdis_fields = [];
allcells.pathint_flowvis_fields = [];
allcells.pathint_flowdis_fields = [];

allcells.env = struct();
for envind = 1:9
    cd(directories.database)
   lags = database.envcelldata(envind).cue.lags_sorted;
    
    allcells.allcelli = find(abs(lags)>=5);
    
%     viscue_allfrates = database.envcelldata(envind).cue.viscueviswall.frates_sorted;
    discue_allfrates = database.envcelldata(envind).cue.discueviswall.frates_sorted;
%     
    cellstouse = find(~isnan((max(discue_allfrates,[],2))));
       
        envdata(envind).vistemplate = envdata(envind).viscueviswall.templates.cue;
        envdata(envind).distemplate = envdata(envind).discueviswall.templates.cue;

    allcells.celli = cellstouse;
    
%     allcells.env(envind).viscue_frates = database.envcelldata(envind).cue.viscueviswall.frates_sorted(allcells.celli,:);
%     allcells.env(envind).discue_frates = database.envcelldata(envind).cue.discueviswall.frates_sorted(allcells.celli,:);
%       
     allcells.env(envind).viscue_fields = database.envcelldata(envind).cue.viscueviswall.fields_sorted(allcells.celli,:);
     allcells.env(envind).discue_fields = database.envcelldata(envind).cue.discueviswall.fields_sorted(allcells.celli,:);
    
   
    for cellind = 1:length(allcells.celli)
     allcells.start_flowvis_fields   = [allcells.start_flowvis_fields length(find(allcells.env(envind).viscue_fields(cellind,startbins)==1))/length(startbins)];
          allcells.start_flowdis_fields   = [allcells.start_flowdis_fields length(find(allcells.env(envind).discue_fields(cellind,startbins)==1))/length(startbins)];
  allcells.pathint_flowvis_fields   = [allcells.pathint_flowvis_fields length(find(allcells.env(envind).viscue_fields(cellind,pathintbins)==1))/length(pathintbins)];
          allcells.pathint_flowdis_fields   = [allcells.pathint_flowdis_fields length(find(allcells.env(envind).discue_fields(cellind,pathintbins)==1))/length(pathintbins)];
    end
end

[hS,pS] = ttest(allcells.start_flowvis_fields,allcells.start_flowdis_fields,'Tail','right');
[hP,pP] = ttest(allcells.pathint_flowvis_fields,allcells.pathint_flowdis_fields,'Tail','right');



figure; set(gcf,'Units','Inches','Position',[3 5 6 3],'Renderer','painters'); hold on;
set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]);
markersize = 7;

subplot('Position',[0.1 .1 0.35 .8]); hold on;
text(1.2,1.15,'Fraction of field region','HorizontalAlignment','Center','FontSize',fontsize+2)
line([0 1],[0 1],'LineStyle','--','Color','k','LineWidth',1.5)
plot(allcells.start_flowvis_fields,allcells.start_flowdis_fields,'ko','MarkerSize',markersize,'MarkerFaceColor','none','MarkerEdgeColor','k')
text(.5,-.15,'With cues track','HorizontalAlignment','Center','FontSize',fontsize)
text(-.15,.5,'Missing cues track','HorizontalAlignment','Center','Rotation',90,'FontSize',fontsize)
set(gca,'XTick',[0 1],'YTick',[0 1]);
set(gca,'FontSize',fontsize); axis equal;axis([0 1 0 1])

subplot('Position',[0.6 .1 0.35 .8]); hold on;
line([0 1],[0 1],'LineStyle','--','Color','k','LineWidth',1.5)
plot(allcells.pathint_flowvis_fields,allcells.pathint_flowdis_fields,'ko','MarkerSize',markersize,'MarkerFaceColor','none','MarkerEdgeColor','r')
text(.5,-.15,'With cues track','HorizontalAlignment','Center','FontSize',fontsize)
text(-.15,.5,'Missing cues track','HorizontalAlignment','Center','Rotation',90,'FontSize',fontsize)
set(gca,'XTick',[0 1],'YTick',[0 1]);
set(gca,'FontSize',fontsize); axis equal;axis([0 1 0 1])
%  cd(directories.figure); print('-dsvg', '-r300', 'fig_2b');close all;


%