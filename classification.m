function classification(param)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%classification('param')

%This function classify all data-set into the music characteristics
%selected and shows it in an evolution graphic. The configurations and
%features used are the same which gave the best train-test measures

%param: short name of the music characteristic ('choruses','keyboard',
%'orchestral','distorted','drummach','lowfreq','electronic','choruses90',
%'kickdrum' or 'hihats')

%Author: Aleu Pons
%Date: 7 June 2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('C:\Users\usuario\Documents\TFG\Timbre\TrainData1.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\B1.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\ZC1.mat');
TD1 = TrainData;
%SVMS1 = SVMStruct;
D1 = D;
y1 = years;
B1 = BdataS;
Z1 = ZCdataS;
for k=1:length(B1)
    b1(k,:) = B1{k};
end
for k=1:length(Z1)
    zc1(k,:) = Z1{k};
end

load('C:\Users\usuario\Documents\TFG\Timbre\TrainData2.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\B2.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\ZC2.mat');
TD2 = TrainData;
%SVMS21 = SVMStruct;
%SVMS22 = SVMStruct2;
%SVMS23 = SVMStruct3;
D2 = D;
y2 = years;
B2 = BdataS;
Z2 = ZCdataS;
for k=1:length(B2)
    b2(k,:) = B2{k};
end
for k=1:length(Z2)
    zc2(k,:) = Z2{k};
end

load('C:\Users\usuario\Documents\TFG\Timbre\TrainData3.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\B3.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\ZC3.mat');
TD3 = TrainData;
%SVMS31 = SVMStruct;
%SVMS32 = SVMStruct2;
D3 = D;
y3 = years;
B3 = BdataS;
Z3 = ZCdataS;
for k=1:length(B3)
    b3(k,:) = B3{k};
end
for k=1:length(Z3)
    zc3(k,:) = Z3{k};
end

load('C:\Users\usuario\Documents\TFG\Timbre\TrainData4.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\B4.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\ZC4.mat');
TD4 = TrainData;
%SVMS41 = SVMStruct;
%SVMS42 = SVMStruct2;
D4 = D;
y4 = years;
B4 = BdataS;
Z4 = ZCdataS;
for k=1:length(B4)
    b4(k,:) = B4{k};
end
for k=1:length(Z4)
    zc4(k,:) = Z4{k};
end

load('C:\Users\usuario\Documents\TFG\Timbre\TrainData5.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\B5.mat');
load('C:\Users\usuario\Documents\TFG\Timbre\ZC5.mat');
TD5 = TrainData;
%SVMS5 = SVMStruct;
D5 = D;
y5 = years;
B5 = BdataS;
Z5 = ZCdataS;
for k=1:length(B5)
    b5(k,:) = B5{k};
end
for k=1:length(Z5)
    zc5(k,:) = Z5{k};
end

if strcmp(param,'choruses')
    
    data1 = [TD1(:,15:28),TD1(:,43:56),TD1(:,71:98),TD1(:,113:126),b1(:,1:4),zc1(:,1:4)];
    data2 = [TD2(:,15:28),TD2(:,43:56),TD2(:,71:98),TD2(:,113:126),b2(:,1:4),zc2(:,1:4)];
    data3 = [TD3(:,15:28),TD3(:,43:56),TD3(:,71:98),TD3(:,113:126),b3(:,1:4),zc3(:,1:4)];
    data4 = [TD4(:,15:28),TD4(:,43:56),TD4(:,71:98),TD4(:,113:126),b4(:,1:4),zc4(:,1:4)];
    data5 = [TD5(:,15:28),TD5(:,43:56),TD5(:,71:98),TD5(:,113:126),b5(:,1:4),zc5(:,1:4)];
    data = [data1;data2;data3;data4;data5];
    dataT = data1;
    labels = D1(:,2);
    kernel = 'polynomial';
    choruses = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],choruses,[y1,y2,y3,y4,y5],param);
    
elseif strcmp(param,'keyboard')
    
    data1 = [TD1(:,15:28),TD1(:,43:56),TD1(:,57:84),TD1(:,113:126),zc1(:,1:4)];
    data2 = [TD2(:,15:28),TD2(:,43:56),TD2(:,57:84),TD2(:,113:126),zc2(:,1:4)];
    data3 = [TD3(:,15:28),TD3(:,43:56),TD3(:,57:84),TD3(:,113:126),zc3(:,1:4)];
    data4 = [TD4(:,15:28),TD4(:,43:56),TD4(:,57:84),TD4(:,113:126),zc4(:,1:4)];
    data5 = [TD5(:,15:28),TD5(:,43:56),TD5(:,57:84),TD5(:,113:126),zc5(:,1:4)];
    data = [data1;data2;data3;data4;data5];
    dataT = data2;
    labels = D2(:,2);
    kernel = 'quadratic';
    keyboard = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],keyboard,[y1,y2,y3,y4,y5],param);

elseif strcmp(param,'orchestral')
    
    data1 = [TD1(:,15:28),TD1(:,43:84),TD1(:,113:126)];
    data2 = [TD2(:,15:28),TD2(:,43:84),TD2(:,113:126)];
    data3 = [TD3(:,15:28),TD3(:,43:84),TD3(:,113:126)];
    data4 = [TD4(:,15:28),TD4(:,43:84),TD4(:,113:126)];
    data5 = [TD5(:,15:28),TD5(:,43:84),TD5(:,113:126)];
    data = [data1;data2;data3;data4;data5];
    dataT = data2;
    labels = D2(:,3);
    kernel = 'quadratic';
    orchestral = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],orchestral,[y1,y2,y3,y4,y5],param);

elseif strcmp(param,'distorted')
    
    data1 = [TD1(:,1:14),TD1(:,29:42),TD1(:,113:126),b1];
    data2 = [TD2(:,1:14),TD2(:,29:42),TD2(:,113:126),b2];
    data3 = [TD3(:,1:14),TD3(:,29:42),TD3(:,113:126),b3];
    data4 = [TD4(:,1:14),TD4(:,29:42),TD4(:,113:126),b4];
    data5 = [TD5(:,1:14),TD5(:,29:42),TD5(:,113:126),b5];
    data = [data1;data2;data3;data4;data5];
    dataT = data2;
    labels = D2(:,4);
    kernel = 'polynomial';
    distorted = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],distorted,[y1,y2,y3,y4,y5],param);
    
elseif strcmp(param,'drummach')
    
    data1 = [TD1(:,1:14),TD1(:,29:42),TD1(:,113:126),b1,zc1];
    data2 = [TD2(:,1:14),TD2(:,29:42),TD2(:,113:126),b2,zc2];
    data3 = [TD3(:,1:14),TD3(:,29:42),TD3(:,113:126),b3,zc3];
    data4 = [TD4(:,1:14),TD4(:,29:42),TD4(:,113:126),b4,zc4];
    data5 = [TD5(:,1:14),TD5(:,29:42),TD5(:,113:126),b5,zc5];
    data = [data1;data2;data3;data4;data5];
    dataT = data3;
    labels = D3(:,2);
    kernel = 'polynomial';
    drummach = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],drummach,[y1,y2,y3,y4,y5],param);
    
elseif strcmp(param,'lowfreq')
    
   data1 = [TD1(:,1:14),TD1(:,29:42),TD1(:,57:84),TD1(:,113:126)];
    data2 = [TD2(:,1:14),TD2(:,29:42),TD2(:,57:84),TD2(:,113:126)];
    data3 = [TD3(:,1:14),TD3(:,29:42),TD3(:,57:84),TD3(:,113:126)];
    data4 = [TD4(:,1:14),TD4(:,29:42),TD4(:,57:84),TD4(:,113:126)];
    data5 = [TD5(:,1:14),TD5(:,29:42),TD5(:,57:84),TD5(:,113:126)];
    data = [data1;data2;data3;data4;data5];
    dataT = data3;
    labels = D3(:,3);
    kernel = 'polynomial';
    lowfreq = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],lowfreq,[y1,y2,y3,y4,y5],param);
    
elseif strcmp(param,'electronic')
    
    %data1 = [TD1(:,1:14),TD1(:,29:42),TD1(:,57:84),TD1(:,113:126)];
    %data2 = [TD2(:,1:14),TD2(:,29:42),TD2(:,57:84),TD2(:,113:126)];
    %data3 = [TD3(:,1:14),TD3(:,29:42),TD3(:,57:84),TD3(:,113:126)];
    %data4 = [TD4(:,1:14),TD4(:,29:42),TD4(:,57:84),TD4(:,113:126)];
    %data5 = [TD5(:,1:14),TD5(:,29:42),TD5(:,57:84),TD5(:,113:126)];
    data1 = zc1;
    data2 = zc2;
    data3 = zc3;
    data4 = zc4;
    data5 = zc5;
    data = [data1;data2;data3;data4;data5];
    dataT = data4;
    labels = D4(:,2);
    kernel = 'quadratic';
    electronic = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],electronic,[y1,y2,y3,y4,y5],param);
    
elseif strcmp(param,'choruses90')
    
    data1 = [TD1(:,1:14),TD1(:,29:42),TD1(:,57:70),b1,zc1];
    data2 = [TD2(:,1:14),TD2(:,29:42),TD2(:,57:70),b2,zc2];
    data3 = [TD3(:,1:14),TD3(:,29:42),TD3(:,57:70),b3,zc3];
    data4 = [TD4(:,1:14),TD4(:,29:42),TD4(:,57:70),b4,zc4];
    data5 = [TD5(:,1:14),TD5(:,29:42),TD5(:,57:70),b5,zc5];
    data = [data1;data2;data3;data4;data5];
    dataT = data4;
    labels = D4(:,3);
    kernel = 'no';
    choruses90 = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],choruses90,[y1,y2,y3,y4,y5],param);
    
elseif strcmp(param,'kickdrum')
    
    data1 = [TD1(:,57:70),TD1(:,113:126),zc1];
    data2 = [TD2(:,57:70),TD2(:,113:126),zc2];
    data3 = [TD3(:,57:70),TD3(:,113:126),zc3];
    data4 = [TD4(:,57:70),TD4(:,113:126),zc4];
    data5 = [TD5(:,57:70),TD5(:,113:126),zc5];
    data = [data1;data2;data3;data4;data5];
    dataT = data5;
    labels = D5(:,2);
    kernel = 'polynomial';
    kickdrum = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],kickdrum,[y1,y2,y3,y4,y5],param);
    
elseif strcmp(param,'hihats')
    
    data1 = [TD1(:,43:56),TD1(:,113:126),zc1];
    data2 = [TD2(:,43:56),TD2(:,113:126),zc2];
    data3 = [TD3(:,43:56),TD3(:,113:126),zc3];
    data4 = [TD4(:,43:56),TD4(:,113:126),zc4];
    data5 = [TD5(:,43:56),TD5(:,113:126),zc5];
    data = [data1;data2;data3;data4;data5];
    dataT = data5;
    labels = D5(:,3);
    kernel = 'polynomial';
    hihats = classify(dataT,data,labels,kernel);
    evolution([D1(:,size(D1,2))',D2(:,size(D2,2))',D3(:,size(D3,2))',D4(:,size(D4,2))',D5(:,size(D5,2))'],hihats,[y1,y2,y3,y4,y5],param);
    
end

end

function NewGroup = classify(dataT,data,labels,kernel)
    SVMStruct = train(dataT,labels,kernel);
    NewGroup = class(SVMStruct,data);
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

%graphic function
function evolution(weeks,music_char,years,param)
    
    %yes/no to 1/0
    for i=1:length(music_char)
        if strcmp(music_char(i),'yes')
            cnt(i)=1;
        else
            cnt(i)=0;
        end
    end

    %weeks: Weeks on Hot 100's 1st position
    
    aux = years(1);
    hist(1) = str2num(aux{1}); %list of the 25 years
    j=1;
    numSongsY(1:25) = 0; %number of songs of each year (5*5 years)
    for i=1:length(years)
        if strcmp(aux,years(i))
            numSongsY(j) = numSongsY(j)+1;
        else
            aux = years(i);
            j = j+1;
            hist(j) = str2num(aux{1});
            numSongsY(j) = numSongsY(j)+1;
        end
        y(i)=str2num(years{i}); %cell to number
        w(i)=str2num(weeks{i}); %cell to number
    end
    
    k=0;
    for i=1:length(numSongsY)
        weeksYear(i) = sum(w(1+k:numSongsY(i)+k));
        k=k+numSongsY(i);
    end
        
    k=0;
    for i=1:length(numSongsY)
        ponderation(1+k:numSongsY(i)+k) = cnt(1+k:numSongsY(i)+k).*w(1+k:numSongsY(i)+k)/weeksYear(i)*100;
        k=k+numSongsY(i);
    end
        
    k=0;
    for i=1:length(numSongsY)
        charYear(i) = sum(ponderation(1+k:numSongsY(i)+k));
        k=k+numSongsY(i);
    end
    %figure
    
    colors=[1 0 0; 0 1 0; 0 0 1; 0 0 0; 1 0.5 0; 0 1 1; 0.4 0.1 0.6; 1 0 1; 0.8 0.3 0.2; 0.5 0.8 0.5];
    
    if strcmp(param,'choruses')
        h=plot(hist,charYear,'*','DisplayName','choruses','Color',colors(1,:));
    elseif strcmp(param,'keyboard')
        h=plot(hist,charYear,'*','DisplayName','keyboard','Color',colors(2,:));
    elseif strcmp(param,'orchestral')
        h=plot(hist,charYear,'*','DisplayName','orchestral','Color',colors(3,:));
    elseif strcmp(param,'distorted')
        h=plot(hist,charYear,'*','DisplayName','distorted','Color',colors(4,:));
    elseif strcmp(param,'drummach')
        h=plot(hist,charYear,'*','DisplayName','drummach','Color',colors(5,:));
    elseif strcmp(param,'lowfreq')
        h=plot(hist,charYear,'*','DisplayName','lowfreq','Color',colors(6,:));
    elseif strcmp(param,'electronic')
        h=plot(hist,charYear,'*','DisplayName','electronic','Color',colors(7,:));
    elseif strcmp(param,'choruses90')
        h=plot(hist,charYear,'*','DisplayName','choruses90','Color',colors(8,:));
    elseif strcmp(param,'kickdrum')
        h=plot(hist,charYear,'*','DisplayName','kickdrum','Color',colors(9,:));
    elseif strcmp(param,'hihats')
        h=plot(hist,charYear,'*','DisplayName','hihats','Color',colors(10,:));
    end
    
    axis([1960 2016 0 105])
    title('Timbre evolution')
    xlabel('Years')
    ylabel('% of music characteristics'' presence in Billboard Hot 100''s first position')
    legend('-DynamicLegend','Location','northwest')
    set(h,'linewidth',2)
    %set(h,'xlim',[1962 1966])
    %xlim(h,[1 5])
    hold all
    
end