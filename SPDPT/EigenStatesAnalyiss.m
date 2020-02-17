%% para meter setting
if 0
dimf = 200;%dimension cutoff the field
natom =  20;% number of atoms
nrwa = 0;% RWA options
epsilon = 1; lambda = 2;

%% diagonalization
beta=1;%inverse temperature
para=setpara(epsilon,lambda,beta,natom,dimf,nrwa);
% [H,H_list]=HConstruct(para);
[H,H_list]=HLargeSpinModel(para);

[V,D]=eig(full(H(:,:)));
EEV=diag(D);%eigen energy values
numop=NumberOperator(dimf, natom,'indistinguish');%excitation operator
ExNumlist=diag(V'*numop(:,:)*V);%excitation number list

%% Eigen states Vs excitation number
data=[ExNumlist,EEV];
data=sortrows(data);
data=data';

plot(data(1,:),data(2,:),'o')
% set(gca,'xscale','log');

%%
fname=['../output/EigenSystem_natom' num2str(natom) '_dimf' num2str(dimf) ...
     '_epsilon' num2str(epsilon) '_lambda' num2str(lambda) '_rwa.mat'];
if nrwa>0
    fname=['../output/EigenSystem_natom' num2str(natom) '_dimf' num2str(dimf) ...
     '_epsilon' num2str(epsilon) '_lambda' num2str(lambda) '_nrwa.mat'];
end

save('-v7.3',fname);
end

