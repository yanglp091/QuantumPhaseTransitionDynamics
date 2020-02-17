function [H, H_list]=HTwoLargeSpin(para)
    dim1 = para.dim1;% cutoff of the first spin
    dim2 = para.dim2;% cutoff the second spin
    
    epsilon = para.epsilon;
    lambda = para.lambda;
    op_rwa = para.RWA;
    
    id1 = identity(dim1); id2 = identity(dim2);
    
    Jz1 = jmat( (dim1-1)/2,'z');
    h1 =  tensor(Jz1, id2);
    
    Jz2 = epsilon*jmat( (dim2-1)/2,'z');
    h2 = tensor(id1, Jz2);

    Jp1 = jmat((dim1-1)/2,'+')/sqrt(dim1-1);%
    Jp2 = jmat( (dim2-1)/2,'+')/sqrt(dim2-1);
    hrwa = lambda*tensor(Jp1, Jp2') + lambda*tensor(Jp1, Jp2')';
       
    hnrwa=0;
    if op_rwa == 0
       hnrwa = lambda*tensor(Jp1, Jp2) + lambda*tensor(Jp1, Jp2)';
    end    
    
    H = h1 + h2 +hrwa+hnrwa;
    H_list.hf=h1;
    H_list.ha=h2;
    H_list.hrwa=hrwa;
    H_list.hnrwa=hnrwa;   
end