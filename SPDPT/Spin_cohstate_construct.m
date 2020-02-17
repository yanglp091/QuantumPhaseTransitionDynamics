function psi = Spin_cohstate_construct(na,theta, phi)
    Jx=jmat(na/2,'x');
    Jy=jmat(na/2,'y');
    GS=zeros(na+1,1); GS(end)=1;
    psi = expm(-1i*theta*( sin(phi)*Jx(:,:) - cos(phi) * Jy(:,:) ) )*GS;
end