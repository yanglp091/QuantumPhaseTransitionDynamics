% if 0
% nl=length(lambdalist);
nl = length(Deltalist);
nt=length(tlist);
Sx2mat = zeros(nl,nt);
Sx2mat_RN = zeros(nl,nt);
Sy2mat = zeros(nl,nt);
Sy2mat_RN = zeros(nl,nt);
Pemat = zeros(nl,nt);
for j= 1:nl
   PN = extractdata(Datacell{1,j},'Pe');  
   Pemat(j,:) = PN;   
   
   Sx2=extractdata(Datacell{1,j},'Sx2');
   Sx2mat(j,:) = Sx2;
   Sx2mat_RN(j,:) = Sx2/Sx2(1);
   
   Sy2=extractdata(Datacell{1,j},'Sy2');
   Sy2mat(j,:) = Sy2;
   Sy2mat_RN(j,:) = Sy2/Sy2(1);
%    Fmat(j,:) = extractdata(Datacell{j,1},'Fidelity');
end
% end

% figure(1); mesh(tlist,lambdalist,real(Sx2mat_RN))
% figure(2); mesh(tlist,lambdalist,real(Sy2mat_RN))
% figure(3); mesh(tlist,lambdalist,real(Pemat))

figure(1); mesh(tlist,Deltalist,real(Sx2mat_RN))
figure(2); mesh(tlist,Deltalist,real(Sy2mat_RN))
figure(3); mesh(tlist,Deltalist,real(Pemat))


% val=max(PNmat_RN);val1=max(val);[row,col]=find(PNmat_RN==val1)
% RNPN_la4=real( PNmat_RN(:,col) );RNPN_t4=real( PNmat_RN(row,:) );
% PN_la4=real( PNmat_RN(:,col) );PN_t4=real( PNmat_RN(row,:) );
% la_list4=lambda0list;time4=tlist;J04=J0;
% clearvars -except RNPN* PN_la* PN_t* la_list* time* J0*