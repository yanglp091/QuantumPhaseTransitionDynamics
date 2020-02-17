function  Ltot = LThreeLevelAtom(para,Ops,t)
    pulsetype=para.pulsetype;
    gammafg = para.gammafg;
    gammafe = para.gammafe;
    Jff = Ops.Jff;
    Jfg = Ops.Jfg;
    Jfe = Ops.Jfe;
    [dimd,~]=size(Jff); Id=speye(dimd);

    tauf=para.tauf;% length of the Gaussian pulse
    pulseshape=para.pulseshape;
    xit = PulseAmplitude(t, tauf, pulseshape);

    switch pulsetype 
        case 'FockState' 
            taup= sparse([0,1;0,0]); Ip=speye(2);                       
            
            % decay back to state |g>
            Lloss1 = gammafg*kron(kron(Ip,Jfg'), kron(Ip,Jfg).') ...
                - 0.5*gammafg*kron(kron(Ip,Jff), kron(Ip,Id)) ...
                - 0.5*gammafg*kron(kron(Ip,Id), kron(Ip,Jff).');
            % relaxiation to state |e>
            Lloss2 = gammafe*kron(kron(Ip,Jfe'), kron(Ip,Jfe).') ...
                - 0.5*gammafe*kron(kron(Ip,Jff), kron(Ip,Id)) ...
                - 0.5*gammafe*kron(kron(Ip,Id), kron(Ip,Jff).');
            
            Lp = sqrt(gammafg)*xit*(kron(kron(taup,Jfg), kron(Ip,Id)) - kron(kron(taup,Id), kron(Ip,Jfg).') );
            Lm = sqrt(gammafg)*xit'*(kron(kron(Ip,Id), kron(taup',Jfg').') - kron(kron(Ip,Jfg'), kron(taup', Id).') );
            Ltot = Lloss1+Lloss2+Lp+Lm;
            
            
        case 'CoherentState'
            Lloss1 = gammafg*( kron( Jfg', Jfg.') - 0.5*kron( Jff, Id) - 0.5*kron( Id, Jff.') );
            Lloss2 = gammafe*( kron( Jfe', Jfe.') - 0.5*kron( Jff, Id) - 0.5*kron( Id, Jff.') );
            Lp = sqrt(gammafg)*xit*( kron(Jfg, Id) - kron( Id, Jfg.') );
            Lm = sqrt(gammafg)*xit'*(kron( Id, (Jfg').') - kron( Jfg', Id));
            Ltot = Lloss1 + Lloss2 + Lp + Lm;
            otherwise
            error('The Louvillian for two-level atom model under his type of pulse has not been defined!');
            
    end
            
  end
            