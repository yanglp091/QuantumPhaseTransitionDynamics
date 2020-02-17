function  rho0 = rho_construct(para)
         %this function is to construct the thermal state density matrix
        beta =para.beta;
        [HD,~] = HDicke(para);   
        [V,D]=eig(full(HD(:,:)));
        dd=diag(D);%eigen energy values
        dmin=min(dd);
        dd=dd-dmin;
        Z=sum(exp(-beta.*dd));
        rho0=V*diag(exp(-beta.*dd))*V'/Z;
end