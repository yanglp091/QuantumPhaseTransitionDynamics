if 0
Bx=Bx_list;
Cxy=extractdata(Datacell,'Cxy');
Cyx=extractdata(Datacell,'Cyx');
Sx=extractdata(Datacell,'Sx');
Sy=extractdata(Datacell,'Sy');
Sx=Sx*para.natom;
Sy=Sy*para.natom;
Fxy = 0.5*(Cxy + Cyx) - Sx.*Sy;

% figure(1)
% plot(Bx,real(Fxy),'b*',Bx,imag(Fxy),'ro')



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

%%  correlation functon for different spin number
if 0
fz1=48;fz2=36;
lw=4;
 
figure()
line(abs(Bx),abs(F1),'LineStyle','non','Marker','o','MarkerSize',15,...
    'MarkerFaceColor',[0.3,0.5,1]);
line(abs(Bx),abs(F2),'LineStyle','non','Marker','d','MarkerSize',15,...
    'MarkerFaceColor',[0.0,0.588,0.03],'MarkerEdgeColor',[0.0,0.588,0.03]);
line(abs(Bx),abs(F3),'LineStyle','non','Marker','>','MarkerSize',15,...
    'MarkerFaceColor',[0.8,0.8,0.0],'MarkerEdgeColor',[0.8,0.8,0.0]);
line(abs(Bx),abs(F4),'LineStyle','non','Marker','h','MarkerSize',15,...
    'MarkerFaceColor',[0.9,0.5,0],'MarkerEdgeColor',[0.9,0.5,0]);
line(abs(Bx),abs(F5),'LineStyle','non','Marker','<','MarkerSize',15,...
    'MarkerFaceColor',[0.9,0.0,0],'MarkerEdgeColor',[0.9,0.0,0]);

% line(dJ1,real(chi1_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
% line(dJ2,real(chi2_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
xlim([1e-5,1e-1]);         ylim([1e5,1e11]);
set(gca,'XScale','log','YScale','log','TickLength',[0.03,0.03],'box','on','FontSize',fz2,'LineWidth',2)
% set(gca,'xtick',[1e-5,1e-4,1e-3,1e-2],'ytick',[1e-1,1,1e1,1e2,1e3,1e4],...
%     'XTickLabel',{'-10^{-5}','-10^{-4}','-10^{-3}','-10^{-2}'},'FontSize',fz2,'LineWidth',2);%
h2=legend(' ',' ',' ', ' ',' ');%'N=5', ,' N=320'
set(h2,'position',[0.2,0.05,0.01,0.5]);%
set(h2,'box', 'off','FontSize',24);




fname='./CorrelationScaling_diff_N.pdf';
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);
end

%% normalized correlation functon for different spin number
% if 0
fz1=48;fz2=36;
lw=3;
 
figure()
line(Bx,abs(FN1),'LineStyle','-','color',[0.3,0.5,1],'LineWidth',lw,...
    'Marker','o','MarkerSize',15,'MarkerFaceColor',[0.3,0.5,1]);
line(Bx,abs(FN2),'LineStyle','-','color',[0.0,0.588,0.03],'LineWidth',lw,...
    'Marker','d','MarkerSize',15,'MarkerFaceColor',[0.0,0.588,0.03],'MarkerEdgeColor',[0.0,0.588,0.03]);
line(Bx,abs(FN3),'LineStyle','-','color',[0.8,0.8,0.0],'LineWidth',lw,'Marker','>','MarkerSize',15,...
    'MarkerFaceColor',[0.8,0.8,0.0],'MarkerEdgeColor',[0.8,0.8,0]);
line(Bx,abs(FN4),'LineStyle','-','color',[0.9,0.5,0],'LineWidth',lw,'Marker','h','MarkerSize',15,...
    'MarkerFaceColor',[0.9,0.5,0],'MarkerEdgeColor',[0.9,0.5,0]);
line(Bx,abs(FN5),'LineStyle','-','color',[0.9,0.0,0],'LineWidth',lw,'Marker','<','MarkerSize',15,...
    'MarkerFaceColor',[0.9,0.0,0],'MarkerEdgeColor',[0.9,0.0,0]);

% line(dJ1,real(chi1_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
% line(dJ2,real(chi2_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
xlim([-1e-3,1e-3]);         ylim([0,0.5]);
set(gca,'TickLength',[0.03,0.03],'box','on','FontSize',fz2,'LineWidth',2);%'XScale','log','YScale','log',
% set(gca,'xtick',[1e-5,1e-4,1e-3,1e-2],'ytick',[1e-1,1,1e1,1e2,1e3,1e4],...
%     'XTickLabel',{'-10^{-5}','-10^{-4}','-10^{-3}','-10^{-2}'},'FontSize',fz2,'LineWidth',2);%
h2=legend(' ',' ',' ','', ' ');%'N=5', ,' N=320'
set(h2,'position',[0.2,0.5,0.01,0.5]);%
set(h2,'box', 'off','FontSize',24);




fname='./CorrelationNormalized_diff_N.pdf';
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);
% end


%% Phase transition
if  0
fz1=48;fz2=36;
lw=4;
 
figure()
line(abs(Bx),abs(F1),'LineStyle','non','Marker','o','MarkerSize',15,...
    'MarkerFaceColor',[0.3,0.5,1]);
line(abs(Bx),abs(F2),'LineStyle','non','Marker','d','MarkerSize',15,...
    'MarkerFaceColor',[0.0,0.588,0.03],'MarkerEdgeColor',[0.0,0.588,0.03]);
line(abs(Bx),abs(F3),'LineStyle','non','Marker','h','MarkerSize',15,...
    'MarkerFaceColor',[0.9,0.5,0],'MarkerEdgeColor',[0.9,0.5,0]);
line(abs(Bx),abs(F4),'LineStyle','non','Marker','>','MarkerSize',15,...
    'MarkerFaceColor',[0.9,0.0,0],'MarkerEdgeColor',[0.9,0.0,0]);

% line(dJ1,real(chi1_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
% line(dJ2,real(chi2_an),'LineStyle','-','Color',[0,0.0,0.0],'LineWidth',0.5*lw);
xlim([1e-5,1e-1]);ylim([5e5,1e10]);
set(gca,'XScale','log','YScale','log','TickLength',[0.03,0.03],'box','on','FontSize',fz2,'LineWidth',2);
% set(gca,'xtick',[1e-5,1e-4,1e-3,1e-2],'ytick',[1e-1,1,1e1,1e2,1e3,1e4],...
%     'XTickLabel',{'-10^{-5}','-10^{-4}','-10^{-3}','-10^{-2}'});%
h2=legend('','','','');%'N=5', ,' N=320'
set(h2,'position',[0.2,0.05,0.02,0.5]);
set(h2,'box', 'off','FontSize',24);




fname='./CriticalScalings_diff_J0.pdf';
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);
 end