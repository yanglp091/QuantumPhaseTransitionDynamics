function QF=QFBosonOperator(dimf,na,alpha,option)
%This function construct the operator  for calcualting the Q-function
% QF =(1/pi) |alpha><alpha|
     coh_st=cohstate_construct(dimf,alpha);
     QF = sparse( (1/pi)*coh_st*coh_st' ); % operator of the Q-function
     
    switch option
        case 'nocoupling'
            QF=1*QF;
        case 'distinguish'
             ida = speye(2);
            for j=1:na
                QF=kron(QF,ida);
            end
        case 'indistinguish'
             ida = speye(na+1);
             QF =  kron(QF, ida);
        case 'twospin'
           QF = 0;
        otherwise
            error('This type of Hamitlonian has not been defined!');
    end


end