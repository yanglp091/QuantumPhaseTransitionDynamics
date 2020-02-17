function qfs = calculate_QFSpin(thetalist,philist,vec,para)
% This function is used to calculate the spin Q-function for a given
% state. Here, only specific phi is calculated, as only the xz/yz-cross section is 
% of interest
    ntheta=length(thetalist);
    nphi = length(philist);
    qfs = zeros(ntheta,nphi);
    for k=1:ntheta
            theta=thetalist(k);
            for j = 1:nphi
                phi = philist(j);
                qfo = QFSpinOperator(para.dimf,para.natom,theta,phi,para.option);                
                qfs(k,j)=vec'*qfo*vec;
            end
    end

end