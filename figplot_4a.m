
close all; home
clear all;
directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';
directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/finalfigures/subpanels/';

cd(directories.database)
load('envdata')
cd(directories.analysis)
load('database_MECbygridscore_goodunique_removeduplicates')

celltype = 'cue';
fontsize = 20;

colors = lines;
virmencolor = [0.4 .4 .4];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
envind = 1;
    numcells = length(database.envcelldata(envind).cue.viscueviswall.fields_sorted(:,1));
    
    figure; set(gcf,'Units','Inches','Position',[1 1 7 10],'Renderer','opengl');
    
    subplot('Position',[.1 .7 .8 .25]); hold on;
    frateplot = imagesc(2.5:5:800,1:numcells,database.envcelldata(envind).cue.viscueviswall.frates_normsorted);
    axis xy; axis([0 800 0 numcells+1])
    set(gca,'YTick',[1 numcells],'XTick',[],'FontSize',fontsize)
         colormap(gca,'jet')
    
     subplot('Position',[.1 .375 .8 .25]); hold on;
    fields =  database.envcelldata(envind).cue.viscueviswall.fields_sorted;
    fields(find(fields==0)) = NaN;
    fieldplot = imagesc(2.5:5:800,1:numcells,fields); axis xy;
    set(fieldplot,'AlphaData',~isnan(fields))
    colormap(gca,'gray')
    set(gca,'Clim',[0 10])
    set(gca,'YTick',[1 numcells],'XTick',[],'FontSize',fontsize)
    axis xy; axis([0 800 0 numcells+1])
     
      subplot('Position',[.1 .05 .8 .25]); hold on;
       cuetemplate = envdata(envind).viscueviswall.templates.cue;
    shuffled_frates=[];
    shuffles_cuescore=[];
    shuffles_lag=[];
    celllist = database.envcelldata(envind).cue.celllist;
    numcells = length(celllist);

    frates_sorted = database.envcelldata(envind).cue.viscueviswall.frates_sorted;
    frates_sorted_lag = double(database.envcelldata(envind).cue.lags_sorted);
    fields_sorted = database.envcelldata(envind).cue.viscueviswall.fields_sorted;

    for cellind = 1:length(celllist)
        [shuffled_frate] = shuffle_fields(frates_sorted(cellind,:),fields_sorted(cellind,:),1);
        [shuffles_cuescore(cellind),shuffles_lag(cellind),~] = get_cuescore(shuffled_frate,cuetemplate);
        shuffled_frates(cellind,:) = shuffled_frate;
    end

    [~,sortinds] = sort(shuffles_lag);

    shuffled_frates_sorted     = shuffled_frates(sortinds,:);
    max_shuffled_frates_sorted = max(shuffled_frates_sorted,[],2);
    shuffled_frates_normsorted = shuffled_frates_sorted./repmat(max_shuffled_frates_sorted,1,160);
    shuffled_frates_sorted_lag   = shuffles_lag(sortinds);
      
    imagesc(2.5:5:800,1:numcells,shuffled_frates_normsorted);
    axis xy; axis([0 800 .5 numcells+.5]); colormap(gca,'jet')
    set(gca,'YTick',[1 numcells],'XTick',0:400:800); set(gca,'FontSize',fontsize)

  cd(directories.figure); print('-dbmp', '-r300', 'fig_4a1');close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
envind = 7;
    numcells = length(database.envcelldata(envind).cue.viscueviswall.fields_sorted(:,1));
    
    figure; set(gcf,'Units','Inches','Position',[1 1 7 10],'Renderer','opengl');
    
    subplot('Position',[.1 .7 .8 .25]); hold on;
    frateplot = imagesc(2.5:5:800,1:numcells,database.envcelldata(envind).cue.viscueviswall.frates_normsorted);
    axis xy; axis([0 800 0 numcells+1])
    set(gca,'YTick',[1 numcells],'XTick',[],'FontSize',fontsize)
         colormap(gca,'jet')
    
     subplot('Position',[.1 .375 .8 .25]); hold on;
    fields =  database.envcelldata(envind).cue.viscueviswall.fields_sorted;
    fields(find(fields==0)) = NaN;
    fieldplot = imagesc(2.5:5:800,1:numcells,fields); axis xy;
    set(fieldplot,'AlphaData',~isnan(fields))
    colormap(gca,'gray')
    set(gca,'Clim',[0 10])
    set(gca,'YTick',[1 numcells],'XTick',0:400:800,'FontSize',fontsize)
    axis xy; axis([0 800 0 numcells+1])
         
   subplot('Position',[.1 .05 .8 .25]); hold on;
       cuetemplate = envdata(envind).viscueviswall.templates.cue;
    shuffled_frates=[];
    shuffles_cuescore=[];
    shuffles_lag=[];
    celllist = database.envcelldata(envind).cue.celllist;
    numcells = length(celllist);

    frates_sorted = database.envcelldata(envind).cue.viscueviswall.frates_sorted;
    frates_sorted_lag = double(database.envcelldata(envind).cue.lags_sorted);
    fields_sorted = database.envcelldata(envind).cue.viscueviswall.fields_sorted;

    for cellind = 1:length(celllist)
        [shuffled_frate] = shuffle_fields(frates_sorted(cellind,:),fields_sorted(cellind,:),1);
        [shuffles_cuescore(cellind),shuffles_lag(cellind),~] = get_cuescore(shuffled_frate,cuetemplate);
        shuffled_frates(cellind,:) = shuffled_frate;
    end

    [~,sortinds] = sort(shuffles_lag);

    shuffled_frates_sorted     = shuffled_frates(sortinds,:);
    max_shuffled_frates_sorted = max(shuffled_frates_sorted,[],2);
    shuffled_frates_normsorted = shuffled_frates_sorted./repmat(max_shuffled_frates_sorted,1,160);
    shuffled_frates_sorted_lag   = shuffles_lag(sortinds);
      
    imagesc(2.5:5:800,1:numcells,shuffled_frates_normsorted);
    axis xy; axis([0 800 .5 numcells+.5]); colormap(gca,'jet')
    set(gca,'YTick',[1 numcells],'XTick',0:400:800); set(gca,'FontSize',fontsize)

    
% cd(directories.figure); print('-dbmp', '-r300', 'fig_4a2');close all;
%%%%%%%%%%%%%%%
all_ridgeratios = [];
all_shuffles_ridgeratios = [];
for envind = 1:9
  
    cuetemplate = envdata(envind).viscueviswall.templates.cue;
    
    celllist = database.envcelldata(envind).cue.celllist;
    numcells = length(celllist);
    
    frates_sorted = database.envcelldata(envind).cue.viscueviswall.frates_sorted;
    frates_sorted_lag = double(database.envcelldata(envind).cue.lags_sorted);
    fields_sorted = database.envcelldata(envind).cue.viscueviswall.fields_sorted;
    
    for cellind = 1:length(celllist)
                 [envind cellind]
  [shuffled_frate] = shuffle_fields(frates_sorted(cellind,:),fields_sorted(cellind,:),1);
        [shuffles_cuescore,shuffles_lag,~] = get_cuescore(shuffled_frate,cuetemplate);
        ridgeratio = get_ridgeratio(frates_sorted(cellind,:),frates_sorted_lag(cellind),cuetemplate);
        shuffles_ridgeratio = get_ridgeratio(shuffled_frate,shuffles_lag,cuetemplate);
        all_ridgeratios = [all_ridgeratios ridgeratio];
        all_shuffles_ridgeratios = [all_shuffles_ridgeratios shuffles_ridgeratio];
    end
end

binedges = 0:.2:10;
bincenters = 0.5*mean(diff(binedges))+binedges(1:end-1);
ridgedist = histc(ridgeratio,binedges); ridgedist(end) = [];
ridgeratio_mean = mean(ridgeratio);
ridgeratio_std  = std(ridgeratio);
shuffles_ridgedist = histc(shuffles_ridgeratio,binedges); shuffles_ridgedist(end) = [];
shuffles_ridgeratio_mean = mean(shuffles_ridgeratio);
shuffles_ridgeratio_std = std(shuffles_ridgeratio);


figure; set(gcf,'Units','Inches','Position',[1 1 2 2],'Renderer','painters');
bar([mean(all_ridgeratios) mean(all_shuffles_ridgeratios)],.6,'FaceColor',[.2 .2 .2],'EdgeColor',[.2 .2 .2])
set(gca,'FontSize',fontsize)
set(gca,'XTick',[],'YTick',[0:4])
line([2 2],[mean(all_shuffles_ridgeratios)-std(all_shuffles_ridgeratios) mean(all_shuffles_ridgeratios)+std(all_shuffles_ridgeratios)],'Color','k','LineWidth',1.5)
% cd(directories.figure); print('-dsvg', '-r300', '4a3');close all;

[h,p] = ttest(all_ridgeratios,all_shuffles_ridgeratios,'Tail','right');


