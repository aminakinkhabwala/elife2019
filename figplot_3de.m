
close all; home;
clear all;
 
directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';
directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/figures_updated_20190219/newpanels/';

cd(directories.database)
load('envdata')
cd(directories.analysis)
load('database_MECbygridscore_goodunique_removeduplicates')
load('database_shuffles_MECbygridscore_goodunique_removeduplicates')


fontsize = 14;
labelsfontsize = 14;


cuecolor     = 'r';
gridcolor    = [0 .6 .2];
bordercolor  = [0 .4 .8];
headcolor = 'k';
allcellcolor = [.4 .4 .4];
shufflecolor = [.7 .7 .7];



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RE2D stability histograms %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure; set(gcf,'Units','Inches','Position',[2 1 8 6],'Renderer','painters'); set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;

binwidth = 0.05;
binedges = -1:binwidth:1;
bincenters = binedges(1:end-1)+0.5*binwidth;
subplot('Position',[0.2 .9 0.35 .1]); hold on;
cuehist = histc(database.scores.stability_RE(database.celltypes.clusterlisti.cue),binedges);
cuehist(end) = [];
bar(bincenters,cuehist,'FaceColor',cuecolor)
text(-1.4,.5*max(cuehist),'Cue','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_RE database_shuffles.thresholds.stability_RE],[0 max(cuehist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1  1 0 max(cuehist)+1])
set(gca,'XTick',[]); set(gca,'YTick',[0 20]);set(gca,'FontSize',fontsize)

subplot('Position',[0.2 .74 0.35 .1]); hold on;
gridhist = histc(database.scores.stability_RE(database.celltypes.clusterlisti.grid),binedges);
gridhist(end) = [];
bar(bincenters,gridhist,'FaceColor',gridcolor)
text(-1.4,.45*max(gridhist),'Grid','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_RE database_shuffles.thresholds.stability_RE],[0 max(gridhist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1 1 0 max(gridhist)+1])
set(gca,'XTick',[]); set(gca,'YTick',[0 20]);set(gca,'FontSize',fontsize)

subplot('Position',[0.2 .58 .35 .1]); hold on;
borderhist = histc(database.scores.stability_RE(database.celltypes.clusterlisti.border),binedges);
borderhist(end) = [];
bar(bincenters,borderhist,'FaceColor',bordercolor)
text(-1.4,.4*max(borderhist),'Border','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_RE database_shuffles.thresholds.stability_RE],[0 max(borderhist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1 1 0 max(borderhist)+2])
set(gca,'XTick',[]); set(gca,'YTick',[0 10]);set(gca,'FontSize',fontsize)

subplot('Position',[0.2 .42 0.35 .1]); hold on;
headhist = histc(database.scores.stability_RE(database.celltypes.clusterlisti.head),binedges);
headhist(end) = [];
bar(bincenters,headhist,'FaceColor',headcolor)
text(-1.4,.4*max(headhist),'Head dir.','HorizontalAlignment','Right','FontSize',labelsfontsize)
% text(-1.5,.25*max(headhist),'dir.','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_RE database_shuffles.thresholds.stability_RE],[0 max(headhist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1 1 0 max(headhist)+2])
set(gca,'XTick',[]); set(gca,'YTick',[0 30]);set(gca,'FontSize',fontsize)

numcells = length(database.clusterlist);
other_clusterlisti = setdiff(1:numcells,unique([database.celltypes.clusterlisti.grid database.celltypes.clusterlisti.border database.celltypes.clusterlisti.cue database.celltypes.clusterlisti.head]));

subplot('Position',[0.2 .26 0.35 .1]); hold on;
otherhist = histc(database.scores.stability_RE(other_clusterlisti),binedges);
otherhist(end) = [];
bar(bincenters,otherhist,'FaceColor',[.4 .4 .4])
text(-1.4,.4*max(otherhist),'Other','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_RE database_shuffles.thresholds.stability_RE],[0 max(otherhist)+10],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1  1 0 max(otherhist)+10])
set(gca,'XTick',[]); set(gca,'YTick',[0 10]);set(gca,'FontSize',fontsize)

subplot('Position',[0.2 .1 0.35 .1]); hold on;
shufflehist = histc(database_shuffles.stability_RE,binedges);
shufflehist(end) = [];
bar(bincenters,shufflehist,'FaceColor',[1 1 1])
text(-1.4,.3*max(shufflehist),'Shuffle','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_RE database_shuffles.thresholds.stability_RE],[0 max(shufflehist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1  1 0 max(shufflehist)+2])
set(gca,'XTick',[-1  0  1]); set(gca,'YTick',[0 10000]);set(gca,'FontSize',fontsize)


% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RE2D headdir stability histograms %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 

binwidth = 0.05;
binedges = -1:binwidth:1;
bincenters = binedges(1:end-1)+0.5*binwidth;
subplot('Position',[0.63 .9 0.35 .1]); hold on;
cuehist = histc(database.scores.stability_REheaddir(database.celltypes.clusterlisti.cue),binedges);
cuehist(end) = [];
bar(bincenters,cuehist,'FaceColor',cuecolor)
% text(-1.5,.5*max(cuehist),'Cue','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_REheaddir database_shuffles.thresholds.stability_REheaddir],[0 max(cuehist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1  1 0 max(cuehist)+1])
set(gca,'XTick',[]); set(gca,'YTick',[0 10]);set(gca,'FontSize',fontsize)

subplot('Position',[0.63 .74 0.35 .1]); hold on;
gridhist = histc(database.scores.stability_REheaddir(database.celltypes.clusterlisti.grid),binedges);
gridhist(end) = [];
bar(bincenters,gridhist,'FaceColor',gridcolor)
% text(-1.5,.5*max(gridhist),'Grid','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_REheaddir database_shuffles.thresholds.stability_REheaddir],[0 max(gridhist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1 1 0 max(gridhist)+1])
set(gca,'XTick',[]); set(gca,'YTick',[0 10]);set(gca,'FontSize',fontsize)

subplot('Position',[0.63 .58 .35 .1]); hold on;
borderhist = histc(database.scores.stability_REheaddir(database.celltypes.clusterlisti.border),binedges);
borderhist(end) = [];
bar(bincenters,borderhist,'FaceColor',bordercolor)
% text(-1.5,.5*max(borderhist),'Border','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_REheaddir database_shuffles.thresholds.stability_REheaddir],[0 max(borderhist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1 1 0 max(borderhist)+2])
set(gca,'XTick',[]); set(gca,'YTick',[0 10]);set(gca,'FontSize',fontsize)

subplot('Position',[0.63 .42 0.35 .1]); hold on;
headhist = histc(database.scores.stability_REheaddir(database.celltypes.clusterlisti.head),binedges);
headhist(end) = [];
bar(bincenters,headhist,'FaceColor',headcolor)
% text(-1.5,.5*max(headhist),'Head dir.','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_REheaddir database_shuffles.thresholds.stability_REheaddir],[0 max(headhist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1 1 0 max(headhist)+2])
set(gca,'XTick',[]); set(gca,'YTick',[0 20]);set(gca,'FontSize',fontsize)

subplot('Position',[0.63 .26 0.35 .1]); hold on;
otherhist = histc(database.scores.stability_REheaddir(other_clusterlisti),binedges);
otherhist(end) = [];
bar(bincenters,otherhist,'FaceColor',[.4 .4 .4])
% text(-1.5,.5*max(otherhist),'Other','HorizontalAlignment','Right','FontSize',labelsfontsize)
line([database_shuffles.thresholds.stability_REheaddir database_shuffles.thresholds.stability_REheaddir],[0 max(otherhist)+10],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1  1 0 max(otherhist)+10])
set(gca,'XTick',[]); set(gca,'YTick',20);set(gca,'FontSize',fontsize)
set(gca,'YTick',[0 max(otherhist)]);

subplot('Position',[0.63 .1 0.35 .1]); hold on;
shufflehist = histc(database_shuffles.stability_REheaddir,binedges);
shufflehist(end) = [];
bar(bincenters,shufflehist,'FaceColor',[1 1 1])
line([database_shuffles.thresholds.stability_REheaddir database_shuffles.thresholds.stability_REheaddir],[0 max(shufflehist)],'Color',[.4 .4 .2],'LineWidth',1.5); 
axis([-1  1 0 max(shufflehist)+2])
set(gca,'XTick',[-1  0  1]); set(gca,'YTick',[0 7000]);set(gca,'FontSize',fontsize)
set(gca,'YTick',[0 max(shufflehist)]);
%   cd(directories.figure); print('-dsvg', '-r300', 'fig_3c');close all;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


celllisti_stability_RE        = database.celltypes.clusterlisti.stability_RE;

celllisti_border_stability_RE = intersect(database.celltypes.clusterlisti.border,celllisti_stability_RE);
celllisti_cue_stability_RE    = intersect(database.celltypes.clusterlisti.cue,celllisti_stability_RE);
celllisti_grid_stability_RE   = intersect(database.celltypes.clusterlisti.grid,celllisti_stability_RE);
celllisti_head_stability_RE   = intersect(database.celltypes.clusterlisti.head,celllisti_stability_RE);

allbordercueinds  = sort(unique([celllisti_border_stability_RE celllisti_cue_stability_RE]));
allbordergridinds = sort(unique([celllisti_border_stability_RE celllisti_grid_stability_RE]));
allcuegridinds    = sort(unique([celllisti_cue_stability_RE celllisti_grid_stability_RE]));

allbordercuegridinds = sort(unique([celllisti_border_stability_RE celllisti_cue_stability_RE celllisti_grid_stability_RE]));

allbordercuegridheadinds = sort(unique([celllisti_border_stability_RE celllisti_cue_stability_RE ...
    celllisti_grid_stability_RE celllisti_head_stability_RE]));


inds_headonly         = setdiff(celllisti_head_stability_RE,allbordercuegridinds);
inds_borderborderhead = setdiff(celllisti_border_stability_RE,allcuegridinds);
inds_cuecuehead       = setdiff(celllisti_cue_stability_RE,allbordergridinds);
inds_gridgridhead     = setdiff(celllisti_grid_stability_RE,allbordercueinds);
inds_other            = setdiff(celllisti_stability_RE,allbordercuegridheadinds);


inds_bordercue  = intersect(celllisti_border_stability_RE,celllisti_cue_stability_RE);
inds_cuegrid    = intersect(celllisti_cue_stability_RE,celllisti_grid_stability_RE);
inds_bordergrid = intersect(celllisti_border_stability_RE,celllisti_grid_stability_RE);

inds_bordercuegrid = intersect(inds_bordercue,inds_cuegrid);


inds_bordercue  = setdiff(inds_bordercue,inds_bordercuegrid);
inds_cuegrid    = setdiff(inds_cuegrid,inds_bordercuegrid);
inds_bordergrid = setdiff(inds_bordergrid,inds_bordercuegrid);

numstability_RE = length(celllisti_stability_RE);

numborder = length(inds_borderborderhead);
numcue    = length(inds_cuecuehead);
numgrid   = length(inds_gridgridhead);
numhead   = length(inds_headonly);
numother  = length(inds_other);

numbordercue  = length(inds_bordercue);
numcuegrid    = length(inds_cuegrid);
numbordergrid = length(inds_bordergrid);

borderfrac = numborder/numstability_RE;
cuefrac    = numcue/numstability_RE;
gridfrac   = numgrid/numstability_RE;
headfrac   = numhead/numstability_RE;
otherfrac  = numother/numstability_RE;

bordercuefrac  = numbordercue/numstability_RE;
cuegridfrac    = numcuegrid/numstability_RE;
bordergridfrac = numbordergrid/numstability_RE;

%   





figure; set(gcf,'Units','Inches','Position',[6 1 2 4],'Renderer','painters'); set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;
 



subplot('Position',[0.2 .05 0.1 .9]); hold on;

bar(.5,1,'Facecolor','w')
bar(.5,gridfrac+borderfrac+headfrac+cuegridfrac+bordercuefrac+cuefrac, 'Facecolor',cuecolor)
bar(.5,gridfrac+borderfrac+headfrac+cuegridfrac+bordercuefrac,         'Facecolor',[1 0 1])
bar(.5,gridfrac+borderfrac+headfrac+cuegridfrac,                       'Facecolor',[1 1 0])
bar(.5,gridfrac+borderfrac+headfrac,                                   'Facecolor',headcolor)
bar(.5,gridfrac+borderfrac,                                            'Facecolor',bordercolor)
bar(.5,gridfrac,                                                       'Facecolor',gridcolor)


text(1.4,.87,'Unclassified','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,.67,'Cue/Cue-Head','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,.59,'Cue-Border','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,.52,'Cue-Grid','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,.41,'Head only','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,.29,'Border/','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,.225,'Border-head','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,.115,'Grid/','HorizontalAlignment','Left','FontSize',labelsfontsize)
text(1.4,0.048,'Grid-head','HorizontalAlignment','Left','FontSize',labelsfontsize)

axis([0 1 0 1.01])
set(gca,'XTick',[],'YTick',0:.2:1); set(gca,'FontSize',fontsize)

% cd(directories.figure); print('-dsvg', '-r300', 'fig_3d');close all;
% 
% 
% 
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 

celllisti_stability_RE        = database.celltypes.clusterlisti.stability_RE;

celllisti_border_stability_RE = intersect(database.celltypes.clusterlisti.border,celllisti_stability_RE);
celllisti_cue_stability_RE    = intersect(database.celltypes.clusterlisti.cue,celllisti_stability_RE);
celllisti_grid_stability_RE   = intersect(database.celltypes.clusterlisti.grid,celllisti_stability_RE);
celllisti_head_stability_RE   = intersect(database.celltypes.clusterlisti.head,celllisti_stability_RE);

allbordercueinds  = sort(unique([celllisti_border_stability_RE celllisti_cue_stability_RE]));
allbordergridinds = sort(unique([celllisti_border_stability_RE celllisti_grid_stability_RE]));
allcuegridinds    = sort(unique([celllisti_cue_stability_RE celllisti_grid_stability_RE]));

allbordercuegridinds = sort(unique([celllisti_border_stability_RE celllisti_cue_stability_RE celllisti_grid_stability_RE]));

allbordercuegridheadinds = sort(unique([celllisti_border_stability_RE celllisti_cue_stability_RE ...
    celllisti_grid_stability_RE celllisti_head_stability_RE]));

celllisti_stable_prevunclassified = setdiff(celllisti_stability_RE,[celllisti_border_stability_RE celllisti_grid_stability_RE]);


inds_headonly         = setdiff(celllisti_head_stability_RE,allbordercuegridinds);
inds_borderborderhead = setdiff(celllisti_border_stability_RE,allcuegridinds);
inds_cuecuehead       = setdiff(celllisti_cue_stability_RE,allbordergridinds);
inds_gridgridhead     = setdiff(celllisti_grid_stability_RE,allbordercueinds);
inds_other            = setdiff(celllisti_stability_RE,allbordercuegridheadinds);

inds_bordercue  = intersect(celllisti_border_stability_RE,celllisti_cue_stability_RE);
inds_cuegrid    = intersect(celllisti_cue_stability_RE,celllisti_grid_stability_RE);
inds_bordergrid = intersect(celllisti_border_stability_RE,celllisti_grid_stability_RE);

inds_bordercuegrid = intersect(inds_bordercue,inds_cuegrid);

inds_bordercue  = setdiff(inds_bordercue,inds_bordercuegrid);
inds_cuegrid    = setdiff(inds_cuegrid,inds_bordercuegrid);
inds_bordergrid = setdiff(inds_bordergrid,inds_bordercuegrid);

numstability_RE = length(celllisti_stability_RE);

numborder = length(inds_borderborderhead);
numcue    = length(inds_cuecuehead);
numgrid   = length(inds_gridgridhead);
numhead   = length(inds_headonly);
numother  = length(inds_other);

numbordercue  = length(inds_bordercue);
numcuegrid    = length(inds_cuegrid);
numbordergrid = length(inds_bordergrid);

borderfrac = numborder/numstability_RE;
cuefrac    = numcue/numstability_RE;
gridfrac   = numgrid/numstability_RE;
headfrac   = numhead/numstability_RE;
otherfrac  = numother/numstability_RE;

bordercuefrac  = numbordercue/numstability_RE;
cuegridfrac    = numcuegrid/numstability_RE;
bordergridfrac = numbordergrid/numstability_RE;

  
 


