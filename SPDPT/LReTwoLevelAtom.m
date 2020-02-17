function  Ltot = LReTwoLevelAtom(para,Ops,t)
    pulsetype=para.pulsetype;
    gamma = para.gamma;
    Gamma = para.Gamma;
    Jgg = Ops.Jgg;
    Jeg = Ops.Jeg;
    [dimd,~]=size(Jgg); Id=speye(dimd);

    tauf=para.tauf;% length of the Gaussian pulse
    xi = 1/(2*pi*tauf^2)^(1/4)*exp(-t^2/4/tauf^2);

    switch pulsetype 
        case 'FockState'
%             taup= sparse([0,1;0,0]); Ip=speye(2);                       
%             
%             % decay back to state |g>
%             Lloss1 = gamma*kron(kron(Ip,Jfg'), kron(Ip,Jfg).') ...
%                 - 0.5*gamma*kron(kron(Ip,Jff), kron(Ip,Id)) ...
%                 - 0.5*gamma*kron(kron(Ip,Id), kron(Ip,Jff).');
%             % relaxiation to state |e>
%             Lloss2 = Gamma*kron(kron(Ip,Jfe'), kron(Ip,Jfe).') ...
%                 - 0.5*Gamma*kron(kron(Ip,Jff), kron(Ip,Id)) ...
%                 - 0.5*Gamma*kron(kron(Ip,Id), kron(Ip,Jff).');
%             
%             Lp = sqrt(gamma)*xit*(kron(kron(taup,Jfg), kron(Ip,Id)) - kron(kron(taup,Id), kron(Ip,Jfg).') );
%             Lm = sqrt(gamma)*xit'*(kron(kron(Ip,Id), kron(taup',Jfg').') - kron(kron(Ip,Jfg'), kron(taup', Id).') );
%             Ltot = Lloss1+Lloss2+Lp+Lm;
            Ltot = 0;
            
        case 'CoherentState'
            
            gammat = gamma*Gamma/(gamma+Gamma);% tilde{gamma}
            xit2 = 2*xi^2/(gamma+Gamma+2*gamma*xi^2);% tilde{xi}^2
            Ltot = gammat*xit2*( kron( Jeg, (Jeg').') - 0.5*kron( Jgg, Id) - 0.5*kron( Id, Jgg.') );            
            otherwise
            error('The Louvillian for two-level atom model under his type of pulse has not been defined!');
            
    end
            
  end
            