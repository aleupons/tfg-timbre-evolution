function zc_computation(groupNum)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%zc_computation(groupNum)

%This function computes zero-crossing count for 50ms frames with half 
%overlapping of every song of the selected group of the data-set. Then, 
%mean, variance, minimum, maximum and median statistics are computed for 
%zero-crossing count values of each song in order to make the bag of frames

%groupNum: matrix number corresponding to data-set group (1,2,3,4 or 5)

%ZCX.mat saves zero-crossing count values and its bag of frames for the 
%selected group

%Author: Aleu Pons
%Date: 6 June 2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
        Feat{1,2}(j) = mirzerocross(strcat(subdir,filename),'Frame');
        ZCdata{j} = mirgetdata(Feat{1,2}(j));
        %Stats
        %ZCdata
        ZCdataS{j}(1) = mean(ZCdata{j});
        ZCdataS{j}(2) = var(ZCdata{j});
        ZCdataS{j}(3) = min(ZCdata{j});
        ZCdataS{j}(4) = max(ZCdata{j});
        ZCdataS{j}(5) = median(ZCdata{j});
        j=j+1;
    end
   
end

if groupNum==1
    save ZC1.mat ZCdata Feat ZCdataS
elseif groupNum==2
    save ZC2.mat ZCdata Feat ZCdataS
elseif groupNum==3
    save ZC3.mat ZCdata Feat ZCdataS
elseif groupNum==4
    save ZC4.mat ZCdata Feat ZCdataS
elseif groupNum==5
    save ZC5.mat ZCdata Feat ZCdataS
end

end