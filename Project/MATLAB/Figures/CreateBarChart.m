function [] = CreateBarChart(dir, data, iVar, xCat)
%% CreateBarChart()
% Inputs    dir: directory to save figures in
%           data: data to populate bar chart (3D array)
%                 i) within groups: school gender
%                 j) groups: [iVar]
%                 k) stacked: highest qualification
%                 values) percentage of students that achieved each level
%           iVar: independent variable
%           xCat: (x-categories), the range of values for the independent
%                 variable
%
% Action    Creates a stacked bar chart of the provided data and exports
%           both it and the data to a specified directory.
%
% Return    none

%% Bar

isOverview = strcmp(iVar,'School Type');        % Check if overview handling required
xCat = reordercats(categorical(xCat), xCat);    % Ensure xCat is categorical

[fig,bars] = plotBarStackGroups(data,xCat);     % Plugin script: see log 16 Feb

if (isOverview)
    % Widen bars
    set(gca().Children(1),'BarWidth', 0.75);
    set(gca().Children(end),'BarWidth', 0.75);
    % Align
    set(gca,'XTick', [0.83,2.17]);    % Emperically chosen
end

grid on;


%% Labelling

% Axes
xlabel(iVar, 'FontSize', 12, 'FontWeight', 'bold');
ylabel('Percentage of Students (%)', 'FontSize', 12, 'FontWeight', 'bold');
ylim([0 100]);
xlim([0 (length(xCat)+1)*1.25]);
xtl = get(gca, 'XTickLabel');
set(gca, 'XTickLabel', xtl, 'FontSize', 12);

% Title
if (isOverview)
    titleName = 'Highest Qualification by School Type';
else
    titleName = ['Highest Qualification by School Type and ', iVar, ''];
end
ti = title(titleName, 'FontSize', 18, 'FontWeight', 'bold');
pos = get(ti, 'pos');
set(ti, 'pos', pos+[0 2 0]);


%% Legend

qual = {'No Qualification', 'NCEA Level 1', 'NCEA Level 2', 'NCEA Level 3', 'University Entrance'};
qual = qual(5:-1:1);                % Decision to invert: see log 15 Mar
gend = {'Co-Ed '; 'Single-Sex '};   % Note semicolon

lgdLabels = transpose(append(convertCharsToStrings(gend), convertCharsToStrings(qual)));    % Essentially matrix multiplication with text
legend(lgdLabels);

% h = get(gca,'Children')
% set(gca,'Children',[h(25:-1:1)])


%% Colours

% Theme
colourCo = [240, 37, 56];       % #f02538
colourSS = [ 33,144,190];       % #2190be
gradient = linspace(0,255,5);   % Blender

% Colour bars (lowest to highest)
for k = 1:5
    bars(1,k).FaceColor = uint8((colourCo + gradient(k))/2);    % Co-ed
    bars(2,k).FaceColor = uint8((colourSS + gradient(k))/2);    % Single sex
end

% originBar = 2;              % Bar to have base colour
% gradRatio = 0.75;           % Colour multiplier for each higher bar
% for k = 1:5
%     bars(1,k).FaceColor = uint8(colourCo * gradRatio^(k-originBar));    % Co-ed
%     bars(2,k).FaceColor = uint8(colourSS * gradRatio^(k-originBar));    % Single sex
% end


%% Exporting

pause(0.5);   % Pause 500 ms to ensure figure fully loaded (increase if needed)

ExportTable(dir,iVar,data,xCat);    % Formatting here
ExportFigure(dir,iVar,fig);

end