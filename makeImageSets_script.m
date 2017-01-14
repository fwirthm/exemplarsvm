%% reset
close all;
clear all;
clc;
tic

%% parameters
inputDir = 'C:\Datasets\FI2015\annotationsCopy';
annoTypes = {'flower', 'leaf'};
databaseDir = 'C:\Datasets\images.sqlite';
speciesListDir = 'C:\Datasets\FI2015\species.csv';

%% not seperated
fprintf('start with: "not seperated"\n')
outputDir = 'C:\Datasets\FI2015\ImageSets\notSeperated';
files = transpose(dir(fullfile(inputDir,'*.xml')));

makeImageSets(files, inputDir, outputDir, annoTypes);

%% seperated by species
fprintf('start with: "seperated by species"\n')

fileID = fopen(speciesListDir);
speciesStruct = textscan(fileID,'%d;%s %s');
fclose(fileID);
speciesList = cell(1,size(speciesStruct{1,2},1));

for i=1:1:size(speciesStruct{1,2},1)
    speciesList{1,i}=[speciesStruct{1,2}{i,1}, ' ', speciesStruct{1,3}{i,1}];
end

%switch to datebase tool
cd C:\Users\fi_student\repos\matlab-sqlite3-driver
database = sqlite3.open(databaseDir);
for speciesId = 1:1:size(speciesList,2)
    %% iterate over all species
    fprintf(['    species:',speciesList{speciesId},' --species ' sprintf('%d of %d', speciesId, size(speciesList,2)) '\n']);
    outputDir = strcat('C:\Datasets\FI2015\ImageSets\seperatedBySpecies\',strrep(speciesList{speciesId},' ','_'));
    
    %select the ids of all images which belong to this species
    %imageIds = SELECT image_id FROM tags WHERE type_id = 1 AND value_id =speciesId
    %select the annotations of the corresponding images
    %SELECT * FROM annotations WHERE image_id IN imageIds
    %all in one sql statement
    files = sqlite3.execute(database,...
    strcat('SELECT * FROM annotations WHERE image_id IN (SELECT image_id FROM tags WHERE type_id = 1 AND value_id =',sprintf( '%d)',speciesId)));

    if size(files,2)>0
        cd C:\Users\fi_student\Documents\exemplarsvm
        files = RenameField(files, 'filepath', 'name');
        makeImageSets(files, inputDir, outputDir, annoTypes);
        cd C:\Users\fi_student\repos\matlab-sqlite3-driver
    end
    
end


%% seperated by Species and View
fprintf('start with: "seperated by species and view"\n')
outputDir = 'C:\Datasets\FI2015\ImageSets\seperatedBySpeciesAndView';
%%call function from above
%%Todo

%% return to this dir
cd C:\Users\fi_student\Documents\exemplarsvm
toc