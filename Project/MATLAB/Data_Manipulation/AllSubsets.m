function [subsets, subsetNames] = AllSubsets(dataset, col)
%% AllSubsets()
% Inputs    dataset: parent table
%           col: column to split data by
%
% Action    fully segregates a table into subsets based on the value of
%           the specified column in each row
%
% Return    subsets: a 1D cell array containing each subset table
%           subsetNames: a 1D cell array containing the name of each subset

%% Outputs

subsets = {};
subsetNames = {};

% Empty array handler
if (isempty(dataset))
    return;
end


%% Check type

% Assume all entries in the column have the same data type
keyword = dataset.(col)(1);

if (iscell(keyword))
    % Char type (in cell)
    isCell = 1;
elseif (isnumeric(keyword))
    % Double type
    isCell = 0;
else
    % Not char or double
    error('Error in ReplaceData(): keyword type not recognised.');
    return;
end


%% Loop

subsetIndex = 0;
currentKeyword = NaN;

% Loop until empty
while (size(dataset,1))
    
    % Find next keyword
    if (isCell)
        % Char
        keyword = dataset.(col){1};
    else
        % Double
        keyword = dataset.(col)(1);
    end
    
    % Update looping variables
    subsetIndex = subsetIndex + 1;
    currentKeyword = keyword;
    
    % Log keyword as subset name
    subsetNames{subsetIndex} = keyword;

    % Log subset and remove from loop
    [subsets{subsetIndex}, dataset] = Subset(dataset, col, keyword);
end

end