%   Szymon Murawski 2024 - oprogramowanie do segmentacji warstw siatkówki oka
%   ludzkiego na B-skanach OCT.
%   {{Caserel}}
%   Copyright (C) {{2013}}  {{Pangyu Teng}}

clear all; clc;

OCTtoSegmentationPath = 'data';
SegmentationResults = 'segmentation_results';
ImagesAfterSegmentation = 'after_segmentation';
ext         =  {'*.jpeg','*.png','*.bmp','*.tif'};
myFiles   =  [];
for i = 1 : length(ext)
    myFiles = cat(1,myFiles, dir(fullfile(OCTtoSegmentationPath,ext{i})));
end

Times = zeros(1,length(myFiles));
Names = {};

for k = 1:length(myFiles)
  baseFileName = myFiles(k).name;
  fullFileName = fullfile(OCTtoSegmentationPath, baseFileName);
  if length(baseFileName) > 3
        img = imread(fullFileName) ;
        if size(img, 3) == 3
            img = img(:,:,1);
        end
        img = double(img);
        szImg = size(img);
        yrange = 1:szImg(1);
        xrange = 1:szImg(2);
        
        tic;
        [retinalLayers, params] = getRetinalLayers(img);
        endtime = toc;
        
        params.yrange = yrange;
        params.xrange = xrange;
        imageLayer(i).imagePath = fullFileName;
        imageLayer(i).retinalLayers = retinalLayers;    
        imageLayer(i).params = params;
        
        filename = strcat(ImagesAfterSegmentation,'/',baseFileName,'_afterSegmentation.png');
        saveas(gcf, filename);
        
        filename = [imageLayer(1).imagePath strcat(SegmentationResults,'/',baseFileName,'_Segment.mat')];
        save(filename, 'imageLayer');
        
        Times(k) = endtime;
        Names{end+1} = myFiles(k).name;
  end
end
Names = Names';
Times = Times';
T= table(Names,Times);
writetable(T,strcat(ImagesAfterSegmentation,'/data.txt'));
