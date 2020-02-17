function hising=HIsing(dimf, na, Jx,Jy, Jz, option)
    if (na~=fix(na))|| na <2
       error('atom number must be a positive integer greater than 1!'); 
    end
  
     switch option      
        case 'distinguish'
            % Hamiltonian for Ising model: \sum_j sigma_j^y * sigma_{j+1}^y
                hising=0;
                for j=1:na-1
                        hxxj=identity(dimf);hyyj=identity(dimf);hzzj=identity(dimf);
                        for k=1:na
                            sigmakxx = identity(2);sigmakyy = identity(2);sigmakzz = identity(2);
                            if k == j || k== (j+1)
                               sigmakxx= sigmax;sigmakyy= sigmay;sigmakzz= sigmaz; 
                            end
                            hxxj=tensor(hxxj,sigmakxx);hyyj=tensor(hyyj,sigmakyy);hzzj=tensor(hzzj,sigmakzz);
                        end                       
                        hising=hising+Jx*hxxj+Jy*hyyj+Jz*hzzj;
                end
                % The last term in Ising model
                    hxxj=tensor(identity(dimf), sigmax);
                    hyyj=tensor(identity(dimf), sigmay);
                    hzzj=tensor(identity(dimf), sigmaz);
                    for k= 2:na-1
                        sigmak = identity(2);
                        hxxj=tensor(hxxj,sigmak);
                        hyyj=tensor(hyyj,sigmak);
                        hzzj=tensor(hzzj,sigmak);
                    end
                    
                    hxxj=tensor(hxxj,sigmax);
                    hyyj=tensor(hyyj,sigmay);
                    hzzj=tensor(hzzj,sigmaz);
                hising=hising + Jx*hxxj + Jy*hyyj+ Jz*hzzj;
                                
         case 'indistinguish'
                 Jxx = jmat(na/2,'x')*jmat(na/2,'x');
                 Jyy = jmat(na/2,'y')*jmat(na/2,'y');
                 Jzz = jmat(na/2,'z')*jmat(na/2,'z');
                 hxx = tensor(identity(dimf), Jxx);
                 hyy = tensor(identity(dimf), Jyy);
                 hzz = tensor(identity(dimf), Jzz);
                 hising = 0.5*Jx* (4* hxx(:,:) - na*speye( dimf*(na+1) ) )/na...
                     +0.5*Jy* (4* hyy(:,:) - na*speye( dimf*(na+1) ) )/na...
                     +0.5*Jz*(4* hzz(:,:) - na*speye( dimf*(na+1) ) )/na;
         case 'twospin'
                  hising = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');     
     end
    
    
end