%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%This script reads data-set spreadsheet with file names, their number of 
%weeks in Hot 100's first position and their perceptual classification in 
%defined music characteristics

%M.mat saves 5 matrices with all data of the five 5-years-groups which
%conform all data-set

%Author: Aleu Pons
%Date: 24 May 2017

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

filename1 = 'Data-set perceptual analysis - British pop (1962-1966).csv';
filename2 = 'Data-set perceptual analysis - Disco & Punk (1975-1979).csv';
filename3 = 'Data-set perceptual analysis - Hip hop (1989-1993).csv';
filename4 = 'Data-set perceptual analysis - Boy-Girl bands & Pop starlets (1997-2001).csv';
filename5 = 'Data-set perceptual analysis - Trap (2012-2016).csv';

fileID1 = fopen(filename1);
fileID2 = fopen(filename2);
fileID3 = fopen(filename3);
fileID4 = fopen(filename4);
fileID5 = fopen(filename5);

M1 = textscan(fileID1,'%s %s %s %s','Delimiter',';');
M2 = textscan(fileID2,'%s %s %s %s %s','Delimiter',';');
M3 = textscan(fileID3,'%s %s %s %s','Delimiter',';');
M4 = textscan(fileID4,'%s %s %s %s','Delimiter',';');
M5 = textscan(fileID5,'%s %s %s %s','Delimiter',';');

fclose(fileID1);
fclose(fileID2);
fclose(fileID3);
fclose(fileID4);
fclose(fileID5);

save M.mat M1 M2 M3 M4 M5