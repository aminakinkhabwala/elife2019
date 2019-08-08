  close all; home
% clear all;
% 
% directories.database = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/2014data/';
% directories.analysis = '/Users/amina/Dropbox/cuecellpaper_eliferesubmission_20190102/analysis/';
% directories.figure = '/Users/amina/Dropbox/cueCellPaper/elife_resubmission/figures_updated_20190219/newpanels/';
% 
% cd(directories.database)
% load('envdata')
% 
% cd(directories.analysis)
% load('database_MECbygridscore_goodunique_removeduplicates')
% 
% startbinrange   = [1 43];
% pathintbinrange = [51 160];
% celllist        = database.clusterlist(database.celltypes.clusterlisti.cue);
% fontsize         = 18;
% 
% maxlag_sec   = 1;
% plotrange_cm = [0 800];
% 
% % colors = .85*linspecer(8,'qualitative');
% 
% 
% for cellind = 1:length(celllist)
%     currentcell = celllist{cellind};
%     inds = strfind(currentcell,'_');
%     cellstarts{cellind} = currentcell(1:inds(2)-1);
%     clear currentcell inds
% end
% 
% filestarts = unique(cellstarts);
% expdata = struct();
% for fileind = 1:length(filestarts)
%     expdata(fileind).celllist = [];
%     for cellind = 1:length(cellstarts)
%         if strcmp(filestarts{fileind},cellstarts{cellind})
%             expdata(fileind).celllist{end+1} = celllist(cellind);
%             expdata(fileind).filestart = filestarts{fileind};
%         end
%     end
% end
% 
% cd(directories.database)
%  experimentswithpairs = struct(); expind = 1;
% for fileind = 1:length(expdata)
%     if length(expdata(fileind).celllist)>1
%         load(char(expdata(fileind).celllist{1}))
%    if ~isempty(clusterdata.VR.spikedata.flowdisruns)
%             experimentswithpairs(expind).celllist = expdata(fileind).celllist;
%                 experimentswithpairs(expind).filestart = expdata(fileind).filestart;
%       expind = expind+1;
%    end
%     end
% end
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% flowvis_phases_sec = [];
% flowdis_phases_sec = [];
% flowvis_start_phases_sec = [];
% flowdis_start_phases_sec = [];
% flowvis_pathint_phases_sec = [];
% flowdis_pathint_phases_sec = [];
% 
% flowvis_phases_cm = [];
% flowdis_phases_cm = [];
% flowvis_start_phases_cm = [];
% flowdis_start_phases_cm = [];
% flowvis_pathint_phases_cm = [];
% flowdis_pathint_phases_cm = [];
% 
% 
% for expind = 1:length(experimentswithpairs)
%     cd(directories.database)
%     celllist = experimentswithpairs(expind).celllist;
%     celldata = [];
%     for cellind = 1:length(celllist)
%         load(char(celllist{cellind}))
%         celldata(cellind).name        = celllist{cellind};
%         celldata(cellind).clusterdata = clusterdata;
%         clear clusterdata
%     end
%     clear cellind
%     
%     pairdata = get_VR_phases_flowvisdis_start_pathint(celldata,maxlag_sec,startbinrange,pathintbinrange);
%     
%         clear celldata celllist
%     for pairind = 1:length(pairdata)
%         if ~isempty(pairdata(pairind).flowvis)
%                         figure(100*expind+pairind)
%                         plot(pairdata(pairind).flowvis.lags_sec,pairdata(pairind).flowvis.spiketimecorr)
%             lags_sec = pairdata(pairind).flowvis.lags_sec;
%             lags_cm = pairdata(pairind).flowvis.lags_cm;
%             
%             flowvis_phases_sec         = [flowvis_phases_sec pairdata(pairind).flowvis.phase_sec];
%             flowdis_phases_sec         = [flowdis_phases_sec pairdata(pairind).flowdis.phase_sec];
%             flowvis_start_phases_sec   = [flowvis_start_phases_sec pairdata(pairind).flowvis_start.phase_sec];
%             flowdis_start_phases_sec   = [flowdis_start_phases_sec pairdata(pairind).flowdis_start.phase_sec];
%             flowvis_pathint_phases_sec = [flowvis_pathint_phases_sec pairdata(pairind).flowvis_pathint.phase_sec];
%             flowdis_pathint_phases_sec = [flowdis_pathint_phases_sec pairdata(pairind).flowdis_pathint.phase_sec];
%             
%             flowvis_phases_cm         = [flowvis_phases_cm pairdata(pairind).flowvis.phase_cm];
%             flowdis_phases_cm         = [flowdis_phases_cm pairdata(pairind).flowdis.phase_cm];
%             flowvis_start_phases_cm   = [flowvis_start_phases_cm pairdata(pairind).flowvis_start.phase_cm];
%             flowdis_start_phases_cm   = [flowdis_start_phases_cm pairdata(pairind).flowdis_start.phase_cm];
%             flowvis_pathint_phases_cm = [flowvis_pathint_phases_cm pairdata(pairind).flowvis_pathint.phase_cm];
%             flowdis_pathint_phases_cm = [flowdis_pathint_phases_cm pairdata(pairind).flowdis_pathint.phase_cm];
%         end
%     end
% end
% 
% inds = find(flowvis_phases_cm==0);
% 
% flowvis_phases_sec(inds) = [];
% flowdis_phases_sec(inds) = [];
% flowvis_start_phases_sec(inds) = [];
% flowdis_start_phases_sec(inds) = [];
% flowvis_pathint_phases_sec(inds) = [];
% flowdis_pathint_phases_sec(inds) = [];
% 
% flowvis_phases_cm(inds) = [];
% flowdis_phases_cm(inds) = [];
% flowvis_start_phases_cm(inds) = [];
% flowdis_start_phases_cm(inds) = [];
% flowvis_pathint_phases_cm(inds) = [];
% flowdis_pathint_phases_cm(inds) = [];

figure; set(gcf,'Units','Inches','Position',[1 10 6 3],'Renderer','painters'); set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;
subplot('Position',[0.1 .15 .7 .7]); hold on
VR_2Dphasehist  = run_hist2(flowvis_phases_sec,flowvis_phases_cm, lags_sec,lags_cm);
set(gca,'FontSize',18)
imagesc(lags_cm,lags_sec,VR_2Dphasehist');colormap('pink');
% axis off;
axis([-100 100 -1 1])
set(gca,'CLim',[0 3]); axis xy; colorbar
line([-100 100],[0 0],'Color','w','LineStyle',':'); line([0 0],[-1 1],'Color','w','LineStyle',':')
[rall,pall] = corrcoef(flowvis_phases_cm,flowvis_phases_sec)


cd(directories.figure); print('-depsc2', '-r300', 'fig5b');close all;


% % % % % % % % % % % % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % % % % % startcolor = [.5 .5 .5];
% % % % % % % % % % % % pathintcolor = [0 0 1];
% % % % % % % % % % % % 
% % % % % % % % % % % % % % %
% % % % % % % % % % % % figure; set(gcf,'Units','Inches','Position',[1 4 7 2],'Renderer','OpenGL'); set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;
% % % % % % % % % % % % 
% % % % % % % % % % % % subplot('Position',[.1 .15 .4  .7]); hold on
% % % % % % % % % % % % x = flowvis_start_phases_sec;
% % % % % % % % % % % % y = flowdis_start_phases_sec;
% % % % % % % % % % % % 
% % % % % % % % % % % % naninds = sort(unique([find(isnan(x)) find(isnan(y))])); x(naninds) = []; y(naninds) = [];
% % % % % % % % % % % % xphases  = sort(unique(x));
% % % % % % % % % % % % 
% % % % % % % % % % % % for phaseind = 1:length(xphases)
% % % % % % % % % % % %     phaseinds = find(x==xphases(phaseind));
% % % % % % % % % % % %     if ~isempty(phaseinds)
% % % % % % % % % % % %         y_mean(phaseind) = mean(y(phaseinds));
% % % % % % % % % % % %         y_std(phaseind) = std(y(phaseinds))/(length(phaseinds)^.5);
% % % % % % % % % % % %         xphases(phaseind)
% % % % % % % % % % % %     end
% % % % % % % % % % % %     plot(xphases(phaseind),y_mean(phaseind),'o','MarkerFaceColor',startcolor,'MarkerEdgeColor',startcolor,'MarkerSize',3)
% % % % % % % % % % % %     line([xphases(phaseind) xphases(phaseind)],[y_mean(phaseind)-y_std(phaseind)   y_mean(phaseind)+y_std(phaseind)],'Color',startcolor)
% % % % % % % % % % % % end
% % % % % % % % % % % % axis([-1 1 -1 1]); axis square;
% % % % % % % % % % % % set(gca,'XTick',-1:.5:1,'Ytick',-1:.5:1)
% % % % % % % % % % % % line([-1 1],[0 0],'Color',[.6 .6 .6],'LineStyle',':')
% % % % % % % % % % % % line([0 0],[-1 1],'Color',[.6 .6 .6],'LineStyle',':')
% % % % % % % % % % % % 
% % % % % % % % % % % % clear x y
% % % % % % % % % % % % subplot('Position',[0.6 .15 .4 .7]); hold on
% % % % % % % % % % % % x = flowvis_pathint_phases_sec;
% % % % % % % % % % % % y = flowdis_pathint_phases_sec;
% % % % % % % % % % % % 
% % % % % % % % % % % % naninds = sort(unique([find(isnan(x)) find(isnan(y))])); x(naninds) = []; y(naninds) = [];
% % % % % % % % % % % % xphases  = sort(unique(x));
% % % % % % % % % % % % 
% % % % % % % % % % % % 
% % % % % % % % % % % % for phaseind = 1:length(xphases)
% % % % % % % % % % % %     phaseinds = find(x==xphases(phaseind));
% % % % % % % % % % % %     if ~isempty(phaseinds)
% % % % % % % % % % % %         y_mean(phaseind) = mean(y(phaseinds));
% % % % % % % % % % % %         y_std(phaseind) = std(y(phaseinds))/(length(phaseinds)^.5);
% % % % % % % % % % % %         xphases(phaseind)
% % % % % % % % % % % %     end
% % % % % % % % % % % %     plot(xphases(phaseind),y_mean(phaseind),'o','MarkerFaceColor',pathintcolor,'MarkerEdgeColor',pathintcolor,'MarkerSize',3)
% % % % % % % % % % % %     line([xphases(phaseind) xphases(phaseind)],[y_mean(phaseind)-y_std(phaseind)   y_mean(phaseind)+y_std(phaseind)],'Color',pathintcolor)
% % % % % % % % % % % % end
% % % % % % % % % % % % axis([-1 1 -1 1]); axis square;
% % % % % % % % % % % % set(gca,'XTick',-1:.5:1,'Ytick',-1:.5:1)
% % % % % % % % % % % % line([-1 1],[0 0],'Color',[.6 .6 .6],'LineStyle',':')
% % % % % % % % % % % % line([0 0],[-1 1],'Color',[.6 .6 .6],'LineStyle',':')
% % % % % % % % % % % % %  cd(directories.figure); print('-dsvg', '-r300', '5c');close all;
% % % % % % % % % % % % % %%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % % % % % % % % % 

lags_sec = pairdata(pairind).flowvis.lags_sec;
[rst,pst] = corrcoef(flowdis_start_phases_sec,flowvis_start_phases_sec)
[rpth,ppth] = corrcoef(flowdis_pathint_phases_sec,flowvis_pathint_phases_sec)


figure; set(gcf,'Units','Inches','Position',[1 4 6 3],'Renderer','painters'); set(gcf,'PaperPositionMode','auto','InvertHardcopy','off','PaperSize',[10 10],'Color',[1 1 1]); hold on;

subplot('Position',[.1 .15 .4  .7]); hold on

flowvisdis_start_phasehist  = run_hist2(flowvis_start_phases_sec,flowdis_start_phases_sec, lags_sec,lags_sec);
flowvisdis_start_phasehist(11,11) = NaN;
set(gca,'FontSize',18)
imagesc(lags_sec,lags_sec,flowvisdis_start_phasehist');
axis([-1 1 -1 1])
set(gca,'CLim',[0 4]); axis xy; colorbar
line([-1 1],[0 0],'Color','w','LineStyle',':'); line([0 0],[-1 1],'Color','w','LineStyle',':')
axis square;

subplot('Position',[0.6 .15 .4 .7]); hold on

flowvisdis_pathint_phasehist  = run_hist2(flowvis_pathint_phases_sec,flowdis_pathint_phases_sec, lags_sec,lags_sec);
flowvisdis_pathint_phasehist(11,11) = NaN;
set(gca,'FontSize',18)
imagesc(lags_sec,lags_sec,flowvisdis_pathint_phasehist');
axis([-1 1 -1 1])
set(gca,'CLim',[0 4]); axis xy; colorbar
line([-1 1],[0 0],'Color','w','LineStyle',':'); line([0 0],[-1 1],'Color','w','LineStyle',':')
axis square;
colormap('pink')
cd(directories.figure); print('-depsc2', '-r300', 'fig5c');close all;

