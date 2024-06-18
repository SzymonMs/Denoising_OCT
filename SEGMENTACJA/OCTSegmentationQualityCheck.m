% % clear all; clc;
% % 
% grandTruedir = 'adnet_grand_true\';
% segmentationResultdir = 'adnet_result\adnet\';
% QualityCheckPath = 'quality_check\';
% files1 = dir(grandTruedir);
% isSubdir1 = [files1.isdir] & ~ismember({files1.name}, {'.', '..'});
% subdirs1 = strings(sum(isSubdir1), 1);
% idx = 1;
% for i = 1:length(files1)
%     if isSubdir1(i)
%         subdirs1(idx) = fullfile(grandTruedir, files1(i).name);
%         idx = idx + 1;
%     end
% end
% files2 = dir(segmentationResultdir);
% isSubdir2 = [files2.isdir] & ~ismember({files2.name}, {'.', '..'});
% subdirs2 = strings(sum(isSubdir2), 1);
% idx = 1;
% for i = 1:length(files2)
%     if isSubdir2(i)
%         subdirs2(idx) = fullfile(segmentationResultdir, files2(i).name);
%         idx = idx + 1;
%     end
% end
% AVGILMdiff = [];
% AVGIPLINLdiff = [];
% AVGINLOPLdiff = [];
% AVGISOSdiff = [];
% AVGRPEdiff = [];
% ext         =  {'*.mat'};
% for xxx = 1:size(subdirs1,1)
% QualityCheck = strcat(QualityCheckPath,subdirs1(xxx));
% if ~exist(QualityCheck, 'dir')
%     mkdir(QualityCheck);
% end
% grandTrueFiles   =  [];
% SegmentationResultsFiles = [];
% avgILMdiff = [];
% avgIPLINLdiff = [];
% avgINLOPLdiff = [];
% avgISOSdiff = [];
% avgRPEdiff = [];
% Names = {};
% names = ["ILM","ISOS","RPE","INLOPL","NFLGCL","IPLINL","OPLONL"];
% for i = 1 : length(ext)
%     grandTrueFiles = cat(1,grandTrueFiles, dir(fullfile(subdirs1(xxx),ext{i})));
% end
% for i = 1 : length(ext)
%     SegmentationResultsFiles = cat(1,SegmentationResultsFiles, dir(fullfile(subdirs2(xxx),ext{i})));
% end
% 
% for k = 1:length(grandTrueFiles)
%   baseFileNameGrandTrue = grandTrueFiles(k).name;
%   fullFileNameGrandTrue = fullfile(subdirs1(xxx),baseFileNameGrandTrue);
%   
%   baseFileNameSegmentationResults = SegmentationResultsFiles(k).name;
%   fullFileNameSegmentationResults = fullfile(subdirs2(xxx),baseFileNameSegmentationResults);
%   if length(baseFileNameGrandTrue) > 3 && length(baseFileNameSegmentationResults) > 3 
%       
%   FileGrandTrue = load(fullFileNameGrandTrue);
%   FileSegmentationResult = load(fullFileNameSegmentationResults);
%   
%   %OCENA
%   if size(FileGrandTrue.data.ILM,2) == size(FileSegmentationResult.OCTLayers.ILM,2)
%     ILMdiff = abs(FileGrandTrue.data.ILM -FileSegmentationResult.OCTLayers.ILM);
% %     avgILMdiff = [avgILMdiff,mean(ILMdiff)];
%     AVGILMdiff = [AVGILMdiff, mean(ILMdiff)];
%   end
%   if size(FileGrandTrue.data.IPL_INL,2) == size(FileSegmentationResult.OCTLayers.IPLINL,2)
%     IPLINLdiff = abs(FileGrandTrue.data.IPL_INL -FileSegmentationResult.OCTLayers.IPLINL);
% %     avgIPLINLdiff = [avgIPLINLdiff,mean(IPLINLdiff)];
%     AVGIPLINLdiff = [AVGIPLINLdiff,mean(IPLINLdiff)];
%   end
%   if size(FileGrandTrue.data.INL_OPL,2) == size(FileSegmentationResult.OCTLayers.INLOPL,2)
%     INLOPLdiff= abs(FileGrandTrue.data.INL_OPL -FileSegmentationResult.OCTLayers.INLOPL);
% %     avgINLOPLdiff = [avgINLOPLdiff,mean(INLOPLdiff)]
%     AVGINLOPLdiff = [AVGINLOPLdiff,mean(INLOPLdiff)];
%   end
%   if size(FileGrandTrue.data.IS_OSJ,2) == size(FileSegmentationResult.OCTLayers.ISOS,2)
%     ISOSdiff = abs(FileGrandTrue.data.IS_OSJ -FileSegmentationResult.OCTLayers.ISOS);
% %     avgISOSdiff = [avgISOSdiff,mean(ISOSdiff)];
%     AVGISOSdiff = [AVGISOSdiff,mean(ISOSdiff)];
%   end
%   if size(FileGrandTrue.data.OB_RPE,2) == size(FileSegmentationResult.OCTLayers.RPE,2)
%     RPEdiff = abs(FileGrandTrue.data.OB_RPE -FileSegmentationResult.OCTLayers.RPE);
% %     avgRPEdiff = [avgRPEdiff,mean(RPEdiff)];
%     AVGRPEdiff = [AVGRPEdiff,mean(RPEdiff)];
% 
%   end
% 
%   end
% end
% Names = Names';
% avgILMdiff = avgILMdiff';
% avgIPLINLdiff = avgIPLINLdiff';
% avgINLOPLdiff = avgINLOPLdiff';
% avgISOSdiff = avgISOSdiff';
% avgRPEdiff = avgRPEdiff';





% T= table(avgILMdiff);
% writetable(T,strcat(QualityCheck,'/ILM.csv'));
% T= table(avgIPLINLdiff);
% writetable(T,strcat(QualityCheck,'/IPLINL.csv'));
% T= table(avgINLOPLdiff);
% writetable(T,strcat(QualityCheck,'/INLOPL.csv'));
% T= table(avgISOSdiff);
% writetable(T,strcat(QualityCheck,'/ISOS.csv'));
% T= table(avgRPEdiff);
% writetable(T,strcat(QualityCheck,'/RPE.csv'));
% AVGILMdiff(xxx) = mean(avgILMdiff);
% AVGIPLINLdiff(xxx) = mean(avgIPLINLdiff);
% AVGINLOPLdiff(xxx) = mean(avgINLOPLdiff);
% AVGISOSdiff(xxx) = mean(avgISOSdiff);
% AVGRPEdiff(xxx) = mean(avgRPEdiff);
%  end
% AVGILMdiff = AVGILMdiff';
% AVGIPLINLdiff = AVGIPLINLdiff';
% AVGINLOPLdiff = AVGINLOPLdiff';
% AVGISOSdiff = AVGISOSdiff';
% AVGRPEdiff = AVGRPEdiff';

% AVGILMdiffx = [];
% AVGIPLINLdiffx = [];
% AVGINLOPLdiffx = [];
% AVGISOSdiffx = [];
% AVGRPEdiffx = [];
% 
% AVGILMdiffx(1) = mean(AVGILMdiff);
% AVGIPLINLdiffx(1) = mean(avgIPLINLdiff);
% AVGINLOPLdiffx(1) = mean(avgINLOPLdiff);
% AVGISOSdiffx(1) = mean(avgISOSdiff);
% AVGRPEdiffx(1) = mean(avgRPEdiff);
% T2= table(AVGILMdiffx,AVGIPLINLdiffx,AVGINLOPLdiffx,AVGISOSdiffx,AVGRPEdiffx);
% writetable(T2,strcat(QualityCheckPath,'data.csv'));


% minILM = min(AVGILMdiff)
% C2ILM = prctile(AVGILMdiff,25)
% C7ILM = prctile(AVGILMdiff,75)
% maxILM = max(AVGILMdiff)
% sILM = std(AVGILMdiff)
% 
% minIPLINL = min(AVGIPLINLdiff)
% C2IPLINL = prctile(AVGIPLINLdiff,25)
% C7IPLINL = prctile(AVGIPLINLdiff,75)
% maxIPLINL = max(AVGIPLINLdiff)
% sIPLINL = std(AVGIPLINLdiff)
% 
% minINLOPL = min(AVGINLOPLdiff)
% C2INLOPL = prctile(AVGINLOPLdiff,25)
% C7INLOPL = prctile(AVGINLOPLdiff,75)
% maxINLOPL = max(AVGINLOPLdiff)
% sINLOPL = std(AVGINLOPLdiff)
% 
% minISOS = min(AVGISOSdiff)
% C2ISOS = prctile(AVGISOSdiff,25)
% C7ISOS = prctile(AVGISOSdiff,75)
% maxISOS = max(AVGISOSdiff)
% sISOS = std(AVGISOSdiff)
% 
% minRPE = min(AVGRPEdiff)
% C2RPE = prctile(AVGRPEdiff,25)
% C7RPE = prctile(AVGRPEdiff,75)
% maxRPE = max(AVGRPEdiff)
% sRPE = std(AVGRPEdiff)
% 
% AVGILMdiff_adnet = AVGILMdiff;
% AVGIPLINLdiff_adnet= AVGIPLINLdiff;
% AVGINLOPLdiff_adnet= AVGINLOPLdiff;
% AVGISOSdiff_adnet= AVGISOSdiff;
% AVGRPEdiff_adnet= AVGRPEdiff;
ax = gca;
hold on
boxplot([AVGRPEdiff_BEZ_ODSZUMIANIA],'Labels',{{'BEZ'}}, 'Symbol',' ','Orientation','vertical','Position', 1)
boxplot([AVGRPEdiff_3_3avg],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 2)
boxplot([AVGRPEdiff_5_5avg],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 3)
boxplot([AVGRPEdiff_5_5avg],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 4)
boxplot([AVGRPEdiff_7_7avg],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 5)
boxplot([AVGRPEdiff_9_9avg],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 6)
boxplot([AVGRPEdiff_11_11avg],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 7)
boxplot([AVGRPEdiff_3med],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 8)
boxplot([AVGRPEdiff_5med],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 9)
boxplot([AVGRPEdiff_7med],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 10)
boxplot([AVGRPEdiff_9med],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 11)
boxplot([AVGRPEdiff_11med],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 12)
boxplot([AVGRPEdiff_dncnn],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 13)
boxplot([AVGRPEdiff_ffdnet],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 14)
boxplot([AVGRPEdiff_adnet],'Labels',{{'ADNET'}}, 'Symbol',' ','Orientation','vertical','Position', 15)

hold off
ax.XLim = [0.5, 16.5]; % Make sure that ax XLim covers both 
YLimCoeff = 1.1;
ax.YLim = [-0.01;15];
ax.XTick = [1, 2,3,4,5,6,7,8,9,10,11,12,13,14,15]; 
ax.XTickLabel = string(ax.XTick);
title('Warstwa RPE')
ylabel('B³¹d')

