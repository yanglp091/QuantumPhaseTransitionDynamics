function [lambda,idx]=CriticalCoupling(lambdalist,PNlist)
    nl=length(lambdalist);
    for j=1:nl
        pn=PNlist(j,:);
        dpn=diff(pn);%
        % the difference of PNlist along beta dimensioin
        npe=find(dpn>0, 1);% number of positive elements
        
        if ~isempty(npe)
            lambda=lambdalist(j);
            idx=j;
            return;
        end
        
       
    end
    
    idx=0;
    lambda=0;
end