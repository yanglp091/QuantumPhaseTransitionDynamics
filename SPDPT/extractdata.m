function datalist=extractdata(datacell,fname,opt)
    if nargin==2       
        opt = 'rows';
    end
    [nrow, ncol]=size(datacell);
    
    switch opt
        case 'rows'
            data=eval(['datacell{1,1}.' fname]);
            nda=length(data);
            datalist=zeros(nrow,nda);
            for j=1:nrow

                datalist(j,:)=eval(['datacell{j,1}.' fname]);
            end
        case 'columns'
            data=eval(['datacell{1,1}.' fname]);
            nda=length(data);
            datalist=zeros(ncol,nda);
            for j=1:ncol
                datalist(j,:)=eval(['datacell{j,1}.' fname]);
            end
            
       case 'matrix'
            datalist=zeros(nrow,ncol);
            for j=1:nrow
                for k=1:ncol
                    datalist(j,k)=eval(['datacell{j,k}.' fname]);
                end
            end
        otherwise 
             error('This kind of operation has not been defined!');
    end

end