function hf=Hdestroy(dimf, na, g, option)
    if nargin < 2
      option = 'nocoupling'; 
      na = 0;
    end
    
    if (na~=fix(na))|| na < 0
       error('atom number must be a non-negative integer!'); 
    end
    
    
   hf  = g*destroy(dimf);
    
    switch option
        case 'nocoupling'
            hf=1*hf;
        case 'distinguish'
             ida = identity(2);
            for j=1:na
                hf=tensor(hf,ida);
            end
        case 'indistinguish'
             ida = identity(na+1);
             hf =  tensor(hf, ida);
        case 'twospin'
           hf = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');
    end
    

end