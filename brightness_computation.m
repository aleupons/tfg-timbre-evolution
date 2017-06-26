function brightness_computation(groupNum)
%MFCC_COMPUTATION Summary of this function goes here
%   groupNum: matrix number (1,2,3,4 or 5)

load('C:\Users\usuario\Documents\TFG\Data (ground truth)\M.mat');
if groupNum==1
    foldername = '1962-1966 - British pop\';
    M = M1;
    str = '196';
    L = 3;
elseif groupNum==2
    foldername = '1975-1979 - Disco & Punk\';
    M = M2;
    str = '197';
    L = 3;
elseif groupNum==3
    foldername = '1989-1993 - Hip hop\';
    M = M3;
    str = '19';
    L = 2;
elseif groupNum==4
    foldername = '1997-2001 - Boy & girl bands + Pop starlets\';
    M = M4;
    str = '199';
    str2 = '200';
    L = 3;
elseif groupNum==5
    foldername = '2012-2016 - Trap\';
    M = M5;
    str = '201';
    L = 3;
end

dir = strcat('C:\Users\usuario\Documents\TFG\Data-set (music)\WAV\',foldername);
j=1;
for i=3:length(M{1,1})
    if groupNum==4
        if strncmp(M{1,1}(i),str,L) == 1 || strncmp(M{1,1}(i),str2,L) == 1
            comp = 1;
        else
            comp = 0;
        end
    else
        if strncmp(M{1,1}(i),str,L) == 1
            comp = 1;
        else
            comp = 0;
        end
    end
    
    if comp==1
        year = M{1,1}(i);
        subdir = cell2mat(strcat(dir,year,'\'));
    else
        filename = strcat(strrep(M{1,1}(i),'"',''),'.wav');
        Feat{1,1}(j) = filename;
        Feat{1,2}(j) = mirbrightness(strcat(subdir,filename),'Frame');
        Bdata{j} = mirgetdata(Feat{1,2}(j));
        Bdata{j} = Bdata{j}(~isnan(Bdata{j}));            
        %Stats
        %Bdata
        BdataS{j}(1) = mean(Bdata{j});
        BdataS{j}(2) = var(Bdata{j});
        BdataS{j}(3) = min(Bdata{j});
        BdataS{j}(4) = max(Bdata{j});
        BdataS{j}(5) = median(Bdata{j});
        j=j+1;
    end
   
end

if groupNum==1
    save B1.mat Bdata Feat BdataS
elseif groupNum==2
    save B2.mat Bdata Feat BdataS
elseif groupNum==3
    save B3.mat Bdata Feat BdataS
elseif groupNum==4
    save B4.mat Bdata Feat BdataS
elseif groupNum==5
    save B5.mat Bdata Feat BdataS
end

end