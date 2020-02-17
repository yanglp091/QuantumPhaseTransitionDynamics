function psi = ground_state_construct(para)

    [HD,~] = HDicke(para);   
    [V,D]=eig(full(HD(:,:)));
    EEV=diag(D);%eigen energy values
    Emin=min(EEV);
    idx=find(EEV==Emin);
    nEm=length(idx);
    psi =0;
    
    for j=1:nEm
       psij= V(:,idx(j));
       psi=psi+psij;
    end
    psi=psi/sqrt(nEm);
end