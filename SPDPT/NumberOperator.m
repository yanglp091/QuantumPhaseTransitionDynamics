function h_num=NumberOperator(dimf, na, option)
    if (na~=fix(na))|| na <1
       error('atom number must be a positive integer!'); 
    end
    
    idf = identity(dimf);    
    switch option
        case 'distinguish'    
            hf=Hf_construct(dimf, na,option);
            ha=0;
                for j=1:na
                            haj=idf;
                            for k=1:na
                                ida = identity(2);
                                if k == j
                                   ida=(sigmaz+identity(2))/2; 
                                end
                                haj=tensor(haj,ida);
                            end
                    ha=ha+haj;
                end
             h_num=hf+ha;
             
        case 'indistinguish'
            ida = identity(na+1);
            a = destroy(dimf);
            hf =  tensor(a'*a, ida);
            Np=jmat(na/2,'z')+(na/2)*identity(na+1);
            ha = tensor(idf, Np);
            h_num=hf+ha;
            
        case 'twospin'
            ida = identity(na);
            n1 = jmat((dimf-1)/2,'z')+(dimf-1)*identity(dimf)/2;
            n2 = jmat( (na-1)/2,'z')+(na-1)*identity(na)/2;
            
            h_num.ExcitationNumber1=tensor(n1, ida);
            h_num.ExcitationNumber2=tensor(idf, n2);
            h_num.ExcitationNumber=tensor(n1, ida)+tensor(idf, n2);                       
        otherwise 
          error('This type of operator has not been defined.');  
    end
    
end