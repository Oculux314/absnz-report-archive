function strippedData = StripColumns(dataset, col)
%% StripColumns()
% Inputs    dataset: parent table
%           col: extra column to keep
%
% Action    Deletes all columns except:
%             - Qualification_HighestAttainment_5Groups_
%             - School_SchoolGender
%             - [col]
%             - Students__Values_
%           and rearranges them into this order.
%           Additionally converts numeric values into char cells.
%
% Return    strippedData: dataset table with columns deleted

% Convert numeric to char if necessary
C = dataset.(col);
if (~iscell(C))
    C = num2cell(C);
    C = cellfun(@num2str, C, 'UniformOutput', false);
end

% Populate output
strippedData = table;
strippedData.Qualification_HighestAttainment_5Groups_ = dataset.Qualification_HighestAttainment_5Groups_;
strippedData.School_SchoolGender = dataset.School_SchoolGender;
strippedData.(col) = C;
strippedData.Students__Values_ = dataset.Students__Values_;


end