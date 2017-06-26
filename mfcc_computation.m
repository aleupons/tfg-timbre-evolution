function mfcc_computation(groupNum)
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
        MFCC{1,1}(j) = filename;
        MFCC{1,2}(j) = mirmfcc(strcat(subdir,filename),'Rank',0:13,'Frame');
        mfccdata = mirgetdata(MFCC{1,2}(j));
        MFCC{1,3}{j} = deltas(mfccdata);
        MFCC{1,4}{j} = deltas(MFCC{1,3}{j});
        %Stats
        for k=1:size(MFCC{1,3}{j},1)
            %Delta
            DeltaS{j}(k,1) = mean(MFCC{1,3}{j}(k,:));
            DeltaS{j}(k,2) = var(MFCC{1,3}{j}(k,:));
            %Delta-delta
            Delta2S{j}(k,1) = mean(MFCC{1,4}{j}(k,:));
            Delta2S{j}(k,2) = var(MFCC{1,4}{j}(k,:));
            %MFCC
            MFCCS{j}(k,1) = mean(mfccdata(k,:));
            MFCCS{j}(k,2) = var(mfccdata(k,:));
            MFCCS{j}(k,3) = min(mfccdata(k,:));
            MFCCS{j}(k,4) = max(mfccdata(k,:));
            MFCCS{j}(k,5) = median(mfccdata(k,:));
        end
        j=j+1;
    end
   
end

if groupNum==1
    save MFCC1.mat MFCC DeltaS Delta2S MFCCS
elseif groupNum==2
    save MFCC2.mat MFCC DeltaS Delta2S MFCCS
elseif groupNum==3
    save MFCC3.mat MFCC DeltaS Delta2S MFCCS
elseif groupNum==4
    save MFCC4.mat MFCC DeltaS Delta2S MFCCS
elseif groupNum==5
    save MFCC5.mat MFCC DeltaS Delta2S MFCCS
end

end