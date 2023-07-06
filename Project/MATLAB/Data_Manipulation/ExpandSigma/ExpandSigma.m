%% ExpandSigma.m (UNUSED)
% This was an initial script to patch the sigma issue but it turned out to
% be intractible.
% Author: nate.williamson.nz@gmail.com

% Original Description:
% Helper script to expand rows by sigma value in raw data.
% (Sigma values indicate how many students with the same data are
% represented/aggregated by each row.)

%% Start

% Directory
dataIn = 'Data\Raw.csv';
dataOut = 'Data\Expanded.csv';

% Root directory contains final report
root = mfilename('fullpath');
root = [root(1:end-12),'\..'];
cd(root);
root = cd;

% Add subfolders to path
addpath(genpath('MATLAB'));

% Import
comTable = readtable(dataIn);    % Compressed table


%% Algorithm

% Duplicating headers (except sigma)
expTable = comTable(1:0,1:26);

% Preallocating for speed
expLen = sum(comTable.Students__Values_);
expTable{expLen,1}=0;

% Populate
for i=1:size(comTable,1)
    % Repeat rows
    sigma = comTable{i, 27};
    repRows = repmat(comTable(i, 1:26), [sigma, 1]);

    % Append
    expTable = [expTable; repRows];

    if (~mod(i,1000))
        disp(i);
    end
end


%% Export

writetable(expTable, dataOut);