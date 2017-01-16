close all
clear all
clc;
tic;
global p;
global TestMat;
global FEAT;
global W2;
global IM;
global Sbin;
global Hog_dim1;
global Hog_dim2;
global PARA;
global BB;
global X;
global Mat;
global Cell;
global MyCell;
global i__;
global gt__;
global BB__;
global grid__;
global grid__1;
global allfiles__;
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

global seperation;

% data_dir = 'C:/Users/fi_student/PASCAL_data/VOCdevkit/'
% dataset ='VOC2007'
% results_dir ='C:/Users/fi_student/results/200'
% seperation = 'Main';

seperation = '/notSeperated'
% seperation = 'seperatedBySpecies/Centaurea_scabiosa'
cls = 'leaf'
data_dir = 'C:/Datasets/'
dataset ='FI2015'
results_dir ='C:/Users/fi_student/results_FloraIncognita/200'
Inp = [data_dir, dataset, '/', 'ImageSets', seperation, '/', cls, '_test.txt'];
Outp = [data_dir, dataset, '/', 'ImageSets', seperation, '/', 'test.txt'];
makeTestTxt(Inp, Outp);


try
    rmdir(results_dir, 's');
end
%fast variant
[models,M] = esvm_demo_train_voc_class_fast(cls, data_dir, dataset, results_dir)
% [models,M] = esvm_demo_train_voc_class_fast('bus', data_dir, dataset, results_dir)
%full variant
%[models,M] = esvm_script_train_voc_class('bus', data_dir, dataset, results_dir);
% global Myresults;
% global fpr;
%figure(6);
%plot(fpr, Myresults.recall);
% xlabel('fpr');
% ylabel('tpr');
executionTime= toc;
fprintf('%d', executionTime);


