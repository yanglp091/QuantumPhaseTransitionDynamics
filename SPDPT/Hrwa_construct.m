function hrwa=Hrwa_construct(dimf, na, lambda, option)
    if (na~=fix(na))|| na <1
       error('atom number must be a positive integer!'); 
    end

    a = destroy(dimf);    
     switch option      
        case 'distinguish'
                ha=0;
                for j=1:na
                        haj=a;
                        for k=1:na
                            ida = identity(2);
                            if k == j
                               ida=( lambda/sqrt(na) )*sigmap;% Dicke model: sqrt(na) 
                            end
                            haj=tensor(haj,ida);
                        end
                        ha=ha+haj;
                end
                hrwa=ha+ha';
         case 'indistinguish'
                 Jp = lambda*jmat(na/2,'+')/sqrt(na);
                 hrwa = tensor(a, Jp) + tensor(a, Jp)';     
         case 'twospin'
                  hrwa = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');     
     end
    
end