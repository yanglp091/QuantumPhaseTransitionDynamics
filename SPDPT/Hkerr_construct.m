function hk = Hkerr_construct(dimf, kerr, na, option)
    if nargin < 3
      option = 'nocoupling'; 
      na = 0;
    end
    
    if (na~=fix(na))|| na < 0
       error('atom number must be a non-negative integer!'); 
    end
    
    a = destroy(dimf);
    hk = kerr*a'* a'* a * a;    
    
    switch option 
        case 'nocoupling'
            hk=1*hk;
        case 'distinguish'
            ida = identity(2);
            for j=1:na
                hk=tensor(hk,ida);
            end
        case 'indistinguish'
             ida = identity(na+1);
             hk =  tensor(hk, ida);
        case 'twospin'
           hk = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');          
     end
    
end