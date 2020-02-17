function output=ObsMean(obs,state,state_option)
%     [nrow,ncol]=size(state);
%     state_option='Pure';    
%     if nrow>1 && ncol >1
%        state_option = 'Mixed'; 
%     end
    
    fnames = fieldnames(obs);
    nobs=length(fnames);
    
    switch state_option
        case 'Pure'
            for k=1:nobs
                fn=fnames{k,1};
                obs_mat=eval(['obs.' fn]);
                val = state'*obs_mat(:,:)*state;
                eval(['output.' fn '=val;']);      
            end            
        case 'Mixed'
            for j=1:nobs
                fn=fnames{j,1};
                obsmat=eval(['obs.' fn '(:,:);']);
                obsvec=obsmat(:);

                val=diag(state'*obsvec);                
                eval(['output.' fn '=val;']);     
            end
        otherwise
            error(['No such of states ' state_option ' in Hilbert Spase!']);
    end
end