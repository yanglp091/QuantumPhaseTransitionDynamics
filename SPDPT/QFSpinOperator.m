function QF=QFSpinOperator(dimf,na,theta,phi,option)
%This function construct the operator  for calcualting the spin Q-function
% QF =(N+1)/4/pi  |theta,phi><theta,phi|
     coh_st=Spin_cohstate_construct(na,theta, phi);
     QF = sparse( (na+1)/4/pi*coh_st*coh_st' ); % operator of the Q-function
     
    switch option
        case 'nocoupling'
            QF=1*QF;
        case 'distinguish'
             error('Spin (atomic) coherent state can not be defined for distinguishable spins or atoms!');
        case 'indistinguish'
             idf = speye(dimf);
             QF =  kron(idf,QF);
        case 'twospin'
           QF = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');
    end


end