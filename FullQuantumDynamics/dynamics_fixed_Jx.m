clear;clc;
%% Construct DickeIsing model Hamiltonian
natom  = 100; ex_para.natom = natom;% number of atoms
% ex_para.dimf = 1;% dimension of the external degree
dimcs = 3; ex_para.dimcs = dimcs;% dimmension of the center spin
ex_para.echo_opt = 1;


hami_para.Model = 'CSDickeSpin';
hami_para.option = 'indistinguish';
hami_para.epsilon =[0,0,1];% external magnetic field
% hami_para.omega0 = 1;
% hami_para.lambda = 1;
hami_para.g = 0.01; % center-Dicke coupling strength

Jx =0.69;  Jy=0.7; Jz =0; % spin-spin coupling strength
hami_para.J = - [Jx, Jy, Jz ];


% parameters of the incident pulse
pulsetype = 'FockState'; % 'FockState', 'CoherentState'
para.pulsetype =pulsetype;
pulseshape = 'Gaussian'; % 'Gaussian', 'DecayingExp', 'RisingExp'
para.pulseshape =pulseshape;
tauf=5; para.tauf = tauf; % length of the pulse
nphoton = 1; para.nphoton = nphoton;

para = setpara(hami_para,ex_para, para);

% Hamiltonian of Dicke-Spin part 
hds = HDickeSpin(para);
GS =ground_state_construct(hds); % zeros(16,1); psi0(16) =1;
rho_ds = sparse(GS*GS'); % initial state of the Dicke-Spin part
rho_cs = sparse([0,0,0;0,0,0; 0,0,1]);% initial state of the center spin
rho0 = kron(rho_cs,rho_ds);

% evolution parameters
tstep = 0.1;
% tlist=[-5:0.1:2,2.5:0.2:5,5.5:0.5:50];  
tlist=[-20:0.1:20,20.5:0.5:100]; 
 ntime = length(tlist);
para.timelist=tlist;
evolution_para.DynamicsMode = 'CSDickeSpin';
evolution_para.gamma_LSD = [10,10];
xi_list = PulseAmplitude(tlist, tauf, pulseshape );  
evolution_para.xi_list = xi_list';
evolution_para.eta = [1,0]; % only pumping |g> <==> |f> transition

obs = pre_obs_liouville(para);
output=evolve_liouville(para,rho0, obs,evolution_para);


Pe = extractdata(output,'Pe');
figure(1); plot(tlist,real(Pe),'-*')

Pf = extractdata(output,'Pf');
figure(2); plot(tlist,real(Pf),'-*')

X=extractdata(output,'Sx2');
figure(3); plot(tlist,real(X)/real(X(1)))
 
fname=['./Data_dynamics_natom' num2str(natom) '_dimcs' num2str(dimcs)...
    '_Jx' num2str(Jx) '_Jy' num2str(Jy) '_tauf' num2str(tauf) '.mat'];
save('-v7.3',fname,'output','para','evolution_para','tlist');
