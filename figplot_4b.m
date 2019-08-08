
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


all_lags = [];
for envind = 1:9
  
    cuetemplate = envdata(envind).viscueviswall.templates.cue;
    
    celllist = database.envcelldata(envind).cue.celllist;
    numcells = length(celllist);
    
    frates_sorted = database.envcelldata(envind).cue.viscueviswall.frates_sorted;
    frates_sorted_lag = double(database.envcelldata(envind).cue.lags_sorted);
    fields_sorted = database.envcelldata(envind).cue.viscueviswall.fields_sorted;
    
    for cellind = 1:length(celllist)
                 [envind cellind]
        all_lags = [all_lags frates_sorted_lag(cellind)];
    end
end



all_lags_cm = 5*all_lags;


figure; set(gcf,'Units','Inches','Position',[1 1 2 2],'Renderer','painters');
histogram(all_lags_cm,-90:10:90);
cd(directories.figure); print('-dsvg', '-r300', '4b');close all;



