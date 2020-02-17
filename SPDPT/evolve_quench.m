function [output,tlist]=evolve_quench(para,state, obs,vp0,var_para)
    tlist=para.timelist;
    dvp=para.delta_vp;
    
    [nrow,ncol]=size(state);
    state_option='Pure';    
    if nrow>1 && ncol >1
       state_option = 'Mixed';
       state = state(:);
    end   
    
     vp=vp0 + dvp;
     eval(['para.' var_para '=vp;']);
     Htot=HDicke(para);
    
    nstep=length(tlist);
    output=cell(nstep,1);      
    output{1,1}=ObsMean(obs,state,state_option); 
    echo_opt=para.echo_opt;
    
    for j = 2:nstep 
        t=tlist(j);
        tstep=tlist(j)-tlist(j-1);
        if echo_opt>0
            disp(['Running the' num2str(j) 'th loop with time = ' num2str(t) '...']);        
            tic
        end        
       
        Ltot=Htot(:,:);
        if strcmp(state_option,'Mixed')
            [dim,~] = size(Ltot);
            Idd = speye(dim);
            Ltot = kron(Ltot,Idd)-kron(Idd,Ltot.');
        end
        state=expv(tstep,-1i*Ltot(:,:),state); 
        
        output{j,1}=ObsMean(obs,state,state_option);  
        if echo_opt>0
            toc
        end
    end
end