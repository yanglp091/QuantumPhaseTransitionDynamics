function hqd=Hf_quadrature(dimf, na, option)
    if nargin < 2
      option = 'nocoupling'; 
      na = 0;
    end
    
    if (na~=fix(na))|| na < 0
       error('atom number must be a non-negative integer!'); 
    end
    
    
    a = destroy(dimf);
    X = (a+a')/sqrt(2);  
    P = 1i*(a-a')/sqrt(2);
    switch option
        case 'nocoupling'
            X=1*X;
            P=1*P;
        case 'distinguish'
             ida = identity(2);
            for j=1:na
                X=tensor(X,ida);
                P=tensor(P,ida);
            end
        case 'indistinguish'
             ida = identity(na+1);
             X =  tensor(X, ida);
             P =  tensor(P, ida);
        case 'twospin'
           X = 0;
           P=0;
        otherwise
            error('This type of Hamitlonian has not been defined!');
    end
    hqd.X=X(:,:);
    hqd.P=P(:,:);

end