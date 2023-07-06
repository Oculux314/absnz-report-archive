function [subset, antiSubset] = Subset(dataset, col, keyword)
%% Subset()
% Inputs    dataset: parent table
%           col: column to search for keyword in
%           keyword: value to filter by (accepts char or double type only)
%
% Action    separates a table into two arrays based on whether each row
%           contains the keyword in the specified column or not
%
% Return    subset: a table containing rows with the keyword
%           antiSubset: a table containing rows without the keyword

% Create boolean filter array
if (ischar(keyword))
    % Char type
    filter = strcmp(dataset.(col), keyword);
elseif (isnumeric(keyword))
    % Double type
    filter = dataset.(col)==keyword;
else
    % Not char or double
    error('Error in Subset(): keyword type not recognised.');
    return;
end

% Apply filter
subset = dataset(filter, :);
antiSubset = dataset(~filter, :);

end