clear all; clc;

grandTruedir = 'grand_true';
segmentationResultdir = 'segmentation_results\data';
QualityCheckPath = 'quality_check\';
files1 = dir(grandTruedir);
isSubdir1 = [files1.isdir] & ~ismember({files1.name}, {'.', '..'});
subdirs1 = strings(sum(isSubdir1), 1);
idx = 1;
for i = 1:length(files1)
    if isSubdir1(i)
        subdirs1(idx) = fullfile(grandTruedir, files1(i).name);
        idx = idx + 1;
    end
end
files2 = dir(segmentationResultdir);
isSubdir2 = [files2.isdir] & ~ismember({files2.name}, {'.', '..'});
subdirs2 = strings(sum(isSubdir2), 1);
idx = 1;
for i = 1:length(files2)
    if isSubdir2(i)
        subdirs2(idx) = fullfile(segmentationResultdir, files2(i).name);
        idx = idx + 1;
    end
end
AVGILMdiff = [];
AVGIPLINLdiff = [];
AVGINLOPLdiff = [];
AVGISOSdiff = [];
AVGRPEdiff = [];
ext         =  {'*.mat'};
for xxx = 1:size(subdirs1,1)
QualityCheck = strcat(QualityCheckPath,subdirs1(xxx));
if ~exist(QualityCheck, 'dir')
    mkdir(QualityCheck);
end
grandTrueFiles   =  [];
SegmentationResultsFiles = [];
avgILMdiff = [];
avgIPLINLdiff = [];
avgINLOPLdiff = [];
avgISOSdiff = [];
avgRPEdiff = [];
Names = {};
names = ["ILM","ISOS","RPE","INLOPL","NFLGCL","IPLINL","OPLONL"];
for i = 1 : length(ext)
    grandTrueFiles = cat(1,grandTrueFiles, dir(fullfile(subdirs1(xxx),ext{i})));
end
for i = 1 : length(ext)
    SegmentationResultsFiles = cat(1,SegmentationResultsFiles, dir(fullfile(subdirs2(xxx),ext{i})));
end

for k = 1:length(grandTrueFiles)
  baseFileNameGrandTrue = grandTrueFiles(k).name;
  fullFileNameGrandTrue = fullfile(subdirs1(xxx),baseFileNameGrandTrue);
  
  baseFileNameSegmentationResults = SegmentationResultsFiles(k).name;
  fullFileNameSegmentationResults = fullfile(subdirs2(xxx),baseFileNameSegmentationResults);
  if length(baseFileNameGrandTrue) > 3 && length(baseFileNameSegmentationResults) > 3 
      
  FileGrandTrue = load(fullFileNameGrandTrue);
  FileSegmentationResult = load(fullFileNameSegmentationResults);
  
  %OCENA
  if size(FileGrandTrue.data.ILM,2) == size(FileSegmentationResult.OCTLayers.ILM,2)
    ILMdiff = abs(FileGrandTrue.data.ILM -FileSegmentationResult.OCTLayers.ILM);
    avgILMdiff = [avgILMdiff,mean(ILMdiff)];
  end
  if size(FileGrandTrue.data.IPL_INL,2) == size(FileSegmentationResult.OCTLayers.IPLINL,2)
    IPLINLdiff = abs(FileGrandTrue.data.IPL_INL -FileSegmentationResult.OCTLayers.IPLINL);
    avgIPLINLdiff = [avgIPLINLdiff,mean(IPLINLdiff)];
  end
  if size(FileGrandTrue.data.INL_OPL,2) == size(FileSegmentationResult.OCTLayers.INLOPL,2)
    INLOPLdiff= abs(FileGrandTrue.data.INL_OPL -FileSegmentationResult.OCTLayers.INLOPL);
    avgINLOPLdiff = [avgINLOPLdiff,mean(INLOPLdiff)];
  end
%   if size(FileGrandTrue.data.IS_OSJ,2) == size(FileSegmentationResult.OCTLayers.ISOS,2)
%     ISOSdiff = abs(FileGrandTrue.data.IS_OSJ -FileSegmentationResult.OCTLayers.ISOS);
%     avgISOSdiff = [avgISOSdiff,mean(ISOSdiff)];
%   end
  if size(FileGrandTrue.data.OB_RPE,2) == size(FileSegmentationResult.OCTLayers.RPE,2)
    RPEdiff = abs(FileGrandTrue.data.OB_RPE -FileSegmentationResult.OCTLayers.RPE);
    avgRPEdiff = [avgRPEdiff,mean(RPEdiff)];
    Names{end+1} = grandTrueFiles(k).name;
  end

  end
end
Names = Names';
avgILMdiff = avgILMdiff';
avgIPLINLdiff = avgIPLINLdiff';
avgINLOPLdiff = avgINLOPLdiff';
avgISOSdiff = avgISOSdiff';
avgRPEdiff = avgRPEdiff';
T= table(Names,avgILMdiff,avgIPLINLdiff,avgINLOPLdiff,avgRPEdiff);
writetable(T,strcat(QualityCheck,'/data.csv'));
AVGILMdiff(xxx) = mean(avgILMdiff);
AVGIPLINLdiff(xxx) = mean(avgIPLINLdiff);
AVGINLOPLdiff(xxx) = mean(avgINLOPLdiff);
% AVGISOSdiff(xxx) = mean(avgISOSdiff);
AVGRPEdiff(xxx) = mean(avgRPEdiff);
end
AVGILMdiff = AVGILMdiff';
AVGIPLINLdiff = AVGIPLINLdiff';
AVGINLOPLdiff = AVGINLOPLdiff';
% AVGISOSdiff = AVGISOSdiff';
AVGRPEdiff = AVGRPEdiff';
T2= table(AVGILMdiff,AVGIPLINLdiff,AVGINLOPLdiff,AVGRPEdiff);
writetable(T2,strcat(QualityCheckPath,'data.csv'));