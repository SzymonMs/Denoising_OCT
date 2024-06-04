%   Szymon Murawski 2024 - oprogramowanie do porównywania skutecznoœci
%   segmentacji siatków oka
%   ludzkiego na B-skanach OCT.
clear all; clc;

grandTrue = 'grand_true';
SegmentationResults = 'segmentation_results';
ext         =  {'*.mat'};
grandTrueFiles   =  [];
SegmentationResultsFiles = [];
QualityCheckPath = 'quality_check';

avgILMdiff = [];
avgIPLINLdiff = [];
avgINLOPLdiff = [];
avgISOSdiff = [];
avgRPEdiff = [];
Names = {};

for i = 1 : length(ext)
    grandTrueFiles = cat(1,grandTrueFiles, dir(fullfile(grandTrue,ext{i})));
    SegmentationResultsFiles = cat(1,SegmentationResultsFiles, dir(fullfile(SegmentationResults,ext{i})));
end
for k = 1:length(grandTrueFiles)
  baseFileNameGrandTrue = grandTrueFiles(k).name;
  fullFileNameGrandTrue = fullfile(grandTrue,baseFileNameGrandTrue);
  
  baseFileNameSegmentationResults = SegmentationResultsFiles(k).name;
  fullFileNameSegmentationResults = fullfile(SegmentationResults,baseFileNameSegmentationResults);
  if length(baseFileNameGrandTrue) > 3 && length(baseFileNameSegmentationResults) > 3 
      
  FileGrandTrue = load(fullFileNameGrandTrue);
  FileSegmentationResult = load(fullFileNameSegmentationResults);
  
  %OCENA
  ILMdiff = abs(FileGrandTrue.data.ILM -FileSegmentationResult.OCTLayers.ILM);
  avgILMdiff(k) = mean(ILMdiff);
  IPLINLdiff = abs(FileGrandTrue.data.IPL_INL -FileSegmentationResult.OCTLayers.IPLINL);
  avgIPLINLdiff(k) = mean(IPLINLdiff);
  INLOPLdiff= abs(FileGrandTrue.data.INL_OPL -FileSegmentationResult.OCTLayers.INLOPL);
  avgINLOPLdiff(k) = mean(INLOPLdiff);
 % ISOSdiff = abs(FileGrandTrue.data.IS_OSJ -FileSegmentationResult.OCTLayers.ISOS);
 % avgISOSdiff(k) = mean(ISOSdiff);
  RPEdiff = abs(FileGrandTrue.data.OB_RPE -FileSegmentationResult.OCTLayers.RPE);
  avgRPEdiff(k) = mean(RPEdiff);
  Names{end+1} = grandTrueFiles(k).name;

  end
end
Names = Names';
avgILMdiff = avgILMdiff';
avgIPLINLdiff = avgIPLINLdiff';
avgINLOPLdiff = avgINLOPLdiff';
%avgISOSdiff = avgISOSdiff';
avgRPEdiff = avgRPEdiff';
T= table(Names,avgILMdiff,avgIPLINLdiff,avgINLOPLdiff,avgRPEdiff);
writetable(T,strcat(QualityCheckPath,'/data.csv'));