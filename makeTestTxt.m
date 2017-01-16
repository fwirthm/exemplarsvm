function makeTestTxt(InputFile, OutputFile)
    fileID_I = fopen(InputFile, 'r');
    fileID_O = fopen(OutputFile, 'w');
    C = textscan(fileID_I,'%s %d');
    fclose(fileID_I);
    
    data = char(C{1,1}(1,1));
    fprintf(fileID_O, '%s', data);
    fprintf(fileID_O, '\n');
    fileID_O = fopen(OutputFile, 'a');
    
    for lineId = 2:1:size(C{1,1},1)
        data = char(C{1,1}(lineId,1));
        fprintf(fileID_O, '%s', data);
        fprintf(fileID_O, '\n');
    end
    fclose(fileID_O);
end
    