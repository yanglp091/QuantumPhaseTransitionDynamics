function xi = PulseAmplitude(t, tauf, pulseshape)
% t0:  the time that the peak of the pulse arrives at the atom
% tauf: the pulse length

    nt=length(t);
    xi = zeros(1,nt);
    for j=1:nt
        tj=t(j);
        switch pulseshape
            case 'DecayingExp'
                t0=0;
                xi(j) = sqrt(1/tauf)*exp(-(tj-t0)/2/tauf);
                if tj <0
                    xi(j) =0;
                end
            case  'RisingExp'
                t0=10*tauf;
                xi(j) = sqrt(1/tauf)*exp((tj-t0)/2/tauf);
                if tj-t0 >0
                    xi(j) =0;
                end            
            case 'Gaussian'
                t0 = 10* tauf;
                xi(j) =1/(2*pi*tauf^2)^(1/4)*exp(-(tj-t0)^2/4/tauf^2);
            otherwise
                error('No such kind of pulse shape');    
        end
    end
end