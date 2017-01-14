function rec = PASreadrecord(path)

if length(path)<4
    error('unable to determine format: %s',path);
end

if strcmp(path(end-3:end),'.txt')
    rec=PASreadrectxt(path);
else
    %%modified by M. Seeland
     rec=VOCreadrecxml(path);
% %     rec = xml_read(path);
%     % rename fields
%     [rec.objects] = rec.object;
%     rec = rmfield(rec, 'object');
%     old_fields = {'name', 'bndbox'};
%     new_fields = {'class', 'bbox'};
%     for i=1:numel(old_fields)
%         [rec.objects.(new_fields{i})] = rec.objects.(old_fields{i});
%         rec.objects = rmfield(rec.objects, old_fields{i});
%     end
%     for i=1:numel(rec.objects)
%         rec.objects(i).bbox = ...
%             [rec.objects(i).bbox.xmin 
%             rec.objects(i).bbox.ymin 
%             rec.objects(i).bbox.xmax 
%             rec.objects(i).bbox.ymax];
%     end
%     
end
