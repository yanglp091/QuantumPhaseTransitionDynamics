function  Ltot = LDicke(para,Ops,t)
    pulsetype=para.pulsetype;
    gamma = para.gamma;
    Gamma = para.Gamma;
    na = para.natom;
    
    tauf=para.tauf;% length of the Gaussian pulse
    xi = 1/(2*pi*tauf^2)^(1/4)*exp(-t^2/4/tauf^2);
    
    Jp = Ops.Jp;
    Hext = Ops.Hext;    
    [dimd,~]=size(Jp); Id=speye(dimd);

    


    switch pulsetype       
        case 'FockState'
%             tauf=para.tauf;% length of the Gaussian pulse
%             omega0=para.omega0;% center frequency of the pulse
%             xit = 1/(2*pi*tauf^2)^(1/4)*exp(-t^2/4/tauf^2)*exp(-1i*omega0*t);
%             
%             taup= sparse([0,1;0,0]); Ip=speye(2);
%             [dimd,~]=size(Hext); Id=speye(dimd);
%             Ld = -1i*kron(kron(Ip,Hext), kron(Ip,Id).') +1i* kron(kron(Ip,Id), kron(Ip,Hext).');
%             Lloss = kron(kron(Ip,Jp'), kron(Ip,Jp).') - 0.5*kron(kron(Ip,Jp*Jp'), kron(Ip,Id).') - 0.5*kron(kron(Ip,Id), kron(Ip,Jp*Jp').');
%             Lp = xit*kron(kron(taup,Id), kron(Ip,Jp).') - xit*kron(kron(taup,Jp), kron(Ip,Id).');
%             Lm = xit'*kron(kron(taup,Jp'), kron(taup', Id).') - xit'*kron(kron(Ip,Id), kron(taup',Jp').');
%             Ltot=Ld + Lloss + Lp + Lm;
              error('The Louivellian for Fock-State pulse is to be constructed.');
            
        case 'CoherentState'         
  
            gammat = gamma*Gamma/(gamma+Gamma)/na;% tilde{gamma}
            xit2 = 2*xi^2/(gamma+Gamma+2*gamma*xi^2);% tilde{xi}^2
            
            Ld = -1i*kron( Hext, Id) +1i* kron( Id, Hext.');
            Lpump= gammat*xit2*( kron( Jp, (Jp').') - 0.5*kron( Jp'*Jp, Id) - 0.5*kron( Id, (Jp'*Jp).') ); 
            Ltot = Ld + Lpump; 
            
        otherwise
            error('The Louvillian for Dicke model under his type of pulse has not been defined!');
            
    end
            
  end