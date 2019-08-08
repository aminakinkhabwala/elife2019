function [cuescore,lag] = cueScoreCalcium(dfof,template,maxLag)

%inputs
%dfof: mean dfof
%template: cue template
%maxLag: maximal allowed spatial shift in bumber of bins. bin size is 5cm. so in the paper we used number 60,
%which is the spatial shift of 300cm

A=dfof==0;
if isempty(find(A==0));
    cuescore=0;
    lag=0;
else
    
numbins = length(template);
[frate_corr,frate_lags] = xcorr(template, dfof-mean(dfof), maxLag,'coeff');
[~,frate_lagsi_peaks]   = findpeaks(frate_corr);



if isempty(frate_lagsi_peaks);
    [~,frate_lagsi_peaks]=max(frate_corr);
end
[~,minlag_peaklagindex] = min(abs(frate_lags(frate_lagsi_peaks)));

if isempty(minlag_peaklagindex)
    lag  = nan;
    cuescore = nan;
else
    lag  = frate_lags(frate_lagsi_peaks(minlag_peaklagindex));
   
    A=contiguous(template);
    AA=A{2,2};
    
    cuestarts=AA(:,1);
    cueends=AA(:,2);
   cuewidths=cueends-cuestarts+1;
    
    if isempty(find((cueends+0.5*cuewidths)>numbins))
        
        numcues  = length(cuestarts);
    else
        
        i=find((cueends+0.5*cuewidths)>numbins);
        idx=setdiff(1:1:length(cuestarts),i);
        cuestarts=cuestarts(idx);
        cueends=cueends(idx);
        cuewidths=cuewidths(idx);
        numcues = length(cuestarts);
    end
    
   
 
    if ~isempty(find((cuestarts-0.5*cuewidths)<1))
        i=find((cuestarts-0.5*cuewidths)<1);
   idx=setdiff(1:1:length(cuestarts),i);
        cuestarts=cuestarts(idx);
        cueends=cueends(idx);
        cuewidths=cuewidths(idx);
        numcues = length(cuestarts);
    end
    
    cuescores = nan(numcues,1);
    for cueind = 1:numcues
        
        cuehalfwidth = round(0.5*length(cuestarts(cueind):(cueends(cueind))));
        cuebins  = (cuestarts(cueind)-cuehalfwidth):(cueends(cueind)+cuehalfwidth);
        
        peakbins = cuebins-lag;
        
        if ~isempty(find(peakbins>numbins))

peakbins=[];
                       
        elseif ~isempty(find(peakbins<=0))
            peakbins=[];

        end
        
        frate_current = dfof(peakbins)-mean(dfof(peakbins));
        template_current = template(cuebins)-mean(template);
        
        if ~isempty(frate_current);
        cuescores(cueind) = xcorr(frate_current,template_current,0,'coeff');
        end
    end
    cuescores=cuescores(~isnan(cuescores));
    cuescore = mean(cuescores);
end
end  
end

