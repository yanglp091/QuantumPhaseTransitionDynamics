%%set parameters
if 0
clear;clc;
ex_para.dimf = 3;%dimension cutoff the field
ex_para.natom = 2;% number of atoms

hami_para.RWA = 1;% RWA options
hami_para.epsilon =1;
hami_para.lambda = 1;
hami_para.kerr = 1.;
hami_para.option = 'distinguish';
betalist=[0.0001:0.0005:0.0096,0.01:0.005:0.095,0.1:0.1:0.9, 1:9,10:10:100];
% betalist=90:110;





nsteps=length(betalist);
Datacell=cell(nsteps,1);

%%  Dicke model:     'distinguish'        'indistinguish' 


para = setpara(hami_para,ex_para);
[H,H_list]=HConstruct(para);

PN = H_list.hf;
Sz= H_list.ha/para.epsilon/para.natom;
Jpa=H_list.hrwa/para.lambda/2/para.natom;%real part of the coupling J_{+}a

[V,D]=eig(full(H(:,:)));
EEV=diag(D);%eigen energy values
numop=NumberOperator(para.dimf, para.natom,para.option);%excitation operator
ExNumlist=diag(V'*numop(:,:)*V);%excitation number list

obs.PhotonNumber=PN;
obs.Sz=Sz;
obs.Jpa=Jpa;

for j=1:nsteps
    tic
    beta=betalist(j);
    
    disp(['Running the ' num2str(j) 'th loop with beta=' num2str(beta) '...']);    
    Datacell{j,1}=ObsMean(EEV,V,beta,obs,para);
end

fname=['../output/ObsVsBeta_natom' num2str(para.natom) '_dimf' num2str(para.dimf) ...
     '_epsilon' num2str(para.epsilon) '_lambda' num2str(para.lambda) '_rwa.mat'];
if para.RWA == 0
    fname=['../output/ObsVsBeta_natom' num2str(para.natom) '_dimf' num2str(para.dimf) ...
     '_epsilon' num2str(para.epsilon) '_lambda' num2str(para.lambda) '_nrwa.mat'];
end
    
    
save('-v7.3',fname,'para','EEV','ExNumlist','betalist','Datacell');
end 


%%
if 0
%%set parameters
clear;clc;
ex_para.dim1 = 50;%dimension cutoff the field
ex_para.dim2 = 20;% number of atoms

hami_para.RWA = 1;% RWA options
hami_para.epsilon =200;
hami_para.lambda = 100;

hami_para.option = 'twospin';
 
betalist=[0.001:0.001:0.009,0.01:0.01:0.09,0.1:0.1:0.9,1:9,10:5:100];


nsteps=length(betalist);
Datacell=cell(nsteps,1);

%%  distinguishable atoms

para = setpara(hami_para,ex_para);
[H,H_list]=HConstruct(para);

ENO=NumberOperator(para.dim1, para.dim2,'twospin');%excitation Numer operator
NE1 = ENO.ExcitationNumber1;
NE2 = ENO.ExcitationNumber2;
TENO = ENO.ExcitationNumber;
Hrwa=H_list.hrwa/para.lambda/2/sqrt(para.dim2-1)/sqrt(para.dim1-1);%real part of the coupling J_{+}a

[V,D]=eig(full(H(:,:)));
EEV=diag(D);%eigen energy values

ExNumlist=diag(V'*TENO(:,:)*V);%excitation number list

obs.ExcitedNumber1=NE1;
obs.ExcitedNumber2=NE2;
obs.Hrwa=Hrwa;

for j=1:nsteps
    tic
    beta=betalist(j);
    disp(['Running the ' num2str(j) 'th loop with beta=' num2str(beta) '...']);    
    Datacell{j,1}=ObsMean(EEV,V,beta,obs,para);
    toc
end


en1=extractdata(Datacell,'ExcitedNumber1');
en2=extractdata(Datacell,'ExcitedNumber2');
figure(1);plot(betalist,en1,'-*');set(gca,'xscale','log')
figure(2);plot(betalist,en2,'-*');set(gca,'xscale','log')

fname=['./ObsVsBeta_dim1_' num2str(para.dim1) '_dim2_' num2str(para.dim2) ...
     '_epsilon' num2str(para.epsilon) '_lambda' num2str(para.lambda) '_rwa.mat'];
if para.RWA == 0
    fname=['./ObsVsBeta_dim1' num2str(para.dim1) '_dim2' num2str(para.dim2) ...
     '_epsilon' num2str(para.epsilon) '_lambda' num2str(para.lambda) '_nrwa.mat'];
end
    
    
save('-v7.3',fname,'para','EEV','ExNumlist','betalist','Datacell');

end
%% testing 

% % if 0
% tic
% Z = trace(expm(-beta*H));
% rho0 = expm(-beta*H)/Z;
% toc
% 
% tic
% np = trace(rho0*PN);
% jz = trace(rho0*Sz);
% jpa = trace(rho0*Jpa);
% toc
% 
% beta=1;%inverse temperature
% tic
% %diagonalization
% dmin=min(dd);dd=dd-dmin;
% Z1=sum(exp(-beta.*dd));
% rho01=V*diag(exp(-beta.*dd))*V'/Z1;
% toc
% 
% tic
% np1 = trace(rho01*PN(:,:));
% jz1 = trace(rho01*Sz(:,:));
% jpa1 = trace(rho01*Jpa(:,:));
% toc




% tic
% obs.PhotonNum=PN;
% obs.Sz=Sz;
% obs.Jpa=Jpa;
% 
% output=ObsMean(dd,V,beta,obs,para);
% 
% toc

% end

%% Kerr Effect
clc;clear;
dimf=100;
kerr = 10;
beta = 1;
H = Hf_construct(dimf) + Hkerr_construct(dimf, kerr);
PNO = Hf_construct(dimf);% photon number operator    

[V,D]=eig(full(H(:,:)));
EEV=diag(D);
ExNumlist = diag(V'*PNO(:,:)*V);
figure(1); plot(ExNumlist,EEV,'*')

b1=-3:0.1:3;
betalist=10.^(b1);

nsteps=length(betalist);
pns = zeros(1,nsteps);
for j = 1:nsteps
    beta = betalist(j);
    rho0 = rho_construct(EEV,V,beta);

    pnlist = diag(rho0*PNO(:,:));
    pns(1,j)=sum(pnlist);
end

figure(3); plot(betalist,pns,'-*');set(gca,'xscale','log')

