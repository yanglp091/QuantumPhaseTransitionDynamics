function    obs = pre_obs_hilbert(para)
    option=para.option;
    dimf = para.dimf;
    na = para.natom;

    if dimf>1
        obs.PhotonNumber = Hf_construct(dimf, na, option)/na;
        obs.PhotonNumber2 = (Hf_construct(dimf, na, option)/na)^2;
        obs.Amplitude = Hdestroy(dimf, na, 1, option);
        obs.Hrwa = Hrwa_construct(dimf, na, 1, option)/na;
        obs. Hnrwa = Hnrwa_construct(dimf, na, 1, option)/na;
    end
    
    if na>1
        obs.Sz = Hsz(dimf, na, 1, option)/na;
        obs.Sz2 = HIsing(dimf, na, 0,0,1, option)/na;

        obs.Sx = Hsx(dimf, na, 1, option)/na;
        obs.Sx2 = HIsing(dimf, na, 1,0,0, option)/na;

        obs.Sy = Hsy(dimf, na, 2, option)/na;
        obs.Sy2 = HIsing(dimf, na, 0,1,0, option)/na;
    end
end