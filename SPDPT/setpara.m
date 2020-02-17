function para=setpara(hami_para,ex_para)
    fnames1 = fieldnames(hami_para);
    nnames1=length(fnames1);
    
    
    fnames2 = fieldnames(ex_para);
    nnames2=length(fnames2);
    
    for j=1:nnames1
        eval(['para.' fnames1{j} '=hami_para.' fnames1{j} ';']);
    end
        
    for j=1:nnames2
        eval(['para.' fnames2{j} '=ex_para.' fnames2{j} ';']);
    end
end