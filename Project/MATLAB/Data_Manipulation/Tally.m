function [tally, order] = Tally(coEd, singleSex, col)
%% Tally()
% Inputs    coEd: co-ed preprocessed dataset table
%           singleSex: single sex preprocessed dataset table
%           col: column to sort data by (CHAR TYPE ONLY)
%
% Action    manipulates the preprocessed data so that it is ready for plotting
%
% Return    tally: processed data as a single 3D array, ready to be plotted
%                  i) groups: [col]
%                  j) within groups: school gender
%                  k) stacked: highest achievement level
%                  values) percentage of students that achieved each level
%           order: a 1D char cell array that contains the ordering of group
%                  names for [col]

%% Data Setup

data = {coEd, singleSex}; % Length is 2 - hardcoded in

for j = 1:2
    % Removing irrelevent columns
    data{j} = StripColumns(data{j}, col);
end


%% n Values
% Number of students

fprintf('n(%s, co-ed): %i\n', col, sum(data{1}.Students__Values_));  % Co-ed
fprintf('n(%s, single sex): %i\n', col, sum(data{2}.Students__Values_));  % Single sex


%% Subset by Col

% Individual arrays:    {1} names, {2} subsets
[coEdSubsets{2}, coEdSubsets{1}] = AllSubsets(data{1}, col);            % Co-ed
[singleSexSubsets{2}, singleSexSubsets{1}] = AllSubsets(data{2}, col);  % Single sex

% United array:         {1} names, {2} co-ed, {3} single sex
subsets = cell(3,1);
subsets{1} = union(coEdSubsets{1}, singleSexSubsets{1});    % Names
subsets{2} = PairUp(subsets{1}, coEdSubsets);               % Co-ed
subsets{3} = PairUp(subsets{1}, singleSexSubsets);          % Single sex


%% Subset by Qualification

iLen = length(subsets{1});
kNames = {'No Qualification', 'NCEA Level 1', 'NCEA Level 2', 'NCEA Level 3', 'University Entrance'};
kOrder = 5:-1:1;    % Decision to invert: see log 15 Mar
                    % UE (base) --> No Qual (top)

nTally = zeros(iLen, 2, 5); % i, j, k
tally = nTally;             % Output as rates not counts

for j = 1:2
    for i = 1:iLen
        % Split each 'subsets' element into 5 qualification groups
        [qualSubsets, names] = AllSubsets(subsets{j+1}{i},'Qualification_HighestAttainment_5Groups_');
        qualSubsets = PairUp(kNames, {names,qualSubsets});  % Sort --> kNames
        
        % Arrange into 3D output array
        for k = 1:5
            pureSubset = qualSubsets{kOrder(k)};    % Only contains one type of value
            if (size(pureSubset,1))
                % If not empty
                nTally(i,j,k) = sum(pureSubset.Students__Values_);
            else
                % If empty
                nTally(i,j,k) = 0;
            end
        end
        
        % Normalise into percentages
        tot = sum(nTally(i,j,:));        % Total # students per bar
        for k = 1:5
            tally(i,j,k) = nTally(i,j,k) / tot * 100;
        end
    end
end

% Debugging: uncomment to view counts (scroll out)
% tally = nTally;

order = subsets{1};

end