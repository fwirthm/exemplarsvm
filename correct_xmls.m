%% reset
close all;
clear all;
clc;


%% correct intendations
% inputDir = 'C:\Datasets\FI2015\annotations';
% outputDir = 'C:\Datasets\FI2015\annotationsCopy';
inputDir = 'C:\Datasets\FI2015\annotationsCopy1';
outputDir = 'C:\Datasets\FI2015\annotationsCopy2';
if ~exist(outputDir,'dir')
    mkdir(outputDir);
end

files = transpose(dir(fullfile(inputDir,'*.xml')));
for file = files%(1:1)
    filename = file.name;
    file = strcat(inputDir,'\',filename);
    fid = fopen(file);
    struct = textscan(fid,'%s','delimiter',sprintf('\n'));
    fclose(fid);
    struct = struct{1,1};
    outstring = '';
    
    depth = 0;
    pattern_openAndClose = regexptranslate('wildcard', '<*>*>');
    pattern_open =  '<\w*>';
    pattern_close = '<\/\w*>';
    lineID = 1;
    str = '';
    for line=transpose(struct)
        if (size(regexp(line{1,1}, pattern_openAndClose, 'match'),1))>0
            %% in this case there is an open and and close tag so the depth stays how it was
            %fprintf([str sprintf('line: %d',lineID) line{1,1} '\n']);
            if length(strfind(line{1,1},'filename'))>0
                xmlFilename = (line{1,1});
            end
            outstring = [outstring str line{1,1} '\n'];
        elseif (size(regexp(line{1,1}, pattern_open, 'match'),1))>0
            %fprintf([str sprintf('line: %d',lineID) line{1,1} '\n']);
            if length(strfind(line{1,1},'filename'))>0
                xmlFilename = (line{1,1});
            end
            outstring = [outstring str line{1,1} '\n'];
            depth = depth+1;
        elseif (size(regexp(line{1,1}, pattern_close, 'match'),1))>0
            depth = depth-1;
            str = '';
            for d=1:1:depth

                str = [str '\t'];
            end
            %fprintf([str sprintf('line: %d',lineID) line{1,1} '\n']);
            if length(strfind(line{1,1},'filename'))>0
                xmlFilename = (line{1,1});
            end
            outstring = [outstring str line{1,1} '\n'];
            
        end
        str = '';
        for d=1:1:depth
            str = [str '\t'];
        end
        
        lineID = lineID +1;
%         outstring = [outstring line{1,1} '\n'];
    end
    
    xmlFilename = strrep(xmlFilename, '<filename>', '');
    xmlFilename = strrep(xmlFilename, '.jpeg</filename>', '');
    xmlFilename = [xmlFilename '.xml'];
    
    %%write to xml
    file = strcat(outputDir,'\',xmlFilename);
    fid = fopen(file, 'w');
    fprintf(fid, outstring);
    fclose(fid);
    
    
end

