%% Model Hamiltonian
% The model Hamiltonian for the normal phase is given by
%                                     Hnp=  a^{dagger}a-g^2 (a+a^{dagger})^2/4 + g^4 (a+a^{dagger})^2 /16Omega
% The model Hamiltonian for the superradiant phase is given by
%                                     Hsp=  a^{dagger}a - (a+a^{dagger})^2/4g^2 + (a+a^{dagger})^2 /16 g^4 Omega
% Here, the frequency of the field omega_0 is set to be the unit. And the
% energy splitting of the atom Omega=1000 omega_0. The critical coupling
% strength for the quantum phase transition is g_c =1.  As the energy
% splitting of the atom is much larger than omega_0. We assume the finite
% temperature will not change the thermal dynamics of the atom. Here, we
% want to see that is there any thermodynamic phase transiton happens for
% the field.

clear;clc;
g=1.5;
Omega=100;
dimf=2*Omega;
a=destroy(dimf);

Hnp = a'*a - g^2 * (a+a')^2/4 + g^4 * (a+a')^4/16/Omega;
Hsp = a'*a -  (a+a')^2/4/g^2 + (a+a')^4/16/g^4 /Omega;

betalist=[0.0001:0.0005:0.0096,0.01:0.005:0.095,0.1:0.1:0.9, 1:10];
nsteps=length(betalist);
PNnp=zeros(1,nsteps);
PNsp=zeros(1,nsteps);
%% construct Hamiltonian 

[Vnp,Dnp]=eig(full(Hnp(:,:)));
dnp=diag(Dnp);

[Vsp,Dsp]=eig(full(Hsp(:,:)));
dsp=diag(Dsp);
%%

for j=1:nsteps
%     tic
    beta=betalist(j);
    disp(['Running the ' num2str(j) 'th loop with beta=' num2str(beta) '...']);
    
    Znp=sum(exp(-beta.*dnp));
    rhonp=Vnp*diag(exp(-beta.*dnp))*Vnp'/Znp;
    nnp = trace(rhonp*Hnp(:,:))/Omega;
    PNnp(1,j) = nnp;
    
    
    Zsp=sum(exp(-beta.*dsp));
    rhosp=Vsp*diag(exp(-beta.*dsp))*Vsp'/Zsp;
    nsp = trace(rhosp*Hsp(:,:))/Omega;
    PNsp(1,j) = nsp;
end
fname=['../output/PotonNumberVsBeta_dimf' num2str(dimf) '_g' num2str(g) '.mat'];
save(fname,'betalist','PNnp','PNsp');


