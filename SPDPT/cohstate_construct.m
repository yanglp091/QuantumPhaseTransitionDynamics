function psi = cohstate_construct(dimf,alpha)
    idf=speye(dimf);
    psi=zeros(dimf,1);
    for j=0:dimf-1
        psi = psi+exp(-alpha*alpha'/2)*alpha^j/sqrt( factorial(j) )*idf(:,j+1);
    end
    NF=psi'*psi;
    psi = sqrt(1/NF)*psi;

end