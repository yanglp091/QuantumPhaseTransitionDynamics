
clear;clc;
%% Construct IsingXY model Hamiltonian
natom  = 10000; ex_para.natom = natom;% number of atoms
dimf = 1;ex_para.dimf = dimf;% dimension of the external degree

% hami_para.epsilon =[0.1,0,1];% external magnetic field
hami_para.Model = 'LMG';
option = 'indistinguish'; hami_para.option =option;
ex_para.EvaluatingCorrelation=1;% switch on correlation calculation

Jx = 10; Jy=10; Jz=0;
Bx_list =[1e-5:1e-5:9e-5,1e-4:1e-4:9e-4,1e-3:1e-3:9e-3,0.01:0.01:0.1];
Bx_list = sort([-Bx_list,0,Bx_list]);
ndJ = length(Bx_list);
Datacell = cell(ndJ,1);
Delta_list = zeros(1,ndJ);


for j =1:ndJ
    tic
    disp(['Runing the j=' num2str(j) 'th loop of ' num2str(ndJ) ' loops.... ']);
    Bx = Bx_list(j);%dJ=Jx-Jy
    
    hami_para.epsilon =[Bx,0,1];% external magnetic field
    hami_para.J = - [Jx, Jy, Jz ];  
    para = setpara(hami_para,ex_para);
    H = HLMG(para);
    [psi0,EEV] = ground_state_construct(H);
    obs = pre_obs_LMG_hilbert(para);
    Datacell{j}=ObsMean(obs,psi0);
    Delta_list(j) = FindGap(EEV);
    toc
end

Sx2=extractdata(Datacell,'Sx2');
Sy2=extractdata(Datacell,'Sy2');
plot(Bx_list,Sx2,'-r', Bx_list,Sy2,'--b')

fname=['./Data_ObsVsBx_natom' num2str(natom) '_J0_' num2str(Jx) '_LMG.mat'];
save('-v7.3',fname,'Datacell','Delta_list','Bx_list','para');