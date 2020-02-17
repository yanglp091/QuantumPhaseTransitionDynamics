%% Quantum Jitter nphoton =1
if 0
    
fz1=48;fz2=40;
lw=4;

figure();
mesh(Omegalist,gammalist,Pemat);
view([-40,10]);
xlim([1e-3,100]); ylim([1e-3,50]);
set(gca,'XScale','log','YScale','log');
set(gca,'xtick',[1e-3,1e-2,1e-1,1,1e1,1e2],'ytick',[1e-3,1e-2,1e-1,1,1e1],'ztick',0:0.25:1);
set(gca,'FontSize',fz2,'LineWidth',2.5,'TickDir','out','TickLength',[0.03,0.03]);

fname=['./PeVsGamma_Photon1' '_3D.pdf'];
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);
end


%% Quantum Jitter
% if 0
    
Pe1=Pemat(:,19);    gamma1 = 0.1;
Pe2=Pemat(:,37);    gamma2 = 1;
Pe3=Pemat(:,52);    gamma3 = 5;
    
fz1=48;fz2=48;
lw=4;

figure();
line(gammalist,Pe1,'LineStyle','-','LineWidth',lw,'Marker','o','MarkerSize',16,'color',[0.871,0.49,0])
line(gammalist,Pe2,'LineStyle','-','LineWidth',lw,'Marker','>','MarkerSize',16,'color',[0.467,0.675,0.188])
line(gammalist,Pe3,'LineStyle','-','LineWidth',lw,'Marker','d','MarkerSize',16,'color',[0.0,0.447,0.741])
xlim([1e-3,20]); 
set(gca,'XScale','log','box','on','FontSize',fz2,'LineWidth',2.5,'TickLength',[0.02,0.02]);
set(gca,'xtick',[1e-3,1e-2,1e-1,1,1e1],'ytick',0:0.2:1,'FontSize',fz2);


h2=legend('','','');%, ,' N=320'
set(h2,'position',[0.12,0.25,0.2,0.3]);
set(h2,'box', 'off','FontSize',fz2);


fname=['./PeVsGamma_Photon1' '_2D.pdf'];
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);
% end


%% Quantum Jitter nphoton =10
if 0
    
fz1=48;fz2=32;
lw=4;

figure();
mesh(Gammalist,gammalist,Pemat);
xlim([1e-3,100]); ylim([1e-3,10]);
set(gca,'XScale','log','YScale','log');
set(gca,'xtick',[1e-3,1e-2,1e-1,1,1e1,1e2],'ytick',[1e-3,1e-2,1e-1,1,1e1],'ztick',0:0.25:1,'FontSize',fz2);
view([-52,17])

fname=['./PeVsGamma_Photon10' '_3D.pdf'];
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);
end


%% Quantum Jitter
if 0

Pe1=Pemat(19,:);    gamma1 = 0.1;
Pe2=Pemat(37,:);    gamma2 = 1;
Pe3=Pemat(64,:);    gamma3 = 10;

fz1=48;fz2=32;
lw=4;

figure();
line(Gammalist,Pe1,'LineStyle','-','LineWidth',lw,'Marker','*','MarkerSize',5,'color',[1,0,0])
line(Gammalist,Pe2,'LineStyle','-','LineWidth',lw,'Marker','o','MarkerSize',5,'color',[0,0.5,0])
line(Gammalist,Pe3,'LineStyle','-','LineWidth',lw,'Marker','+','MarkerSize',5,'color',[0.1,0,0.8])
xlim([1e-3,100]); 
set(gca,'XScale','log','box','on');
set(gca,'xtick',[1e-3,1e-2,1e-1,1,1e1,1e2],'ytick',0:0.2:1,'FontSize',fz2);


h2=legend('','','');%, ,' N=320'
set(h2,'position',[0.12,0.6,0.2,0.3]);
set(h2,'box', 'off','FontSize',fz2);


fname=['./PeVsGamma_Photon10' '_2D.pdf'];
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);
end




%% Phase transition
if 0
    
fz1=36;fz2=24;
lw=4;

figure();
subplot('position',[0.03,0.55,0.18,0.2]),
meshc(X11,Y11,Z11);       xlim([-10,10]);     ylim([-10,10]); 
zlim([-10,0]); colormap(jet);
set(gca,'xtick',-10:10:10,'ytick',-10:10:10,'ztick',-10:5:0,'FontSize',fz2);
set(gca,'XMinorTick','on','YMinorTick','on','ZMinorTick','on')

subplot('position',[0.28,0.55,0.18,0.2]),
meshc(X12,Y12,Z12);       xlim([-10,10]);     ylim([-10,10]); 
zlim([-20,0]);  colormap(jet);
set(gca,'xtick',-10:10:10,'ytick',-10:10:10,'ztick',-20:10:0,'FontSize',fz2);
set(gca,'XMinorTick','on','YMinorTick','on','ZMinorTick','on')

subplot('position',[0.52,0.55,0.18,0.2]),
meshc(X13,Y13,Z13);       xlim([-10,10]);     ylim([-10,10]); 
zlim([-20,0]);  colormap(jet);
set(gca,'xtick',-10:10:10,'ytick',-10:10:10,'ztick',-20:10:0,'FontSize',fz2);
set(gca,'XMinorTick','on','YMinorTick','on','ZMinorTick','on')

subplot('position',[0.78,0.55,0.18,0.2]),
meshc(X14,Y14,Z14);       xlim([-10,10]);     ylim([-10,10]); 
zlim([-10,0]);  colormap(jet);
set(gca,'xtick',-10:10:10,'ytick',-10:10:10,'ztick',-10:5:0,'FontSize',fz2);
set(gca,'XMinorTick','on','YMinorTick','on','ZMinorTick','on')

fname=['./QFs' '.pdf'];
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);

end

%% Transduction
if 0
fz1=48;fz2=36;
lw=4;

figure();
line(tlist,Pet,'LineStyle','-','LineWidth',lw,'Marker','*','MarkerSize',5)
xlim([-5,10]);         ylim([0.,1.0]);   
set(gca,'xtick',-5:5:10,'ytick',0.0:0.2:1,'FontSize',fz2);
set(gca,'XMinorTick','on','YMinorTick','on');
box on;

fname=['./TransductEfficiency' '.pdf'];
set(gcf,'PaperSize',[21 16],'PaperPosition',[0.6, 0.6, 20, 15]);
saveas(gcf, fname);

end