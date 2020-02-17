function [H,H_list]=HConstruct(para)
    option = para.option;
    
    switch option
        
        case 'distinguish'
            [H,H_list] = HDicke(para);
          
        case 'indistinguish'
            [H, H_list] = HDicke(para);
        case 'twospin'
            [H, H_list] = HTwoLargeSpin(para);
        otherwise
            error('This type of Hamitlonian has not been defined!');
            
    end
end