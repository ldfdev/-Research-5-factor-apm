%[~,~,Investment]=xlsread('CMA.xlsx',2);

%stocksplitCMA=stocksplit(Investment,3);

% Small Conservative portfolios
%{
contor=1;
SConservative=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=2:(stocksplitCMA(col/2,1))
            aa=cellfun(@strcmp,smallBIG(sb,col),Investment(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0   %// we still need to check if the
                %//portfolio' stock quotes are numeric and greater than 0
                    SConservative(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%

% Small MediumCMA portfolios
%
contor=1;
SMediumCMA=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=(1+stocksplitCMA(col/2,1)):stocksplitCMA(col/2,2)
            aa=cellfun(@strcmp,smallBIG(sb,col),Investment(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    SMediumCMA(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%
% Small Agressive
%
contor=1;
SAgressive=cell(1);
for col=2:2:21
    for sb=2:(stocksplitSB(col/2,1))
        for lmh=(stocksplitCMA(col/2,2)+1):43
            aa=cellfun(@strcmp,smallBIG(sb,col),Investment(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    SAgressive(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%
% Big Conservative portfolios
%
contor=1;
BConservative=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=2:(stocksplitCMA(col/2,1))
            aa=cellfun(@strcmp,smallBIG(sb,col),Investment(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BConservative(contor,col)=smallBIG(sb,col);
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
BMediumCMA=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=(1+stocksplitCMA(col/2,1)):stocksplitCMA(col/2,2)
            aa=cellfun(@strcmp,smallBIG(sb,col),Investment(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BMediumCMA(contor,col)=smallBIG(sb,col);
                    contor=contor+1;
                end
            end
        end
    end
    contor=1;
end
%

%Big Agressive portfolios
%
contor=1;
BAgressive=cell(1);
for col=2:2:21
    for sb=(stocksplitSB(col/2,1)+1):43
        for lmh=(stocksplitCMA(col/2,2)+1):43
            aa=cellfun(@strcmp,smallBIG(sb,col),Investment(lmh,col));
            if aa==1
                aa=smallBIG{sb,col+1};
                if isnumeric(aa) && aa>0
                    BAgressive(contor,col)=smallBIG(sb,col);
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

returnSConservative=portfReturn(SConservative,returnraw,dates);
returnSMediumCMA=portfReturn(SMediumCMA,returnraw,dates);
returnSAgressive=portfReturn(SAgressive,returnraw,dates);
returnBConservative=portfReturn(BConservative,returnraw,dates);
returnBMediumCMA=portfReturn(BMediumCMA,returnraw,dates);
returnBAgressive=portfReturn(BAgressive,returnraw,dates);
%}
xlswrite('CMA.xlsx',returnSConservative,3,'A2');
xlswrite('CMA.xlsx',returnSMediumCMA,3,'B2');
xlswrite('CMA.xlsx',returnSAgressive,3,'C2');
xlswrite('CMA.xlsx',returnBConservative,3,'D2');
xlswrite('CMA.xlsx',returnBMediumCMA,3,'E2');
xlswrite('CMA.xlsx',returnBAgressive,3,'F2');









