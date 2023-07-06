function ExportTable(dir, filename, data, xCat)
%% ExportTable()
% Inputs    dir: directory to save table in
%           filename: filename of saved table (exclude .csv)
%           data: the data for the table to be saved
%                 i) within groups: school gender
%                 j) groups: [iVar]
%                 k) stacked: highest qualification
%                 values) percentage of students that achieved each level
%           xCat: (x-categories), the range of values for the independent
%                 variable
%
% Action    formats and saves specified data to directory as .csv file
%
% Return    none

%% Data

data = data/100;            % Percentages
data = data(:, :, 5:-1:1);  % Decision to invert: see log 15 Mar

qual = {'No Qualification', 'NCEA Level 1', 'NCEA Level 2', 'NCEA Level 3', 'University Entrance'};

% Table headers
table = {filename, 'Highest Qualification', 'Percentage of Students', '';
    '', '', 'Co-Ed', 'Single-Sex'};

for j = 1:length(xCat)
    % Column 1
    table{5*j-2, 1} = xCat(j);
    for k = 1:5
        % Columns 2 - 4
        table(5*j+k-3, 2:4) = {qual{k},data(j,1,k),data(j,2,k)};
    end
end


%% Overview Handling

if (strcmp(filename,'School Gender'))
    % Condense data
    table(3:7, 4) = table(8:12, 4);
    % Remove excess rows/columns
    table(8:12, :) = [];
    table(:, 1) = [];
end


%% Exporting

filePath = [dir,'\',filename,'.csv'];

writecell(table, filePath);
% writematrix(table, filePath);
% writetable(table, filePath);

end