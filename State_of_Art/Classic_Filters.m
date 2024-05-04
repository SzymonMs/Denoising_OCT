clc;
clear;
myDir = 'data';
resultDirAverage = 'Average_Filter';
resultDirMedian = 'Median_Filter';
filePattern = fullfile(myDir);
% read images
ext         =  {'*.jpeg','*.png','*.bmp'};
myFiles   =  [];
for i = 1 : length(ext)
    myFiles = cat(1,myFiles, dir(fullfile(myDir,ext{i})));
end
n = 9;
m = 9;

PSNRs_Med = zeros(1,length(myFiles));
SSIMs_Med = zeros(1,length(myFiles));
Times_Med = zeros(1,length(myFiles));
PSNRs_Avg = zeros(1,length(myFiles));
SSIMs_Avg = zeros(1,length(myFiles));
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
        [PSNRCur_Avg, SSIMCur_Avg] = Cal_PSNRSSIM(im2uint8(I),im2uint8(denoisedI_avg),0,0);
        fprintf('%d. %s\n',k, baseFileName);
        denoisedName_avg = strcat(resultDirAverage,"\Avg_denoised_",baseFileName);
        denoisedName_med = strcat(resultDirMedian,"\Med_denoised_",baseFileName);
        imwrite(denoisedI_avg,denoisedName_avg);
        imwrite(denoisedI_med,denoisedName_med);
        PSNRs_Med(k) = PSNRCur_Med;
        SSIMs_Med(k) = SSIMCur_Med;
        Times_Med(k) = endtime_med;
        PSNRs_Avg(k) = PSNRCur_Avg;
        SSIMs_Avg(k) = SSIMCur_Avg;
        Times_Avg(k) = endtime_avg;
        Names{end+1} = myFiles(k).name;
      end
end
Names = Names';
PSNRs_Med = PSNRs_Med';
SSIMs_Med = SSIMs_Med';
Times_Med = Times_Med';
PSNRs_Avg = PSNRs_Avg';
SSIMs_Avg = SSIMs_Avg';
Times_Avg = Times_Avg';
T_Med= table(Names,PSNRs_Med,SSIMs_Med,Times_Med);
T_Avg= table(Names,PSNRs_Avg,SSIMs_Avg,Times_Avg);
writetable(T_Med,'Median_Filter/results_Med.txt');
writetable(T_Avg,'Average_Filter/results_Avg.txt');