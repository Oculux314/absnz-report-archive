function pairedRow = PairUp(order, dictionary)
%% PairUp()
% Inputs    order: a 1D char cell array of header names
%           dictionary: a 2xn cell array
%                       {1} header names
%                       {2} data
%
% Action    Arranges dictionary data by pairing the corresponding
%           dictionary name with the ordered list of names.
%           If name exists in order but not in dictionary, use an empty
%           array as a placeholder.
%           If name exists in dictionary but not in order, it will be dropped.
%
% Return    pairedRow: final, ordered row of data (without names) as a 1D
%                      cell array

pairedRow = cell(length(order), 1);

% For each order name
for i = 1:length(order)
    % Find index of dictionary name
    index = find(strcmp(dictionary{1}, order{i}));
    
    if isempty(index)
        % Use placeholder
        pairedRow{i} = [];
    else
        % Pair
        pairedRow{i} = dictionary{2}{index};
    end
end

end