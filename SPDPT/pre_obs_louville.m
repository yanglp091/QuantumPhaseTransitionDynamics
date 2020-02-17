function    obs = pre_obs_louville(para, hf)
    if nargin <2
        hf=0;
    end

    model = para.Model;
    pulsetype=para.pulsetype;
    
    switch pulsetype    
        case 'FockState'
               idp = sparse([1,0;0,0]);
        case 'CoherentState'
               idp = 1;
        otherwise
            error('No such kind of pulsetype for this model!');
    end
    
    switch model
        
        case 'Dicke'
            na=para.natom;
            hfl=kron(idp, hf(:,:) );
            obs.PhotonNumber=hfl(:)/na;
        case 'TwoLevelAtom'
            pro_e = sparse([1,0;0,0]);
            Pe=kron(idp, pro_e );
            obs.Pe=Pe(:);
        case 'ThreeLevelAtom'
            pro_f = sparse([1,0,0;0,0,0;0,0,0]);
            Pf=kron(idp, pro_f );
            pro_e = sparse([0,0,0;0,1,0;0,0,0]);
            Pe=kron(idp, pro_e );
            pro_g = sparse([0,0,0;0,0,0;0, 0,1]);
            Pg=kron(idp, pro_g );
            
            obs.Pf=Pf(:);
            obs.Pe=Pe(:);
            obs.Pg=Pg(:);
        case 'ReducedTwoLevelAtom'
            pro_e = sparse([1,0;0,0]);
            Pe=kron(idp, pro_e );
            pro_g = sparse([0,0;0,1]);
            Pg=kron(idp, pro_g );
            obs.Pe=Pe(:);
            obs.Pg=Pg(:);
        otherwise
            error('No such kind of observables for this model!');
    end

end

%% testing