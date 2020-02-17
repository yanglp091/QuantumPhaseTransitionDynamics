function Ltot=LConstruct(para,Ops,t)
  
    model=para.Model;
    switch model       
        case 'Dicke'          
            Ltot = LDicke(para,Ops,t);
        case 'TwoLevelAtom'
            Ltot = LTwoLevelAtom(para,Ops,t);
        case 'ThreeLevelAtom'
            Ltot = LThreeLevelAtom(para,Ops,t);
        case 'ReducedTwoLevelAtom'
            Ltot = LReTwoLevelAtom(para,Ops,t);
        otherwise
            error('This type of Louvillian has not been defined!');
            
    end
end