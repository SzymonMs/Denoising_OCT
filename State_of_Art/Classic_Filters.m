clc;
clear;
directory = 'data';
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
AVGPSNRMED = zeros(1,size(subdirs,1));
AVGSSIMMED = zeros(1,size(subdirs,1));
AVGTimesMED = zeros(1,size(subdirs,1));
AVGPSNRAVG = zeros(1,size(subdirs,1));
AVGSSIMAVG = zeros(1,size(subdirs,1));
AVGTimesAVG = zeros(1,size(subdirs,1));
for xx = 1:size(subdirs,1)
myDir = subdirs(xx);
resultDirAverage = strcat('Average_Filter\',subdirs(xx));
if ~exist(resultDirAverage, 'dir')
    mkdir(resultDirAverage);
end
resultDirMedian = strcat('Median_Filter\',subdirs(xx));
if ~exist(resultDirMedian, 'dir')
    mkdir(resultDirMedian);
end
filePattern = fullfile(myDir);
ext         =  {'*.jpeg','*.png','*.bmp','*.tiff'};
myFiles   =  [];
for i = 1 : length(ext)
    myFiles = cat(1,myFiles, dir(fullfile(myDir,ext{i})));
end
n = 3;
m = 3;

PSNRs_Med = zeros(1,length(myFiles));
PSNRs_Med_before = zeros(1,length(myFiles));
SSIMs_Med = zeros(1,length(myFiles));
SSIMs_Med_before = zeros(1,length(myFiles));
Times_Med = zeros(1,length(myFiles));

PSNRs_Avg = zeros(1,length(myFiles));
PSNRs_Avg_before = zeros(1,length(myFiles));
SSIMs_Avg = zeros(1,length(myFiles));
SSIMs_Avg_before = zeros(1,length(myFiles));
Times_Avg = zeros(1,length(myFiles));
Names = {};
numberOfFiles = length(myFiles);
for k = 1:length(myFiles)
      baseFileName = myFiles(k).name;
      fullFileName = fullfile(myDir, baseFileName);
      if length(baseFileName) > 3
        I = imread(fullFileName) ;
        if size(I, 3) == 3
            I = rgb2gray(I);
        end

        C_avg = fspecial('average',[n m]);
        tic;
        denoisedI_avg = imfilter(I,C_avg);
        endtime_avg = toc;
        tic;
        denoisedI_med = medfilt2(I,[n m]);
        endtime_med = toc;
        
        [PSNRCur_Med, SSIMCur_Med] = Cal_PSNRSSIM(im2uint8(I),im2uint8(denoisedI_med),0,0);
        [PSNRCur_Med_before, SSIMCur_Med_before] = Cal_PSNRSSIM(im2uint8(I),im2uint8(I),0,0);
        [PSNRCur_Avg, SSIMCur_Avg] = Cal_PSNRSSIM(im2uint8(I),im2uint8(denoisedI_avg),0,0);
        [PSNRCur_Avg_before, SSIMCur_Avg_before] = Cal_PSNRSSIM(im2uint8(I),im2uint8(I),0,0);
        fprintf('%d. %s\n',k, baseFileName);
        denoisedName_avg = strcat(resultDirAverage,'\',baseFileName);
        denoisedName_med = strcat(resultDirMedian,"\",baseFileName);
        imwrite(denoisedI_avg,denoisedName_avg);
        imwrite(denoisedI_med,denoisedName_med);
        PSNRs_Med(k) = PSNRCur_Med;
        SSIMs_Med(k) = SSIMCur_Med;
        PSNRs_Med_before(k) = PSNRCur_Med_before;
        SSIMs_Med_before(k) = SSIMCur_Med_before;
        Times_Med(k) = endtime_med;
        PSNRs_Avg(k) = PSNRCur_Avg;
        SSIMs_Avg(k) = SSIMCur_Avg;
        PSNRs_Avg_before(k) = PSNRCur_Avg_before;
        SSIMs_Avg_before(k) = SSIMCur_Avg_before;
        Times_Avg(k) = endtime_avg;
        Names{end+1} = myFiles(k).name;
      end
end
Names = Names';
PSNRs_Med = PSNRs_Med';
SSIMs_Med = SSIMs_Med';
PSNRs_Med_before = PSNRs_Med_before';
SSIMs_Med_before = SSIMs_Med_before';
Times_Med = Times_Med';
PSNRs_Avg = PSNRs_Avg';
SSIMs_Avg = SSIMs_Avg';
PSNRs_Avg_before = PSNRs_Avg_before';
SSIMs_Avg_before = SSIMs_Avg_before';
Times_Avg = Times_Avg';
T_Med= table(Names,PSNRs_Med,PSNRs_Med_before,SSIMs_Med,SSIMs_Med_before,Times_Med);
T_Avg= table(Names,PSNRs_Avg,PSNRs_Avg_before,SSIMs_Avg,SSIMs_Avg_before,Times_Avg);
writetable(T_Med,strcat(resultDirMedian,'/results_Med.csv'));
writetable(T_Avg,strcat(resultDirAverage,'/results_Avg.csv'));
AVGPSNRMED(xx) = mean(PSNRs_Med);
AVGPSNRAVG(xx) = mean(PSNRs_Avg);
AVGSSIMMED(xx) = mean(SSIMs_Med);
AVGSSIMAVG(xx) = mean(SSIMs_Avg);
AVGTimesMED(xx) = mean(Times_Med);
AVGTimesAVG(xx) = mean(Times_Avg);
end
AVGPSNRMED=AVGPSNRMED';
AVGPSNRAVG=AVGPSNRAVG';
AVGSSIMMED=AVGSSIMMED';
AVGSSIMAVG=AVGSSIMAVG';
AVGTimesMED=AVGTimesMED';
AVGTimesAVG=AVGTimesAVG';
T_Med= table(AVGPSNRMED,AVGSSIMMED,AVGTimesMED);
T_Avg= table(AVGPSNRAVG,AVGSSIMAVG,AVGTimesAVG);
writetable(T_Med,'Median_Filter/Median.csv');
writetable(T_Avg,'Average_Filter/Average.csv');