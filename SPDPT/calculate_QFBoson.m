function qfs = calculate_QFBoson(alphalist,vec,para)
% This function is used to calculate the bosonic Q-function for a given
% state. Here, alpha is assumed to be real, as only the xz-cross section is 
% of interest


    nalpha=length(alphalist);
    qfs = zeros(nalpha,1);
    for k=1:nalpha
            alpha=alphalist(k);
            qfo=QFBosonOperator(para.dimf,para.natom,alpha,para.option);%Q-function operator
            
            qfs(k,1)=vec'*qfo*vec;
    end

end