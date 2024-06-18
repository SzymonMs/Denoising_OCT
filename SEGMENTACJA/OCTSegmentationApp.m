%   Szymon Murawski 2024 - oprogramowanie do segmentacji warstw siatkówki oka
%   ludzkiego na B-skanach OCT.
%   {{Caserel}}
%   Copyright (C) {{2013}}  {{Pangyu Teng}}


clear all; clc;

D = ['data'];
R = ['result_to_images\'];

for kkk = 1:size(D,1)
directory = 'data';
ImagesAfterSegmentation = 'after_segmentation';

files = dir(directory);
isSubdir = [files.isdir] & ~ismember({files.name}, {'.', '..'});
subdirs = strings(sum(isSubdir), 1);
idx = 1;
for i = 1:length(files)
    if isSubdir(i)
        subdirs(idx) = fullfile(directory, files(i).name);
        idx = idx + 1;
    end
end

ext         =  {'*.jpeg','*.png','*.bmp','*.tif','*tiff'};
AVGTimes = zeros(1,size(subdirs,1));
for xxx = 1:size(subdirs,1)
myDir = subdirs(xxx);
SegmentationResults = strcat(R(kkk),subdirs(xxx));
if ~exist(SegmentationResults, 'dir')
    mkdir(SegmentationResults);
end
myFiles   =  [];
names = ["ILM","ISOS","RPE","INLOPL","NFLGCL","IPLINL","OPLONL"];
for i = 1 : length(ext)
    myFiles = cat(1,myFiles, dir(fullfile(myDir,ext{i})));
end
Times = zeros(1,length(myFiles));
Names = {};

for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);
  if length(baseFileName) > 3
   try
        img = imread(fullFileName) ;
        if size(img, 3) == 3
            img = img(:,:,1);
        end
        img = double(img);

        tic;
        [retinalLayers, params] = getRetinalLayers(img);
        endtime = toc;
        
%         filename = strcat(ImagesAfterSegmentation,'/',baseFileName,'_afterSegmentation.png');
%         saveas(gcf, filename);
        OCTLayers = struct(names(1),[],names(2),[],names(3),[],names(4),[],names(5),[],names(6),[],names(7),[]);
        for j = 1:size(retinalLayers,2)
            xx = [];
            for i = 1:size(retinalLayers(j).pathY,2)-1
                if retinalLayers(j).pathY(i) ~= retinalLayers(j).pathY(i+1)
                    xx = [xx,retinalLayers(j).pathX(i)];
                end
            end
            xx = [xx(1:end-1)];
            OCTLayers.(names{j}) = xx;
        end
        filename = [strcat(SegmentationResults,'/',baseFileName,'.mat')];
        save(filename, 'OCTLayers');
        
        Times(k) = endtime;
        Names{end+1} = myFiles(k).name;
        catch ME
            disp(ME)
        end
  end
end
Names = Names';
Times = Times';
AVGTimes(xxx) = mean(Times);
T= table(Times);
writetable(T,strcat(SegmentationResults,'/data.csv'));
end
AVGTimes = AVGTimes';
T2= table(AVGTimes);
writetable(T2,strcat(R(kkk),'data.csv'));
end