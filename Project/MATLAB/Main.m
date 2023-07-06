%% Main.m
% Master script for the ABSNZ 2021 Boys Achievement Report project.
% Author: nate.williamson.nz@gmail.com

%% Start

tic;
clear; close all; clc;


%% Root

% Directory
dataPath = 'Data\Raw.csv';
figureDir = 'Figures';

% Root directory contains final report
root = mfilename('fullpath');
root = [root(1:end-5),'\..'];
cd(root);
root = cd;

% Add subfolders to path
addpath(genpath('MATLAB'));


%% Data Preprocessing

rawData = readtable(dataPath);                                      % Raw
prepData = rawData(rawData.Year_LeftSchool >= 2017, :);             % 2017 - 2021
[prepData, ~] = Subset(prepData, 'Student_StudentGender', 'Male');  % Research focuses on boys

% Renaming achievement level data groups
prepData = ReplaceData(prepData, 'Qualification_HighestAttainment_5Groups_', 'Below Level 1 Qualification', 'No Qualification');
prepData = ReplaceData(prepData, 'Qualification_HighestAttainment_5Groups_', 'Level 1 Qualification', 'NCEA Level 1');
prepData = ReplaceData(prepData, 'Qualification_HighestAttainment_5Groups_', 'Level 2 Qualification', 'NCEA Level 2');
prepData = ReplaceData(prepData, 'Qualification_HighestAttainment_5Groups_', 'Level 3 or above', 'NCEA Level 3');
% prepData = ReplaceData(prepData, 'Qualification_HighestAttainment_5Groups_', 'University Entrance', 'University Entrance');

% Renaming quintile data groups --> decile
prepData = ReplaceData(prepData, 'School_Quintile', 'Quintile 1', 'Decile 1 - 2');
prepData = ReplaceData(prepData, 'School_Quintile', 'Quintile 2', 'Decile 3 - 4');
prepData = ReplaceData(prepData, 'School_Quintile', 'Quintile 3', 'Decile 5 - 6');
prepData = ReplaceData(prepData, 'School_Quintile', 'Quintile 4', 'Decile 7 - 8');
prepData = ReplaceData(prepData, 'School_Quintile', 'Quintile 5', 'Decile 9 - 10');

% Renaming school gender data groups
prepData = ReplaceData(prepData, 'School_SchoolGender', 'Prim.Co-Ed, Sec.Girls', 'Single Sex-Girls');
prepData = ReplaceData(prepData, 'School_SchoolGender', 'Sen.Co-Ed, Jun.Boys', 'Co-Ed');
% prepData = ReplaceData(prepData, 'School_SchoolGender', 'Co-Ed', 'Co-Ed');
prepData = ReplaceData(prepData, 'School_SchoolGender', 'Single Sex-Girls', 'Single Sex');
prepData = ReplaceData(prepData, 'School_SchoolGender', 'Single Sex-Boys', 'Single Sex');

% Collapse school genders into single-sex and co-ed
[coEd, rest] = Subset(prepData, 'School_SchoolGender', 'Co-Ed');        % Co-Ed
[singleSex, rest] = Subset(rest, 'School_SchoolGender', 'Single Sex');  % Single sex
[unknown, rest] = Subset(rest, 'School_SchoolGender', 'Unknown');       % Unknown (excluded)

% Handling ethnicity duplicates (read data website notes)
[coEd, coEdEth] = Subset(coEd, 'Student_EthnicGroup', 'Total');
[singleSex, singleSexEth] = Subset(singleSex, 'Student_EthnicGroup', 'Total');


%% Graphs


% Overview: gender --> type: see log 27 Mar
[data,names] = Tally(coEd, singleSex, 'School_SchoolGender');
CreateBarChart(figureDir, data, 'School Type', names);

[data,names] = Tally(coEd, singleSex, 'Year_LeftSchool');
CreateBarChart(figureDir, data, 'Year', names);

[data,names] = Tally(coEd, singleSex, 'School_Quintile');
order = [1,2,3,4,5,6];  % Putting 'N/A' at the end
CreateBarChart(figureDir, data(order,:,:), 'Decile', names(order)); %

[data,names] = Tally(coEdEth, singleSexEth, 'Student_EthnicGroup');
order = [1,2,3,4,6,5];  % Putting 'other' at the end
CreateBarChart(figureDir, data(order,:,:), 'Ethnicity', names(order));


%% End

% clear; close all; clc;
toc;