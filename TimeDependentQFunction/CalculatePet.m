function [Pet,Pft] = CalculatePet(para,evolution_para,dimcs)
    %this function is used to calculate the excitation probability of a single
    %two-level atom

    if nargin < 3
        dimcs = 2; 
    end

    if dimcs ==2
        ntime = length(para.timelist);
        para.Model = 'TwoLevelAtom';
        rho0 = sparse([0, 0; 0, 1]);
        evolution_para.DynamicsMode = 'TwoLevelAtom';
        omegax_list = zeros(ntime,1);  evolution_para.omegax_list=omegax_list;
        omegay_list = zeros(ntime,1);  evolution_para.omegay_list=omegay_list;
        omegaz_list = zeros(ntime,1);  evolution_para.omegaz_list=omegaz_list;
    else
        para.Model = 'ThreeLevelAtom';
        rho0 = sparse([0,0, 0; 0,0, 0; 0, 0, 1]);
        evolution_para.DynamicsMode = 'ThreeLevelAtom';
    end
    
   % evolution parameters

    obs = pre_obs_liouville(para);
    output=evolve_liouville(para,rho0, obs,evolution_para);
    Pet = extractdata(output,'Pe');
    Pft = extractdata(output,'Pf');
    
end