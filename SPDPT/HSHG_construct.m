function hshg = HSHG_construct(dimf, shg, na, option)
    if nargin < 3
      option = 'nocoupling'; 
      na = 0;
    end
    
    if (na~=fix(na))|| na < 0
       error('atom number must be a non-negative integer!'); 
    end
    
    a = destroy(dimf);
    hshg = shg*a'* a'* a+shg*a' * a* a;    
    
    switch option 
        case 'nocoupling'
            hshg=1*hshg;
        case 'distinguish'
            ida = identity(2);
            for j=1:na
                hshg=tensor(hshg,ida);
            end
        case 'indistinguish'
             ida = identity(na+1);
             hshg =  tensor(hshg, ida);
        case 'twospin'
           hshg = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');          
     end
    
end