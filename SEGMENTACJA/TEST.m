load('segmentation_results\Skan_nr_16.tiff_Segment.mat');
names = ["ILM","ISOS","RPE","INLOPL","NFLGCL","IPLINL","OPLONL"];
s = struct(names(1),[],names(2),[],names(3),[],names(4),[],names(5),[],names(6),[],names(7),[]);
for j = 1:size(retinalLayers,2)
    xx = []
    for i = 1:size(retinalLayers(j).pathY,2)-1
        if retinalLayers(j).pathY(i) ~= retinalLayers(j).pathY(i+1)
           xx = [xx,retinalLayers(j).pathX(i)];
        end
    end
    xx = [xx(1:end-1)]
    s.(names{j}) = xx;
end