function  [Z,population] = PartitionFun(dd,beta)
         % this function is to calculate the partition function
         % and generate the population list
         % dd is the diagonal elements of the Hamiltonian
         % beta is the temperature
         
        dmin=min(dd);
        dd=dd-dmin;
        explist=exp(-beta.*dd);% exponential of the diagonal elements
        
        Z=sum(explist);
        
        population=explist/Z;
        
%         rho0=V*diag(exp(-beta.*dd))*V'/Z;
end