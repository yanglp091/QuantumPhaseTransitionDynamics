function Ops=pre_Liouville(para, rho0)

    option=para.Model;
    pulsetype=para.pulsetype;

    %preparing the initial states
    switch pulsetype  
        case 'FockState'
            rho_tot0 = kron(sparse([1,0;0,1]), rho0 );

            Ops.rho_vec0=rho_tot0(:);
        case 'CoherentState'
           Ops.rho_vec0=rho0(:);
        otherwise
            error(['No such kind of initial state for this pulse type--- ' pulsetype '!']);
    end
    
    %preparing the operators in the master equation
    switch option        
        case 'Dicke'
            % the Hamiltonian of the Dicke Model
            [hd,~] = HDicke(para);
            Ops.Hext=hd(:,:);

            % the time-dependent Jp operator            
            dimf=para.dimf; idf= speye(dimf);
            na=para.natom;
            jp=sqrt(1/na)*jmat(na/2,'+');
            Ops.Jp=kron( idf, jp(:,:) );    
        
        case 'TwoLevelAtom'
            Ops.Hext=0;
            Jp = jmat(1/2,'+');
            Ops.Jp=Jp(:,:);            

        case 'ThreeLevelAtom'
            Ops.Hext=0;                       
            Ops.Jff=sparse([1 0 0;0 0 0;0 0 0]);            
            Ops.Jfg=sparse([0 0 1;0 0 0;0 0 0]); 
            Ops.Jfe=sparse([0 1 0;0 0 0;0 0 0]); 
            
        case 'ReducedTwoLevelAtom'
            Ops.Hext=0;                       
            Jeg = jmat(1/2,'+');
            Jgg = sparse([0 0; 0 ,1]);
            Ops.Jeg=Jeg(:,:);
            Ops.Jgg=Jgg;
        otherwise
            error(['No such kind of Model---' option '!']);
    end
end