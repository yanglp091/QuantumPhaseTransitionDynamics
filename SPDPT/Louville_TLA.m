function Ltot = Louville_TLA(para,t)
            gamma=para.gamma;% effective coupling strength between the pusle and the atom
            tauf=para.tauf;% length of the Gaussian pulse
            xi_t = 1/(2*pi*tauf^2)^(1/4)*exp(-t^2/4/tauf^2);
            Jp=sqrt(gamma)*xi_t*jmat(1/2,'+'); 
            Jp=Jp(:,:);           

            taup= sparse([0,1;0,0]); Ip=speye(2);
            [dimd,~]=size(Jp); Id=speye(dimd);
            Lp = kron(kron(taup,Id), kron(Ip,Jp).') - kron(kron(taup,Jp), kron(Ip,Id).');
            Lm = kron(kron(taup,Jp'), kron(taup', Id).') - kron(kron(Ip,Id), kron(taup',Jp').');
            Ltot=Lp+Lm;
end