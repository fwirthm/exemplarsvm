function makeImageSets(files, inputDir, outputDir, annoTypes)

    if ~exist(outputDir,'dir')
      mkdir(outputDir);
    end
    
    annoTypeCounters_pos = cell(1,size(annoTypes,2));
    annoTypeCounters_pos(:) = {0};
    annoTypeCounters_neg = annoTypeCounters_pos;
    annoTypeCounters_struct = {annoTypeCounters_pos, annoTypeCounters_neg};
    
    Fid_test = {};
    Fid_train = {};
    Fid_trainval = {};
    Fid_val = {};

    for annoType = annoTypes
        %% open all needed otput files and append the filehandlers to the corresponding struct
        annoType=annoType{1};

        fid_test = fopen( fullfile(outputDir,strcat(annoType,'_test.txt')), 'a' );
        fid_train = fopen( fullfile(outputDir,strcat(annoType,'_train.txt')), 'a' );
        fid_trainval = fopen( fullfile(outputDir,strcat(annoType,'_trainval.txt')), 'a' );
        fid_val = fopen( fullfile(outputDir,strcat(annoType,'_val.txt')), 'a' );

        Fid_test{end+1} = fid_test;
        Fid_train{end+1} = fid_train;
        Fid_trainval{end+1} = fid_trainval;
        Fid_val{end+1} = fid_val;
    end


    for file = files
        %% iterate over all xml-files in the folder
        XML = xmlread(strcat(inputDir,'\',file.name));
        XML = xml2struct(XML);
        fileName = XML.annotation.filename.Text;
        [filePath, fileName, fileExt] = fileparts(fileName);

        if size(XML.annotation.object,2)==1;
            %% if there is only one annotation, we have to pack the object
            %%in a cell to match the needed dimesnsions for the following code
            XML.annotation.object = {XML.annotation.object};
        end

        Contains = cell(1,size(annoTypes,2));
        Contains(:) = {-1};
        for objectId = 1:1:size(XML.annotation.object,2)
            %% iterate over all annotation objects in this image and construct a 
            %struct which contains for each class if this image is a positive
            %%or a negative example
            annoType = XML.annotation.object{1,objectId}.name.Text;
            if ~any(strcmp(annoTypes, annoType))
                %% There is a new annotation which is not in the list
                error(strcat('new class ',' "', annoType,'"',' detected -- please add it to the annoTypes struct\n'));
            else
                %% Which of the existing annotations is it?
                annoId = find(strcmp(annoTypes, annoType));
            end
            Contains{1,annoId}=1;
        end

        for annoId = 1:1:size(annoTypes,2)
            %% iterate over all annotations
            annoType = annoTypes{1,annoId};

            % is it a positive or a negative sample?
            which = Contains{1,annoId};
            % choose the correct counter variable - this ensures that the split
            % is equal for positives and negatives
            if which>0
                AnnoTypeCountersId = 1;
            else
                AnnoTypeCountersId = 2;
            end

            which_str = sprintf('%d', which);

            if (mod(annoTypeCounters_struct{AnnoTypeCountersId}{annoId},11)==0)
                %% append each 11th element of the sama class to testset
                fprintf(Fid_test{annoId}, [fileName, '  ', which_str, ' \n']);
            elseif (mod(annoTypeCounters_struct{AnnoTypeCountersId}{annoId},11)<=5)  
                %% append 5 out of 11 files to trainset and trainval
                fprintf(Fid_train{annoId}, [fileName, '  ', which_str, ' \n']);
                fprintf(Fid_trainval{annoId}, [fileName, '  ', which_str, ' \n']);
            else
                %% append 5 out of 11 files to val and trainval
                fprintf(Fid_val{annoId}, [fileName, '  ', which_str, ' \n']);
                fprintf(Fid_trainval{annoId}, [fileName, '  ', which_str, ' \n']);
            end
            annoTypeCounters_struct{AnnoTypeCountersId}{annoId}=annoTypeCounters_struct{AnnoTypeCountersId}{annoId}+1;

        end

    end

    for annoTypeId = 1:1:size(annoTypes,2)
        %% close all output files
        fclose(Fid_test{annoTypeId});
        fclose(Fid_train{annoTypeId});
        fclose(Fid_trainval{annoTypeId});
        fclose(Fid_val{annoTypeId});
    end
    