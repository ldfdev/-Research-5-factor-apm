function stocksplitLMH = stocksplit(x,nosplits)

%   This function computes the breakpoints
%     as indices for the LMH portfolios
%   If nosplits=3, then the function sets the Low, Medium, High portfolios
%   If nosplits =2, then the function sets the Small, Big portfolios.
if nosplits==3
        stocksplitLMH=zeros(10,2);
end
if nosplits==2
        stocksplitLMH=zeros(10,1);
end
for jj=3:2:21 % data spans over 10 years. thus jj!
    index=1;
    a=cellfun(@isnan,x(:,jj),'UniformOutput',false);
    b=cellfun(@isnumeric,x(:,jj),'UniformOutput',false);
    [arows,~]=size(a);
    for kk =1:arows
        if (b{kk,1}==0)
            if a{kk,1}==0
                a{kk,1}=1;
            end
        end
    end % we searched for nonempty cell but also nonnumeric.
    no_good_firms=0;
    for kk =1:arows
        if (a{kk,1}==0)
            no_good_firms=no_good_firms+1;
        end
    end % we obtain the breakpoints from the no of companies available
        % firstly search the no of companies!!!
    
    %Low <30% // Small=50%
    %Medium <70% 
    %High <100% // Big=100%
    
    if nosplits==3
         % LMH excel file has 43 rows
        Low=fix(0.3*no_good_firms);
        Medium=fix(0.7*no_good_firms);
        contor=1;
        control=0;
        control2=0;% we wish to assign to vector stocksplit only once the low value
        for kk =1:arows
            if (a{kk,1}==0)
                contor=contor+1;
            end
            if contor==Low
                if control==0
                    stocksplitLMH((jj-1)/2,index)=Low;
                    index=index+1;
                    control=1;
                end
            end
            if contor==Medium
                if control2==0
                    stocksplitLMH((jj-1)/2,index)=Medium;
                    index=index+1;
                    control2=1;
                end
            end
             % medium is the last element from the vector we search for.
                   % after attaining it, we break.
        end
    end
    if nosplits==2
         % SB excel file has 42 rows
        Small=fix(0.5*no_good_firms);
        contor=1;
        for kk =1:arows
            if (a{kk,1}==0)
                contor=contor+1;
            end
            if contor==Small
                stocksplitLMH((jj-1)/2,index)=Small;
                index=index+1;
                break;
            end
             % small is the last element from the vector we search for.
                   % after attaining it, we break.
        end
    end
end
