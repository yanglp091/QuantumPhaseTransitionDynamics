function output=ObsThermalMean(dd,V,beta,obs,para)
    fnames = fieldnames(obs);
    nobs=length(fnames);
    
     switch ischar(beta) 
         case 1
             [~,idx]=min(dd);
             vec = V(:,idx);
             for j=1:nobs
                fn=fnames{j,1};
                obsmat=eval(['obs.' fn]);
                val=vec'*obsmat(:,:)*vec;
                eval(['output.' fn '=val;']);      
            end

         case 0
            para.beta=beta;
            output.para=para;

            [~,pp] = PartitionFun(dd,beta);% partion function and population list        
            output.population=pp;
            for j=1:nobs
                fn=fnames{j,1};
                obsmat=eval(['obs.' fn]);

                val_list=diag(V'*obsmat(:,:)*V*diag(pp));
                fn1=[fn 'list'];
                eval(['output.' fn1 '=val_list;']);
                eval(['output.' fn '=sum(val_list);']);      
            end
         otherwise
           error('There is a problem in temperature setting! ')  
     end
end