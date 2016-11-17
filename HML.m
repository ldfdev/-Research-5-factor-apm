%compute the HML factor
%[~,~,smallBIG]=xlsread('Financial Accounting Data.xlsx',7);
%[~,~,LowMedHigh]=xlsread('Financial Accounting Data.xlsx',8);
%{
[nrows,ncols]=size(LowMedHigh);
for ii=2:2:ncols
    LowMedHigh(:,ii)
end
%}
% Find the breakpoints (stock splits) by parsing indices

%{
stocksplitLMH=stocksplit(LowMedHigh);
stocksplitSB=stocksplit(smallBIG);
%}
%
% Small Low portfolios
%{
contor=1;
SL=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=2:(stocksplitLMH(col/2,1))
            aa=cellfun(@strcmp,smallBIG(sb,col),LowMedHigh(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0   %// we still need to check if the
                %//portfolio' stock quotes are numeric and greater than 0
                    SL(contor,col)=smallBIG(sb,col);
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
SM=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=(1+stocksplitLMH(col/2,1)):stocksplitLMH(col/2,2)
            aa=cellfun(@strcmp,smallBIG(sb,col),LowMedHigh(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    SM(contor,col)=smallBIG(sb,col);
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
SH=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=(stocksplitLMH(col/2,2)+1):43
            aa=cellfun(@strcmp,smallBIG(sb,col),LowMedHigh(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    SH(contor,col)=smallBIG(sb,col);
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
BL=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=2:(stocksplitLMH(col/2,1))
            aa=cellfun(@strcmp,smallBIG(sb,col),LowMedHigh(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BL(contor,col)=smallBIG(sb,col);
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
BM=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=(1+stocksplitLMH(col/2,1)):stocksplitLMH(col/2,2)
            aa=cellfun(@strcmp,smallBIG(sb,col),LowMedHigh(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BM(contor,col)=smallBIG(sb,col);
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
BH=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=(stocksplitLMH(col/2,2)+1):43
            aa=cellfun(@strcmp,smallBIG(sb,col),LowMedHigh(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BH(contor,col)=smallBIG(sb,col);
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

