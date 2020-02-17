clear;clc;
%% Construct DickeIsing model Hamiltonian

% setting the system parameters
natom  = 10; ex_para.natom = natom;% number of atoms
% ex_para.dimf = 1;% dimension of the external degree
dimcs = 3; ex_para.dimcs = dimcs;% dimmension of the center spin
ex_para.echo_opt = 0;


hami_para.Model = 'CSDickeSpin';
hami_para.option = 'indistinguish';
hami_para.epsilon =[0,0,1];% external magnetic field
% hami_para.omega0 = 1;
% hami_para.lambda = 1;

hami_para.g = 0.01; % center-Dicke coupling strength
% hami_para.Delta = -0.1;



% parameters of the incident pulse
pulsetype = 'FockState'; % 'FockState', 'CoherentState'
para.pulsetype =pulsetype;
pulseshape = 'Gaussian'; % 'Gaussian', 'DecayingExp', 'RisingExp'
para.pulseshape =pulseshape;
tauf=1; para.tauf = tauf; % length of the pulse
nphoton = 1; para.nphoton = nphoton;

% evolution parameters
tstep = 0.1;
tlist=[-3:tstep:3, 3.2:0.2:5, 5.5:0.5:50];  ntime = length(tlist);
para.timelist=tlist;
evolution_para.DynamicsMode = 'CSDickeSpin';
evolution_para.gamma_LSD =[10,10];
xi_list = PulseAmplitude(tlist, tauf, pulseshape );  
evolution_para.xi_list = xi_list';
evolution_para.eta = [1,0]; % only pumping |g> <==> |f> transition


Jxlist =0.69; 
% Jxlist =[0.4:0.01:0.65,0.65:0.005:0.69,0.692:0.002:0.702, 0.705:0.005:0.75,0.76:0.01:0.9]; 
Jy=0.7; Jz =0; % spin-spin coupling strength
nstep =length(Jxlist);
Datacell = cell(1,nstep);
 for j =1: nstep
    tic
    disp(['Runing the ' num2str(j) 'th loop of ' num2str(nstep) ' loops.... ']);
    Jx  = Jxlist(j);

    hami_para.J = - [Jx, Jy, Jz ];

    para = setpara(hami_para,ex_para, para);

    % Hamiltonian of Dicke-Spin part 
    hds = HDickeSpin(para);
    GS =ground_state_construct(hds); % zeros(16,1); psi0(16) =1;
    rho_ds = sparse(GS*GS'); % initial state of the Dicke-Spin part
    rho_cs = sparse([0,0;0,1]);% initial state of the center spin
    rho0 = kron(rho_cs,rho_ds);

    obs = pre_obs_liouville(para);    
    Datacell{j}=evolve_liouville(para,rho0, obs,evolution_para);
    toc
 end
% Sx=extractdata(Datacell{1,1},'Sx2');
% plot(tlist,Sx)
 
% fname=['./Data_dynamics_natom' num2str(natom) '_Jy' num2str(Jy) '.mat'];
% save('-v7.3',fname,'Datacell','para','evolution_para','Jxlist','tlist');


output=Datacell{1};
Pe = extractdata(output,'Pe');
plot(tlist,real(Pe),'-*')
% end