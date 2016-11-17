%compute the HML factor
%[~,~,smallBIG]=xlsread('Financial Accounting Data.xlsx',7);
%[~,~,Profitability]=xlsread('RMW.xlsx',2);
%{
[nrows,ncols]=size(Profitability);
for ii=2:2:ncols
    Profitability(:,ii)
end
%}
% Find the breakpoints (stock splits) by parsing indices

%{
stocksplitRMW=stocksplit(Profitability);
stocksplitSB=stocksplit(smallBIG);
%}
%
% Small Low portfolios
%
contor=1;
SWeak=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=2:(stocksplitRMW(col/2,1))
            aa=cellfun(@strcmp,smallBIG(sb,col),Profitability(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0   %// we still need to check if the
                %//portfolio' stock quotes are numeric and greater than 0
                    SWeak(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%

% Small Medium portfolios
%
contor=1;
SMedium=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=(1+stocksplitRMW(col/2,1)):stocksplitRMW(col/2,2)
            aa=cellfun(@strcmp,smallBIG(sb,col),Profitability(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    SMedium(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%
% Small High
%
contor=1;
SRobust=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=(stocksplitRMW(col/2,2)+1):43
            aa=cellfun(@strcmp,smallBIG(sb,col),Profitability(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    SRobust(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%
% Big Small portfolios
%
contor=1;
BWeak=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=2:(stocksplitRMW(col/2,1))
            aa=cellfun(@strcmp,smallBIG(sb,col),Profitability(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BWeak(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%

%Big Medium Portfolios
%
contor=1;
BMedium=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=(1+stocksplitRMW(col/2,1)):stocksplitRMW(col/2,2)
            aa=cellfun(@strcmp,smallBIG(sb,col),Profitability(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BMedium(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%

%Big High portfolios
%
contor=1;
BRobust=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=(stocksplitRMW(col/2,2)+1):43
            aa=cellfun(@strcmp,smallBIG(sb,col),Profitability(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BRobust(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%
%}
% Compute the HML Factor
% HML=(BH+BS)/2-(SH+SL)/2
% refer to HML.txt for a concise description

