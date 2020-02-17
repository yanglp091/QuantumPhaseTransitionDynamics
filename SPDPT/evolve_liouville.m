function [output,tlist]=evolve_liouville(para,rho0, obs)
  
    tlist=para.timelist;
    nstep=length(tlist);
    output=cell(nstep,1);
    Ops=pre_Liouville(para,rho0);
    vec0=Ops.rho_vec0;
    output{1,1}=ObsMeanLouville(obs,vec0); 
    echo_opt=para.echo_opt;
    
    for j = 2:nstep 
        t=tlist(j);
        tstep=tlist(j)-tlist(j-1);
        
        if echo_opt>0
            disp(['Running the' num2str(j) 'th loop with time = ' num2str(t) '...']);        
            tic
        end
        Ltot=LConstruct(para,Ops,t); 
        vec0=expv(tstep,Ltot,vec0);        
        output{j,1}=ObsMeanLouville(obs,vec0);  
        if echo_opt>0
            toc
        end
    end
end