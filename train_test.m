function train_test(groupNum, version)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%train_test(groupNum, 'vx')

%This function preprocess timbre features computed in mfcc_computation,
%brightness_computation and zc_computation in order to obtain a matrix of
%features able to be trained (TrainData). Then, with prepared data
%containing perceptual observations (ground truth), an SVM models is
%obtained by training data for each of 10 music characteristics defined.
%Also a validation of these models is computed and evaluated with 4
%measures

%groupNum: matrix number corresponding to data-set group (1,2,3,4 or 5)
%version: training-test version ('v1' or 'v2')

%TrainDataX.mat saves SVM models for each music characteristic and new 
%labels of test classified data

%Author: Aleu Pons
%Date: 25 May 2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('C:\Users\usuario\Documents\TFG\Data (ground truth)\M.mat');
if groupNum==1
    load('C:\Users\usuario\Documents\TFG\Timbre\MFCC1.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\B1.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\ZC1.mat');
    foldername = '1962-1966 - British pop\';
    M = M1;
    str = '196';
    L = 3;
elseif groupNum==2
    load('C:\Users\usuario\Documents\TFG\Timbre\MFCC2.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\B2.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\ZC2.mat');
    foldername = '1975-1979 - Disco & Punk\';
    M = M2;
    str = '197';
    L = 3;
elseif groupNum==3
    load('C:\Users\usuario\Documents\TFG\Timbre\MFCC3.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\B3.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\ZC3.mat');
    foldername = '1989-1993 - Hip hop\';
    M = M3;
    str = '19';
    L = 2;
elseif groupNum==4
    load('C:\Users\usuario\Documents\TFG\Timbre\MFCC4.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\B4.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\ZC4.mat');
    M = M4;
    str = '199';
    str2 = '200';
    L = 3;
elseif groupNum==5
    load('C:\Users\usuario\Documents\TFG\Timbre\MFCC5.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\B5.mat');
    load('C:\Users\usuario\Documents\TFG\Timbre\ZC5.mat');
    M = M5;
    str = '201';
    L = 3;
end

j=1;
cnt=0;
for i=3:length(M{1,2})
    if groupNum==4
        if strncmp(M{1,1}(i),str,L) == 0 && strncmp(M{1,1}(i),str2,L) == 0
            comp = 1;
        else
            comp = 0;
            cnt = cnt+1;
        end
    else
        if strncmp(M{1,1}(i),str,L) == 0
            comp = 1;
        else
            comp = 0;
            cnt = cnt+1;
        end
    end
    
    if comp==1
        filename = strcat(strrep(M{1,1}(i),'"',''),'.wav');
        D(j,1) = filename;
        D(j,2) = strrep(M{1,3}(i),'"',''); %First feature
        D(j,3) = strrep(M{1,4}(i),'"',''); %Second feature
        D(j,4) = strrep(M{1,2}(i),'"',''); %Weeks on 1st position
        if groupNum==2
            D(j,4) = strrep(M{1,5}(i),'"',''); %Third feature
            D(j,5) = strrep(M{1,2}(i),'"',''); %Weeks on 1st position
        end
        j=j+1;
    elseif comp==0 && cnt==1
        pos = j;
        y = i;
    elseif comp==0 && cnt>1
        years(pos:j-1) = M{1,1}(y);
        pos = j;
        y = i;
    end
end
years(pos:j-1) = M{1,1}(y);

for i=1:length(MFCCS)
    Data{i} = [MFCCS{i},DeltaS{i},Delta2S{i}]; %All features
end

for i=1:length(Data)
    TrainData(i,:) = reshape(Data{i},1,size(Data{i},1)*size(Data{i},2)); %allSongs*numFeat (numFeat=14*9=126)
end

%90% of songs for training (80% version 1)
if strcmp(version,'v1')
    numSongs = round(80*length(Data)/100);
elseif strcmp(version,'v2')
    numSongs = round(90*length(Data)/100);
end
%groups of 10% of all songs for training
group = length(Data)-numSongs;
last = mod(length(Data),group);

if groupNum==1
    %Brightness stats
    for k=1:length(BdataS)
        b(k,:) = BdataS{k};
    end
    %Zero Crossing Rate stats
    for k=1:length(ZCdataS)
        zc(k,:) = ZCdataS{k};
    end
    
    data = [TrainData(:,15:28),TrainData(:,43:56),TrainData(:,71:98),TrainData(:,113:126),b(:,1:4),zc(:,1:4)];
    %data = [TrainData(:,1:126)];
    labels = D(:,2);
    kernel = 'polynomial';
    %kernel = 'rbf';
    
    if strcmp(version,'v1')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v1(numSongs,data,labels,kernel);
    elseif strcmp(version,'v2')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v2(group,last,data,labels,kernel);
    end
    aTest
    pTest
    rTest
    FTest
    aTrain
    pTrain
    rTrain
    FTrain
    
elseif groupNum==2
    %Brightness stats
    for k=1:length(BdataS)
        b(k,:) = BdataS{k};
    end
    %Zero Crossing Rate stats
    for k=1:length(ZCdataS)
        zc(k,:) = ZCdataS{k};
    end
    
    %First class
    %data = [TrainData(:,1:126),b];
    data = [TrainData(:,15:28),TrainData(:,43:56),TrainData(:,57:84),TrainData(:,113:126),zc(:,1:4)];
    labels = D(:,2);
    kernel = 'quadratic';
    %kernel = 'polynomial';
    
    if strcmp(version,'v1')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v1(numSongs,data,labels,kernel);
    elseif strcmp(version,'v2')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v2(group,last,data,labels,kernel);
    end
    aTest
    pTest
    rTest
    FTest
    aTrain
    pTrain
    rTrain
    FTrain
    
    %Second class
    data2 = [TrainData(:,15:28),TrainData(:,43:56),TrainData(:,57:84),TrainData(:,113:126)];
    %data2 = [TrainData(:,1:126)];
    labels2 = D(:,3);
    kernel2 = 'quadratic';
    %kernel2 = 'no';
    
    if strcmp(version,'v1')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v1(numSongs,data2,labels2,kernel2);
    elseif strcmp(version,'v2')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v2(group,last,data2,labels2,kernel2);
    end
    aTest2
    pTest2
    rTest2
    FTest2
    aTrain2
    pTrain2
    rTrain2
    FTrain2
    
    %Third class
    %data3 = TrainData(:,1:126);
    data3 = [TrainData(:,1:14),TrainData(:,29:42),TrainData(:,113:126),b];
    labels3 = D(:,4);
    kernel3 = 'polynomial';
    %kernel3 = 'no';
    
    if strcmp(version,'v1')
        [aTest3,pTest3,rTest3,FTest3, aTrain3,pTrain3,rTrain3,FTrain3, SVMStruct3, NewClassTest3] = train_test_v1(numSongs,data3,labels3,kernel3);
    elseif strcmp(version,'v2')
        [aTest3,pTest3,rTest3,FTest3, aTrain3,pTrain3,rTrain3,FTrain3, SVMStruct3, NewClassTest3] = train_test_v2(group,last,data3,labels3,kernel3);
    end
    aTest3
    pTest3
    rTest3
    FTest3
    aTrain3
    pTrain3
    rTrain3
    FTrain3
    
elseif groupNum==3
    %Brightness stats
    for k=1:length(BdataS)
        b(k,:) = BdataS{k};
    end
    %Zero Crossing Rate stats
    for k=1:length(ZCdataS)
        zc(k,:) = ZCdataS{k};
    end
    
    %First class
    %data = [TrainData(:,1:126),b,zc];
    data = [TrainData(:,1:14),TrainData(:,29:42),TrainData(:,113:126),b,zc];
    labels = D(:,2);
    kernel = 'polynomial';
    %kernel = 'no';
    
    if strcmp(version,'v1')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v1(numSongs,data,labels,kernel);
    elseif strcmp(version,'v2')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v2(group,last,data,labels,kernel);
    end
    aTest
    pTest
    rTest
    FTest
    aTrain
    pTrain
    rTrain
    FTrain
    
    %Second class
    %data2 = [TrainData(:,15:28),TrainData(:,43:56),TrainData(:,70:126)];
    data2 = [TrainData(:,1:14),TrainData(:,29:42),TrainData(:,57:84),TrainData(:,113:126)];
    labels2 = D(:,3);
    kernel2 = 'polynomial';
    %kernel2 = 'polynomial';
    
    if strcmp(version,'v1')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v1(numSongs,data2,labels2,kernel2);
    elseif strcmp(version,'v2')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v2(group,last,data2,labels2,kernel2);
    end
    aTest2
    pTest2
    rTest2
    FTest2
    aTrain2
    pTrain2
    rTrain2
    FTrain2
    
elseif groupNum==4
    %Brightness stats
    for k=1:length(BdataS)
        b(k,:) = BdataS{k};
    end
    %Zero Crossing Rate stats
    for k=1:length(ZCdataS)
        zc(k,:) = ZCdataS{k};
    end
    
    %First class  
    %data = [TrainData(:,1:14),TrainData(:,29:42),TrainData(:,57:84),TrainData(:,113:126),zc];
    data = zc;
    labels = D(:,2);
    kernel = 'quadratic';
    %kernel = 'quadratic';
    
    if strcmp(version,'v1')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v1(numSongs,data,labels,kernel);
    elseif strcmp(version,'v2')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v2(group,last,data,labels,kernel);
    end
    aTest
    pTest
    rTest
    FTest
    aTrain
    pTrain
    rTrain
    FTrain
    
    %Second class
    %data2 = [TrainData(:,1:14),TrainData(:,29:42),TrainData(:,57:70),TrainData(:,113:126),zc];
    data2 = [TrainData(:,1:14),TrainData(:,29:42),TrainData(:,57:70),b,zc];
    labels2 = D(:,3);
    kernel2 = 'no';
    %kernel2 = 'no';
    
    if strcmp(version,'v1')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v1(numSongs,data2,labels2,kernel2);
    elseif strcmp(version,'v2')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v2(group,last,data2,labels2,kernel2);
    end
    aTest2
    pTest2
    rTest2
    FTest2
    aTrain2
    pTrain2
    rTrain2
    FTrain2
    
else
    %Brightness stats
    for k=1:length(BdataS)
        b(k,:) = BdataS{k};
    end
    %Zero Crossing Rate stats
    for k=1:length(ZCdataS)
        zc(k,:) = ZCdataS{k};
    end
    
    %First class
    data = [TrainData(:,57:70),TrainData(:,113:126),zc];
    %data = [TrainData(:,15:28),TrainData(:,43:56),TrainData(:,71:84)];
    labels = D(:,2);
    kernel = 'polynomial';
    %kernel = 'polynomial';
    
    if strcmp(version,'v1')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v1(numSongs,data,labels,kernel);
    elseif strcmp(version,'v2')
        [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v2(group,last,data,labels,kernel);
    end
    aTest
    pTest
    rTest
    FTest
    aTrain
    pTrain
    rTrain
    FTrain
    
    %Second class
    data2 = [TrainData(:,43:56),TrainData(:,113:126),zc];
    %data2 = [TrainData(:,1:14),TrainData(:,29:42),TrainData(:,71:126)];
    labels2 = D(:,3);
    kernel2 = 'polynomial';
    %kernel2 = 'polynomial';
    
    if strcmp(version,'v1')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v1(numSongs,data2,labels2,kernel2);
    elseif strcmp(version,'v2')
        [aTest2,pTest2,rTest2,FTest2, aTrain2,pTrain2,rTrain2,FTrain2, SVMStruct2, NewClassTest2] = train_test_v2(group,last,data2,labels2,kernel2);
    end
    aTest2
    pTest2
    rTest2
    FTest2
    aTrain2
    pTrain2
    rTrain2
    FTrain2
    
end

if groupNum==1
    save TrainData1.mat TrainData D NewClassTest SVMStruct years
elseif groupNum==2
    save TrainData2.mat TrainData D NewClassTest NewClassTest2 NewClassTest3 SVMStruct SVMStruct2 SVMStruct3 years
elseif groupNum==3
    save TrainData3.mat TrainData D NewClassTest NewClassTest2 SVMStruct SVMStruct2 years
elseif groupNum==4
    save TrainData4.mat TrainData D NewClassTest NewClassTest2 SVMStruct SVMStruct2 years
elseif groupNum==5
    save TrainData5.mat TrainData D NewClassTest NewClassTest2 SVMStruct SVMStruct2 years
end

end

%SVM Train
function SVMStruct = train(training, labels, kernel)
    if nargin==2 || strcmp(kernel,'no')
        SVMStruct = svmtrain(training,labels);
    elseif nargin==3
        SVMStruct = svmtrain(training,labels,'kernel_function',kernel);
    end
end

%SVM Classify
function NewGroup = class(struct, sample)
    NewGroup = svmclassify(struct,sample);
end

%Accuracy
function [accuracy,precision,recall,F] = measures(good, new)

cnt=0;
tp=0;
tn=0;
fp=0;
fn=0;
for i=1:length(new)
    if strcmp(new(i),'yes')
        if strcmp(good(i),new(i))
            tp = tp+1; %true positive
            cnt = cnt+1;
        else
            fp = fp+1; %false positive
        end
    elseif strcmp(new(i),'no')
        if strcmp(good(i),new(i))
            tn = tn+1; %true negative
            cnt = cnt+1;
        else
            fn = fn+1; %false negative
        end
    end
end
%accuracy = cnt/length(new);
accuracy = (tp+tn)/(fp+fn+tp+tn);
precision = tp/(tp+fp);
recall = tp/(tp+fn);
F = 2*(precision*recall)/(precision+recall);

end

function [aTest,pTest,rTest,FTest, aTrain,pTrain,rTrain,FTrain, SVMStruct, NewClassTest] = train_test_v1(numSongs,data,labels,kernel)

    datatest = data(numSongs+1:size(data,1),:);
    datatraining = data(1:numSongs,:);
    goodTest = labels(numSongs+1:size(data,1));
    goodTraining = labels(1:numSongs);
    
    SVMStruct = train(datatraining,goodTraining,kernel);
    NewGroupTest = class(SVMStruct,datatest);
    NewGroupTrain = class(SVMStruct,datatraining);
    NewClassTest = [goodTest, NewGroupTest];
    
    [aTest,pTest,rTest,FTest] = measures(goodTest,NewGroupTest);
    [aTrain,pTrain,rTrain,FTrain] = measures(goodTraining,NewGroupTrain);

end

function [aTest,PrecTest,RecTest,FmTest, aTrain,PrecTrain,RecTrain,FmTrain, SVMStruct, NewClassTest] = train_test_v2(group,last,data,labels,kernel)

meanAccuracyTest = 0;
meanAccuracyTrain = 0;
meanPTest = 0;
meanPTrain = 0;
meanRTest = 0;
meanRTrain = 0;
meanFTest = 0;
meanFTrain = 0;
cont = 1;
for k=1:floor(size(data,1)/group)
    datatest{k} = data(cont:cont-1+group,:);
    origD = data;
    origD(cont:cont-1+group,:) = [];
    datatraining{k} = origD;
    goodTest{k} = labels(cont:cont-1+group);
    origL = labels;
    origL(cont:cont-1+group,:) = [];
    goodTraining{k} = origL;
    
    SVMStruct{k} = train(datatraining{k},goodTraining{k},kernel);
    NewGroupTest{k} = class(SVMStruct{k},datatest{k});
    NewGroupTrain{k} = class(SVMStruct{k},datatraining{k});
    NewClassTest{k} = [goodTest{k}, NewGroupTest{k}];
    cont = cont + group;
    
    [accTest(k),pTest(k),rTest(k),FTest(k)] = measures(goodTest{k},NewGroupTest{k});
    [accTrain(k),pTrain(k),rTrain(k),FTrain(k)] = measures(goodTraining{k},NewGroupTrain{k});
    meanAccuracyTest = meanAccuracyTest + accTest(k);
    meanAccuracyTrain = meanAccuracyTrain + accTrain(k);
    meanPTest = meanPTest + pTest(k);
    meanPTrain = meanPTrain + pTrain(k);
    meanRTest = meanRTest + rTest(k);
    meanRTrain = meanRTrain + rTrain(k);
    meanFTest = meanFTest + FTest(k);
    meanFTrain = meanFTrain + FTrain(k);
end
if last ~= 0
    k=k+1;
    datatest{k} = data(cont:cont+last-1,:);
    origD = data;
    origD(cont:cont+last-1,:) = [];
    datatraining{k} = origD;
    goodTest{k} = labels(cont:cont+last-1);
    origL = labels;
    origL(cont:cont+last-1,:) = [];
    goodTraining{k} = origL;
    
    SVMStruct{k} = train(datatraining{k},goodTraining{k},kernel);
    NewGroupTest{k} = class(SVMStruct{k},datatest{k});
    NewGroupTrain{k} = class(SVMStruct{k},datatraining{k});
    NewClassTest{k} = [goodTest{k}, NewGroupTest{k}];
    
    [accTest(k),pTest(k),rTest(k),FTest(k)] = measures(goodTest{k},NewGroupTest{k});
    [accTrain(k),pTrain(k),rTrain(k),FTrain(k)] = measures(goodTraining{k},NewGroupTrain{k});
    meanAccuracyTest = meanAccuracyTest + accTest(k);
    meanAccuracyTrain = meanAccuracyTrain + accTrain(k);
    meanPTest = meanPTest + pTest(k);
    meanPTrain = meanPTrain + pTrain(k);
    meanRTest = meanRTest + rTest(k);
    meanRTrain = meanRTrain + rTrain(k);
    meanFTest = meanFTest + FTest(k);
    meanFTrain = meanFTrain + FTrain(k);
end

aTest = meanAccuracyTest/k;
aTrain = meanAccuracyTrain/k;
PrecTest = meanPTest/k;
PrecTrain = meanPTrain/k;
RecTest = meanRTest/k;
RecTrain = meanRTrain/k;
FmTest = meanFTest/k;
FmTrain = meanFTrain/k;

end