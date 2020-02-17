function rfmat = Fidelity2RF(Fmat,para)
% this function is used to calculate rate function from fidelity
%                 lambda(t)= -lim_{N-->Inf} (1/N) log F(t)
% where F(t) is the fidelity (Loschmidt echo) given by
%                L(t) = |<psi(0)|psi(t)>|^2

[nr, nc]=size(Fmat);
rfmat=zeros(nr,nc);

for j= 1:nr
    for k=1:nc
        F=Fmat(j,k);
        rfmat(j,k)= -(2/para.natom)*log(F);
    end
end

end