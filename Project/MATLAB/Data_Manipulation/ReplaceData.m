function dataset = ReplaceData(dataset, col, oldValue, newValue)
%% ReplaceData()
% Inputs    dataset: parent table
%           col: column to replace values in
%           oldValue: value to be replaced (accepts char or double type only)
%           newValue: value to replace with (must be same type as oldValue)
%
% Action    replaces all values in a particular column in the provided
%           dataset with a new value
%
% Return    dataset: the table with values replaced

if (ischar(oldValue))
    % Char type
    dataset.(col)(strcmp(dataset.(col), oldValue)) = {newValue};
elseif (isnumeric(oldValue))
    % Double type
    dataset.(col)(dataset.(col)==oldValue) = newValue;
else
    % Not char or double
    error('Error in ReplaceData(): keyword type not recognised.');
    return;
end

end