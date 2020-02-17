function ha=Hsy(dimf, na, epsilon, option)
% The Hamilotonian of
%       H=\sum_{j} (epsilon/2) sigma_j^y 

    if (na~=fix(na))|| na <1
       error('atom number must be a positive integer!'); 
    end

    idf = identity(dimf);    
 
    switch option      
        case 'distinguish'
               ha=0;
               for j=1:na
                        haj=idf;
                        for k=1:na
                            ida = identity(2);
                            if k == j
                               ida=0.5*epsilon*sigmay; 
                            end
                            haj=tensor(haj,ida);
                        end
                        ha=ha+haj;
                end
        case 'indistinguish'
            Jz = epsilon*jmat(na/2,'y');
            ha = tensor(idf, Jz);
        case 'twospin'
           ha = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');          
     end
    
    
end