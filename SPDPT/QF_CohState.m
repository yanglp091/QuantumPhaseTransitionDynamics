function output=QF_CohState(inputs,option)
%This function construct the operator  for calcualting the normalized Q-function
% QF =(1/pi) exp(-|apha-alpha0|^2)
% for the boson mode or
% QF = 


    switch option
        case 'Boson'
            x0=inputs.x0;
            y0=inputs.y0;
            xlist=inputs.xlist;
            ylist=inputs.ylist;
            nx=length(xlist);
            ny= length(ylist);
            QFmat=zeros(ny,nx);
            for j=1:ny
                y=ylist(j);
                for k=1:nx
                    x=xlist(k);
                    QFmat(j,k)=(1/pi)*exp(-(x-x0).^2-(y-y0).^2);
                end
            end
            output.xlist=xlist;
            output.ylist=ylist;
            output.QF=QFmat;    
        case 'Spin'
            na=inputs.natom;
            theta0=inputs.theta0;
            phi0=inputs.phi0;
            psi0=Spin_cohstate_construct(na,theta0, phi0);
            thetalist=inputs.thetalist;
            philist=inputs.philist;
            ntheta=length(thetalist);
            nphi= length(philist);
            QFmat=zeros(ntheta,nphi);
            for j=1:ntheta
                theta=thetalist(j);
                for k=1:nphi
                    phi=philist(k);
                    psi=Spin_cohstate_construct(na,theta, phi);
                    QFmat(j,k)=(na+1)/4/pi*(abs(psi'*psi0))^2;
                end
            end
            val=max(max(abs(QFmat)));QFmat=QFmat/val;
            [phi,theta]=meshgrid(philist,thetalist-pi/2);
            [x,y,z] = sph2cart(phi,theta,real(QFmat));
            output.x=x;
            output.y=y;
            output.z=z;
        otherwise
            error('This type of Hamitlonian has not been defined!');
    end


end