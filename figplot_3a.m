
close all; home
clear all;


directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';

directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/figures_updated_20190219/newpanels/';
% set(h1, 'YAxisLocation', 'Right')

cuecolor     = 'r';
gridcolor    = [0 .6 .2];
bordercolor  = [0 .4 .8];
headcolor = 'k';
allcellcolor = [.4 .4 .4];
shufflecolor = [.7 .7 .7];

fontsize = 14;
cd(directories.analysis)
load('database_shuffles_MECbygridscore_goodunique_removeduplicates')

load('database_MECbygridscore_goodunique_removeduplicates')

scoretypes = {'cue';'grid';'border';'head'};
numbins = [75 75 100 100 100 100 100];
for scoretypeind = 1:length(scoretypes)
scoretype = scoretypes{scoretypeind};   
scorehists.(scoretype).numbins = numbins(scoretypeind);
scorehists.(scoretype).range = [min(database.scores.(scoretype)) max(database.scores.(scoretype))];
scorehists.(scoretype).binwidth = diff(scorehists.(scoretype).range)/scorehists.(scoretype).numbins;
scorehists.(scoretype).binedges = scorehists.(scoretype).range(1):scorehists.(scoretype).binwidth:scorehists.(scoretype).range(2);
scorehists.(scoretype).bincenters = scorehists.(scoretype).binedges(1:end-1)+0.5*scorehists.(scoretype).binwidth;
scorehists.(scoretype).hist = histc(database.scores.(scoretype),scorehists.(scoretype).binedges);scorehists.(scoretype).hist(end) = [];
scorehists.(scoretype).shuffledhist = histc(database_shuffles.(scoretype),scorehists.(scoretype).binedges);scorehists.(scoretype).shuffledhist(end) = [];
scorehists.(scoretype).shuffleprobhist = 100*scorehists.(scoretype).shuffledhist/length(database_shuffles.(scoretype)); 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Cue conjunctive plots/Percent of each cell type  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numcuecells              = length(database.celltypes.clusterlisti.cue);
numbordercuecells        = length(intersect(database.celltypes.clusterlisti.border,database.celltypes.clusterlisti.cue));
numgridcuecells          = length(intersect(database.celltypes.clusterlisti.grid,database.celltypes.clusterlisti.cue));
numcueheaddirectioncells = length(intersect(database.celltypes.clusterlisti.head,database.celltypes.clusterlisti.cue));

%%%%%%
% percent cue cells not another spatial cell type
bordercuecellsi        = intersect(database.celltypes.clusterlisti.border,database.celltypes.clusterlisti.cue);
gridcuecellsi        = intersect(database.celltypes.clusterlisti.grid,database.celltypes.clusterlisti.cue);

bordercueconj = unique([bordercuecellsi gridcuecellsi]);
uniquecuefrac = length(setdiff(database.celltypes.clusterlisti.cue,bordercueconj))/numcuecells;
%%%%%%%%%%%%%%%%%%%
prcntcueborder        = round(100*numbordercuecells/numcuecells);
prcntcuegrid          = round(100*numgridcuecells/numcuecells);
prcntcueheaddirection = round(100*numcueheaddirectioncells/numcuecells);
 
scoretypes = {'border';'grid';'head'};
scorenames = {'Border Score';'Grid Score';'Head Dir. Score'};
celltypes = {'border';'grid';'head'};
prcntcueconj = [prcntcueborder prcntcuegrid prcntcueheaddirection];
 
xrange = [-1 1];
scores_ymin = [-1 -1 0];
xvals = [.05 .27 .5];
xtitle_yval = [-1.5 -1.5 -.25];
ytitleval = [0 0 .45];
prcntscorexval = [1.1 1.1 1.1];
prcntscoreyval = [.925 .95 .95];

for scoretypeind = 1:length(scoretypes)
scoretype = scoretypes{scoretypeind}; 
scorename = scorenames{scoretypeind}; 
color = eval([scoretype 'color']);
celltype = celltypes{scoretypeind}; 
scores = database.scores.(scoretype);
inds = database.celltypes.clusterlisti.(celltype);

figure; set(gcf,'Units','Inches','Position',[6 6 3 3]); 
set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;

subplot('Position',[.3 .2 .5 .5]); hold on;

yrange = [-1 1];
plot(database.scores.cue,scores,'o','Color',allcellcolor,'Markersize',3);
plot(database.scores.cue(database.celltypes.clusterlisti.(celltype)),scores(inds),'o','Markersize',3,'MarkerFaceColor', eval([scoretype 'color']),'MarkerEdgeColor','none');
plot(database.scores.cue(database.celltypes.clusterlisti.cue),scores(database.celltypes.clusterlisti.cue),'o','Color',cuecolor,'Markersize',3,'MarkerFaceColor','none');
line([database_shuffles.thresholds.cue database_shuffles.thresholds.cue],[-1 1],'Color','k');
line(xrange,[database_shuffles.thresholds.(scoretype) database_shuffles.thresholds.(scoretype)],'Color','k');
axis square; axis([-1 1 scores_ymin(scoretypeind) 1]);
set(gca,'XTick',[],'YTick',[]); 
text(prcntscorexval(scoretypeind),prcntscoreyval(scoretypeind),[num2str(prcntcueconj(scoretypeind)) ' %'],'HorizontalAlignment','Center','FontSize',11);
box on;

subplot('Position',[.125 .2 .15 .5]); hold on;
scoretype = scoretypes{scoretypeind}; 
barh(scorehists.(scoretype).bincenters,scorehists.(scoretype).hist,'FaceColor',allcellcolor,'EdgeColor',allcellcolor)
abovethreshinds = find(scorehists.(scoretype).bincenters>=database_shuffles.thresholds.(scoretype));
barh(scorehists.(scoretype).bincenters(abovethreshinds),scorehists.(scoretype).hist(abovethreshinds),'FaceColor',color,'EdgeColor',color)
line([0 max(scorehists.(scoretype).hist)],[database_shuffles.thresholds.(scoretype); database_shuffles.thresholds.(scoretype)],'Color','k','LineWidth',1.1);
set(gca,'XTick',[],'YTick',[],'FontSize',fontsize)
axis([0 max(scorehists.(scoretype).hist) scores_ymin(scoretypeind) 1 ]);
set(gca,'Xdir','reverse')
text(1.4*max(scorehists.(scoretype).hist),ytitleval(scoretypeind),scorenames{scoretypeind},'Rotation',90,'HorizontalAlignment','Center','FontSize',fontsize);
axis off;

subplot('Position',[.3 .725 .5 .15]); hold on;
scoretype = 'cue';
bar(scorehists.cue.bincenters,scorehists.(scoretype).hist,'FaceColor',allcellcolor,'EdgeColor',allcellcolor)
abovethreshinds = find(scorehists.(scoretype).bincenters>=round(100*database_shuffles.thresholds.(scoretype))/100);
bar(scorehists.cue.bincenters(abovethreshinds),scorehists.(scoretype).hist(abovethreshinds),'FaceColor',cuecolor,'EdgeColor',cuecolor)
line([database_shuffles.thresholds.(scoretype); database_shuffles.thresholds.(scoretype)],[0 max(scorehists.(scoretype).hist)],'Color','k','LineWidth',1.1);
set(gca,'XTick',[],'YTick',[],'FontSize',fontsize)
axis off;
 axis([-1 1 0 max(scorehists.(scoretype).hist) ]);
text(0,1.4*max(scorehists.(scoretype).hist),'Cue score','HorizontalAlignment','Center','FontSize',fontsize);
cd(directories.figure); print('-dsvg', '-r300', ['fig3a_cuevs' scoretypes{scoretypeind}]); close all;



end






















