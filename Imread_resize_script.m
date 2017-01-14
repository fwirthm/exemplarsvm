%% reset
close all;
clear all;
clc;
tic

%% parameters
inputDir_XML = 'C:\Datasets\FI2015\annotationsCopy\';
inputDir_JPEG = 'C:\Datasets\FI2015\images\';
outputDir_XML = 'C:\Datasets\FI2015\annotationsCopy1\';
outputDir_JPEG = 'C:\Datasets\FI2015\imagesCopy\';

if ~exist(outputDir_XML,'dir')
    mkdir(outputDir_XML);
end

if ~exist(outputDir_JPEG,'dir')
    mkdir(outputDir_JPEG);
end

%% images
fprintf('start with images\n')
files = transpose(dir(fullfile(inputDir_JPEG,'*.jpeg')));


for file = files%(1:20)
    %load all images with max edge size 500px and get the scaling factor
    ImPath = [inputDir_JPEG, file.name];
    [Im, scale] = Imread_resize(ImPath, 500);
    imwrite(Im, [outputDir_JPEG, file.name]);
    
    XMLPath = [inputDir_XML, file.name];
    XMLPath = strrep(XMLPath,'.jpeg', '.xml');
    try
        XML = xmlread(XMLPath);
        xml = xml2struct(XML);
        
        
        info = imfinfo([outputDir_JPEG, file.name]);
        w = info.Width;
        h = info.Height;
        xml.annotation.size.width = w;
        xml.annotation.size.height = h;
        
        box = xml.annotation.object.bndbox;
        xml.annotation.object.bndbox.xmin = round(str2double(box.xmin.Text)/scale);
        xml.annotation.object.bndbox.xmax = round(str2double(box.xmax.Text)/scale);
        xml.annotation.object.bndbox.ymin = round(str2double(box.ymin.Text)/scale);
        xml.annotation.object.bndbox.ymax = round(str2double(box.ymax.Text)/scale);

        XMLOutputPath = [outputDir_XML, file.name];
        XMLOutputPath = strrep(XMLOutputPath,'.jpeg', '.xml');
        struct2xml( xml, XMLOutputPath );
    catch
    end
    
end