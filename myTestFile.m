tic;
close all
clear all
clc;
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
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');

data_dir = 'C:/Users/fi_student/PASCAL_data/VOCdevkit/'
dataset ='VOC2007'
results_dir ='C:/Users/fi_student/results/200'
try
    rmdir(results_dir, 's');
end
%fast variant
[models,M] = esvm_demo_train_voc_class_fast('car', data_dir, dataset, results_dir)
%full variant
%[models,M] = esvm_script_train_voc_class('bus', data_dir, dataset, results_dir);
global Myresults;
global fpr;
figure(6);
plot(fpr, Myresults.recall);
xlabel('fpr');
ylabel('tpr');
executionTime= toc;
fprintf('%d', executionTime);


