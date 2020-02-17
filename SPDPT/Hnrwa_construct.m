function hnrwa=Hnrwa_construct(dimf, na, lambda, option)
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
                           ida=lambda*sigmam/sqrt(na); 
                        end
                        haj=tensor(haj,ida);
                    end
                    ha=ha+haj;
                end
                hnrwa=ha+ha';
        case 'indistinguish'
                 Jp = lambda*jmat(na/2,'+')/sqrt(na);
                hnrwa = tensor(a', Jp) + tensor(a', Jp)';
        case 'twospin'
                  hnrwa = 0;
       otherwise
                error('This type of Hamitlonian has not been defined!');    
    end
end