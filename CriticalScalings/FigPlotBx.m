%% Correlations
if 0
Bx=Bx_list;
Cxy=extractdata(Datacell,'Cxy');
Cyx=extractdata(Datacell,'Cyx');
Sx=extractdata(Datacell,'Sx');
Sy=extractdata(Datacell,'Sy');
Sx=Sx*para.natom;
Sy=Sy*para.natom;
Fxy = 0.5*(Cxy + Cyx) - Sx.*Sy;

figure(1)
plot(Bx,real(Fxy),'b*',Bx,imag(Fxy),'ro')



Cxxyy=extractdata(Datacell,'Cxxyy');
Cyyxx=extractdata(Datacell,'Cyyxx');
Sx2=extractdata(Datacell,'Sx2');
Sy2=extractdata(Datacell,'Sy2');
Sx2=Sx2*(para.natom)^2;
Sy2=Sy2*(para.natom)^2;
Fxxyy = 0.5*(Cxxyy + Cyyxx) - Sx2.*Sy2;

figure(2)
% plot(Bx,real(Fxxyy),'b*',Bx,imag(Fxxyy),'ro')
plot(abs(Bx),abs(Fxxyy),'b*')
set(gca,'XScale','log','YScale','log')


end



%% Phase transition
% if 0
gamma=1.525;chiB_an=chiB(39)*(2e-5)^(gamma)./(Bxc(38:end)).^(gamma);
nuz=1/2;Gap_an=Gap(48)*(1e-4)^(-nuz)./(abs(Bx)).^(-nuz);
nu=0.919;Fxxyy_an=Fxxyy(48)*(1e-4)^(nu)./(abs(Bx)).^(nu);


    
fz=48;
lw=4;

subplot('position',[0.1,0.55,0.35,0.35]),
line(abs(Bxc),real(chiB),'LineStyle','non','Marker','o',...
    'MarkerSize',15,'MarkerFaceColor',[0.3,0.5,1],'MarkerEdgeColor','non');
line(Bxc(38:end),real(chiB_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);

xlim([1e-5,3e-2]);  ylim([2e2,1e8]);
set(gca,'XScale','log','YScale','log','TickLength',[0.03,0.03],...
    'box','on','FontSize',fz,'LineWidth',2)
set(gca,'xtick',[1e-5, 1e-4,1e-3,1e-2],'ytick',[1e3,1e4,1e5,1e6,1e7],'YMinorTick','on');

hax1 = axes('Position', [0.255, 0.76, 0.16, 0.11]);
line(Bx,zetax,'LineStyle','-','Color',[1,0.2,0.4],'LineWidth',lw);
line(Bx,zetay,'LineStyle',':','Color',[0,0.447,0.0],'LineWidth',lw);
set(hax1,'xlim',[-1e-3,1e-3],'ylim',[0,0.13],'box','on');
set(hax1,'XTick',[-1e-3,0,1e-3],'XTickLabel',{'-10^{-3}','0','10^{-3}'});
set(hax1,'FontSize',0.9*fz,'TickLength',[0.02,0.02],'LineWidth',1.5);%'XTick',0:25:50,'YTick',[]


subplot('position',[0.57,0.55,0.35,0.35]),
line(N,abs(chimax),'LineStyle','-','color',[0 0 0],'LineWidth',lw,...
    'Marker','o','MarkerSize',15,'MarkerFaceColor',[0.3,0.5,1],'MarkerEdgeColor',[0.3,0.5,1]);
xlim([0,1.1e4]);  ylim([1e7,3.44e8]);
set(gca,'XTick',2e3:4e3:1e4,'YTick',1e8:1e8:4e8,...
    'TickLength',[0.03,0.03],'XMinorTick','off');%'XTickLabel',2:2:10,
set(gca,'FontSize',fz,'LineWidth',2,'box','on');%'xtick',[1e-5,1e-4,1e-3,1e-2],'ytick',[1e-1,1,1e1,1e2,1e3,1e4],

% hax1 = axes('Position', [0.76, 0.66, 0.13, 0.11]);
% line(abs(Bxc),abs(Slope),'LineStyle','non','Color',[1,0.2,0.4], 'Marker','*','MarkerSize',15);%'LineWidth',lw
% set(hax1,'XScale','log','YScale','log','box','on');
% set(hax1,'xlim',[1e-5,1e-3],'ylim',[0,1e5],'box','on');
% set(hax1,'XTick',[1e-5,1e-4,1e-3],'YTick',[1e0,1e2,1e4],'XTickLabel',{'10^{-5}','10^{-4}','10^{-3}'});
% set(hax1,'FontSize',0.9*fz2,'TickLength',[0.03,0.03],'LineWidth',1.5);%'XTick',0:25:50,'YTick',[]



subplot('position',[0.1,0.07,0.35,0.35]),
line(Bx(37:end),Gap(37:end),'LineStyle','non','Marker','o','MarkerSize',15,...
        'MarkerFaceColor',[0.3,0.5,1]);
line(abs(Bx),Gap_an,'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
set(gca,'XScale','log','YScale','log','TickLength',[0.03,0.03],'box','on')
xlim([1e-5,3e-2]); ylim([1e-4,8e-1]);
set(gca,'xtick',[1e-5,1e-4,1e-3,1e-2],'ytick',[1e-3,1e-2,1e-1],...
    'YMinorTick','on','FontSize',fz,'LineWidth',2);
  
hax3 = axes('Position', [0.263, 0.165, 0.16, 0.11]);
line(Bx,Gap,'LineStyle','-','Color',[0.3,0.5,1],'LineWidth',lw);
set(hax3,'xlim',[-1e-2,1e-2],'ylim',[0,0.21],'box','on','LineWidth',1.5);
set(hax3,'FontSize',0.9*fz,'TickLength',[0.02,0.02]);%'XTick',0:25:50,'YTick',[]


subplot('position',[0.57,0.07,0.35,0.35]),
line(abs(Bx),abs(Fxxyy),'LineStyle','non','Marker','o','MarkerSize',15,...
    'MarkerFaceColor',[0.3,0.5,1]);
line(abs(Bx),abs(Fxxyy_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
set(gca,'XScale','log','YScale','log','TickLength',[0.03,0.03],'box','on','LineWidth',2)
xlim([1e-4,1e-1]); ylim([7e5,5e9]);
set(gca,'xtick',[1e-4,1e-3,1e-2,1e-1],'ytick',[1e6,1e7,1e8,1e9],'YMinorTick','on','FontSize',fz);
 
hax3 = axes('Position', [0.73, 0.26, 0.16, 0.11]);
line(Bx,Fxxyy,'LineStyle','-','Color',[0.3,0.5,1],'LineWidth',lw);
set(hax3,'xlim',[-1e-3,1e-3],'box','on','LineWidth',1.5);%,'ylim',[0,0.13]
set(hax3,'XTick',[-0.001,0,0.001],'XTickLabel',{'-10^{-3}','0','10^{-3}'},'FontSize',0.9*fz,'TickLength',[0.025,0.025]);


fname='./CriticalScalings_Bx.pdf';
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);

% end

