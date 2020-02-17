function  Ltot = LTwoLevelAtom(para,Ops,t)
    pulsetype=para.pulsetype;
    Jp=Ops.Jp;
    
    tauf=para.tauf;% length of the Gaussian pulse
    pulseshape=para.pulseshape;
    xit = PulseAmplitude(t, tauf, pulseshape);
    gamma = para.gamma;
    switch pulsetype 
        case 'FockState'
            taup= sparse([0,1;0,0]); Ip=speye(2);
            [dimd,~]=size(Jp); Id=speye(dimd);
            
            L0 = 0;
            Lloss = gamma*kron(kron(Ip,Jp'), kron(Ip,Jp).') - 0.5*gamma*kron(kron(Ip,Jp*Jp'), kron(Ip,Id).') - 0.5*gamma*kron(kron(Ip,Id), kron(Ip,Jp*Jp').');
            Lp = -xit*sqrt(gamma)*kron(kron(taup,Id), kron(Ip,Jp).') + xit*sqrt(gamma)*kron(kron(taup,Jp), kron(Ip,Id).');
            Lm = -xit'*sqrt(gamma)*kron(kron(Ip,Jp'), kron(taup', Id).') + xit'*sqrt(gamma)*kron(kron(Ip,Id), kron(taup',Jp').');
            Ltot = L0 + Lloss+Lp+Lm;
            
            
        case 'CoherentState'
           [dimd,~]=size(Jp); Id=speye(dimd);

            L0=0;
            Lloss = gamma*kron( Jp', Jp.' ) - 0.5*gamma*kron( Jp*Jp', Id) - 0.5*gamma*kron( Id, (Jp*Jp').' );
            Lp = - xit*sqrt(gamma)*kron( Id, Jp.') + xit*sqrt(gamma)*kron( Jp, Id );
            Lm = - xit'*sqrt(gamma)*kron( Jp', Id ) + xit'*sqrt(gamma)*kron( Id, (Jp').');
            Ltot=L0+Lloss+Lp+Lm;
            otherwise
            error('The Louvillian for two-level atom model under his type of pulse has not been defined!');
            
    end
            
  end
            