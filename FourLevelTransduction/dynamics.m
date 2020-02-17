clear;clc;
%% Construct IsingXY model Hamiltonian
dimcs =4;  para.dimcs =4;
ex_para.echo_opt = 0;

% parameters of the incident pulse
pulsetype = 'FockState'; % 'FockState', 'CoherentState'
para.pulsetype =pulsetype;
pulseshape = 'Gaussian'; % 'Gaussian', 'DecayingExp', 'RisingExp'
para.pulseshape =pulseshape;
tauf=1; para.tauf = tauf; % length of the pulse
nphoton = 1; para.nphoton = nphoton;


%add Rabi oscillation betwee two excited states
% evolution_para.Omega=2;

 
%construct time-dependent parameters
tlist=[-5:0.1:5,5.2:0.2:10];  ntime = length(tlist);
% tlist= 0:0.01:0.1*pi;  ntime = length(tlist);
para.timelist=tlist;
xi_list = PulseAmplitude(tlist, tauf, pulseshape );  
evolution_para.xi_list = xi_list';

%% 
% evolution_para.eta = [1,0];
% evolution_para.gamma_LSD = [10,10];
% [Pet, Pft]=CalculatePet(para,evolution_para,dimcs);% generates pulse amplitude list
% 
% 
% plot(tlist, Pet,'-*',tlist, Pft,'-o')




%% trade-off between two decay rates
% if 0
% gammalist = 1;
% Gammalist = 1;

gammalist = [1e-3:1e-3:9e-3,1e-2:1e-2:9e-2,1e-1:0.05:1,1.2:0.2:3,3.4:0.4:10,10:1:20];
Omegalist = [1e-3:1e-3:9e-3,1e-2:1e-2:9e-2,1e-1:0.05:1,1.2:0.2:3,3.4:0.4:9,10:10:100];

ng = length(gammalist);
nG = length(Omegalist);

Pemat = zeros(ng,nG);
for j = 1: ng
    gamma = gammalist(j);
    Gamma = gamma;
    evolution_para.gamma_LSD = [gamma,Gamma];
    
    disp(['Running the j=' num2str(j) 'th loop of the total ' num2str(ng) 'loops...']);
    tic
    for k = 1:nG               
        
        Omega = Omegalist(k);
        %add Rabi oscillation betwee two excited states
        evolution_para.Omega=Omega;

        [Pet,~]=CalculatePet(para,evolution_para,dimcs);% generates pulse amplitude list
        Pemat(j,k) = max(Pet);
    end
    toc
end

fname=['./Data_dynamics_dimcs' num2str(dimcs) '_tauf' num2str(tauf) ...
    '_nphoton' num2str(nphoton) '.mat'];%'_Omega' num2str(para.Omega) 
save('-v7.3',fname,'para','gammalist','Omegalist','Pemat')
% end