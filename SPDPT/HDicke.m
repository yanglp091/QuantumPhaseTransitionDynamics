function [H,H_list] = HDicke(para)

    dimf = para.dimf;    
    na = para.natom;
    
    
    kerr=0; 
    if isfield(para,'kerr')
    kerr = para.kerr;
    end
    
    shg=0; 
    if isfield(para,'shg')
    shg = para.shg;
    end
    
    %Setting parameters of the Ising Chain
    Jx=0;Jy=0;Jz=0; 
    if isfield(para,'J')
        Jx=para.J(1);Jy=para.J(2);Jz=para.J(3);
    end
    J=[Jx,Jy,Jz];
    
    
    %Setting parameters of the Dicke model
    epsilon = para.epsilon;
        
    lambda = para.lambda;
    op_rwa = para.RWA;
    option = para.option;
    
    hf = Hf_construct(dimf, na, option);
    
    % Adding kerr terms
    hkerr=0;
    if abs(kerr)>0
        hkerr = Hkerr_construct(dimf, kerr, na, option);
    end
   
    %Adding second-harmonic generation term 
    hshg=0;
    if abs(hshg)>0
        hshg = Hshg_construct(dimf, shg, na, option);
    end
    
    % Adding Hamiltonian of the atoms
    hsz = Hsz(dimf, na, epsilon, option);
    if isfield(para,'epsilonx')
        epsilonx= para.epsilonx;
        hsx = Hsx(dimf, na, epsilonx, option);
    else
        hsx = 0;
    end
    if isfield(para,'epsilony')
        epsilony= para.epsilony;
        hsy = Hsy(dimf, na, epsilony, option);
    else
        hsy=0;
    end
    hrwa = Hrwa_construct(dimf, na, lambda, option);
   
    % Adding non-RWA terms
    hnrwa=0;
    if op_rwa==0
        hnrwa = Hnrwa_construct(dimf, na, lambda, option);
    end
    
    % Adding Ising chain
    hising=0;
    if  sum( abs(J) )>0
        hising = HIsing(dimf, na, Jx, Jy, Jz, option);
    end
    
    H = hf(:,:) + hkerr(:,:) +hshg(:,:) + hsz(:,:)+ hsx(:,:)+ hsy(:,:)...
        + hrwa(:,:) + hnrwa(:,:) + hising(:,:);
    
    H_list.hf=hf;
    H_list.hkerr=hkerr;
    H_list.hshg=hshg;
    H_list.ha=hsz;
    H_list.hrwa=hrwa;
    H_list.hnrwa=hnrwa;
    H_list.hising=hising;
    
end