%% susceptibility of magnetic field
if 0

Bx=Bx_list;
Sx=extractdata(Datacell,'Sx');
Sx=Sx*para.natom;


dB=diff(Bx);
SxB=real(Sx');
dSx=diff(SxB);
chiB=abs(dSx./dB);
idx=abs(Bx)>0;
Bxc=Bx(idx);

% plot(abs(Bxc(1:37)),abs(chiB(1:37)),'b*',abs(Bxc(38:end)),abs(chiB(38:end)),'ro')
% set(gca,'XScale','log','YScale','log');
% xlim([0,1e-2])



end
%%
Slope=zeros(1,length(Bxc));
for j=1:length(Bxc)
    chi = ChiMat(:,j);
    F=fit(N',chi,'poly1');
    Slope(j) = F.p1;
end




%% fit of the susceptibility
%  x=log(abs(Bxc(39:56)));x=x';
%  y=log(chiB(39:56));y=y';
%  
% chiFit=fit(x,y,'poly1')
% results: gamma=1.525

%% fit of the correlation
% x=log(Bx(48:end));x=x';
% y=log(abs(Fxxyy(48:end)));
% 
% fit(x,y,'poly1')

% results: nu = 0.44

%% fit of the susceptibility of magnetic field

%  x=log(Bxc(1:19));x=x';
%  y=log(chiB(1:19));y=y';
%  
% fit(x,y,'poly1')
%results: gamma=-1.79