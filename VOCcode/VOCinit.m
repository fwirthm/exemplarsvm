function VOCopts = VOCinit(VOCopts)

% initialize main challenge paths

global seperation;

VOCopts.annopath=[VOCopts.datadir VOCopts.dataset '/annotationsCopy2/%s.xml'];
% VOCopts.imgpath=[VOCopts.datadir VOCopts.dataset '/JPEGImages/%s'];
VOCopts.imgpath=[VOCopts.datadir VOCopts.dataset '/imagesCopy/%s.jpg'];

if seperation ~= 0
    VOCopts.imgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/' seperation '/%s.txt'];
    VOCopts.clsimgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/' seperation '/%s_%s.txt'];
else
    VOCopts.imgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/%s.txt'];
    VOCopts.clsimgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/%s_%s.txt'];
end
VOCopts.clsrespath=[VOCopts.resdir 'Main/%s_cls_' VOCopts.testset '_%s.txt'];
VOCopts.detrespath=[VOCopts.resdir 'Main/%s_det_' VOCopts.testset '_%s.txt'];


% initialize segmentation task paths

VOCopts.seg.clsimgpath=[VOCopts.datadir VOCopts.dataset '/SegmentationClass/%s.png'];
VOCopts.seg.instimgpath=[VOCopts.datadir VOCopts.dataset '/SegmentationObject/%s.png'];

VOCopts.seg.imgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/Segmentation/%s.txt'];

VOCopts.seg.clsresdir=[VOCopts.resdir 'Segmentation/%s_%s_cls'];
VOCopts.seg.instresdir=[VOCopts.resdir 'Segmentation/%s_%s_inst'];
VOCopts.seg.clsrespath=[VOCopts.seg.clsresdir '/%s.png'];
VOCopts.seg.instrespath=[VOCopts.seg.instresdir '/%s.png'];

% initialize layout task paths

VOCopts.layout.imgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/Layout/%s.txt'];
VOCopts.layout.respath=[VOCopts.resdir 'Layout/%s_layout_' VOCopts.testset '.xml'];

% initialize action task paths

VOCopts.action.imgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/Action/%s.txt'];
VOCopts.action.clsimgsetpath=[VOCopts.datadir VOCopts.dataset '/ImageSets/Action/%s_%s.txt'];
VOCopts.action.respath=[VOCopts.resdir 'Action/%s_action_' VOCopts.testset '_%s.txt'];

% initialize the VOC challenge options

% classes

% VOCopts.classes={...
%     'aeroplane'
%     'bicycle'
%     'bird'
%     'boat'
%     'bottle'
%     'bus'
%     'car'
%     'cat'
%     'chair'
%     'cow'
%     'diningtable'
%     'dog'
%     'horse'
%     'motorbike'
%     'person'
%     'pottedplant'
%     'sheep'
%     'sofa'
%     'train'
%     'tvmonitor'};

VOCopts.classes={...
    'flower'
    'leaf'};

VOCopts.nclasses=length(VOCopts.classes);	

% poses

VOCopts.poses={...
    'Unspecified'
    'Left'
    'Right'
    'Frontal'
    'Rear'
    'top'
    'side'
    'left'
    'frontal'
    'unspecified'
    'rear'
    'right'};

VOCopts.nposes=length(VOCopts.poses);

% layout parts

VOCopts.parts={...
    'head'
    'hand'
    'foot'};    

VOCopts.nparts=length(VOCopts.parts);

VOCopts.maxparts=[1 2 2];   % max of each of above parts

% actions

VOCopts.actions={...    
    'phoning'
    'playinginstrument'
    'reading'
    'ridingbike'
    'ridinghorse'
    'running'
    'takingphoto'
    'usingcomputer'
    'walking'};

VOCopts.nactions=length(VOCopts.actions);

% overlap threshold

VOCopts.minoverlap=0.5;

% annotation cache for evaluation

VOCopts.annocachepath=[VOCopts.localdir '%s_anno.mat'];

% options for example implementations

VOCopts.exfdpath=[VOCopts.localdir '%s_fd.mat'];
