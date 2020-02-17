function output=ObsMeanLouville(obs,rho_vec)      
    fnames = fieldnames(obs);
    nobs=length(fnames);
    for k=1:nobs
        fn=fnames{k,1};
        obs_vec=eval(['obs.' fn]);
        val=obs_vec'*rho_vec;
        eval(['output.' fn '=val;']);      
    end
        
end