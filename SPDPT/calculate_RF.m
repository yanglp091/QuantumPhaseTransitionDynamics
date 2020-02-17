function rfs = calculate_RF(vec0,vec,para)
% this function is used to calculate rate function
%                 lambda(t)= -lim_{N-->Inf} (1/N) log L(t)
% where L(t) is the Loschmidt echo given by
%                L(t) = |<psi(0)|psi(t)>|^2

LA= abs(vec0'*vec);

rfs= -(2/para.natom)*log(LA);

end