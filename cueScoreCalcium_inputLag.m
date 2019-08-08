function [cuescore,lag] = cueScoreCalcium_inputLag(dfof,template,useLag)

%inputs
%dfof: mean dfof
%template: cue template
%useLag: this is the spatial shift in bin. bin size is 5cm. so for a 5cm spatial
%shift, input 1 for useLag.

A=dfof==0;
if isempty(find(A==0));
    cuescore=0;
    lag=useLag;
else
    
numbins = length(template);

    lag  = useLag;
   
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


