clear all;
close all;
home

directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';
directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/figures_updated_20190219/newpanels/';

cd(directories.database)
load('envdata')

cd(directories.analysis)
load('database_MECbygridscore_goodunique_removeduplicates.mat')

fontsize = 12;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

all_lags = [];
all_fieldwidths = [];
eqtemp.env = struct();
eqtemp.cuescores = [];

for envind = 1:9
    lags =  database.envcelldata(envind).cue.lags_sorted;
    frates = database.envcelldata(envind).allcells.viscueviswall.frates_sorted;
    fields = database.envcelldata(envind).allcells.viscueviswall.fields_sorted;
    for cellind = 1:length(lags)
        [fieldwidths_cm,cuewidths_cm] = get_fieldwidths(frates(cellind,:),fields(cellind,:),envdata(envind).viscueviswall.templates.cue);
        all_lags = [all_lags 5*lags(cellind)];
        all_fieldwidths = [all_fieldwidths mean(fieldwidths_cm(~isnan(fieldwidths_cm)))];
    end
end

all_lags = double(all_lags);

[r,p] = corrcoef(all_lags,all_fieldwidths);

histmat  = run_hist2(all_lags, all_fieldwidths, -90:10:90, 10:10:450);
figure; set(gcf,'Units','Inches','Position',[3 6 5 6],'Renderer','painters');
subplot('Position',[.2 .2 0.6 .6]); hold on;
imagesc(-85:10:90,15:10:450,histmat); axis xy;
axis([-90 90 10 450]);
text(-140,220,'Mean field width (cm)','Rotation',90,'HorizontalAlignment','Center','FontSize',14);
text(0,-40,'Spatial shift (cm)','HorizontalAlignment','Center','FontSize',14);
set(gca,'FontSize',14);colorbar;
colormap('parula')
 cd(directories.figure); print('-dbmp', '-r300', 'fig4b');

