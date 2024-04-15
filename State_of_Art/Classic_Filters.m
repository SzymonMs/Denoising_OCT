clc;
clear;
myDir = 'data';
resultDirAverage = 'Average_Filter';
resultDirMedian = 'Median_Filter';
filePattern = fullfile(myDir);
myFiles = dir(filePattern);
n = 9;
m = 9;
for k = 1:length(myFiles)
      baseFileName = myFiles(k).name;
      fullFileName = fullfile(myDir, baseFileName);
      if length(baseFileName) > 3
        I = imread(fullFileName) ;
        if size(I, 3) == 3
            I = rgb2gray(I);
        end
        C_avg = fspecial('average',[n m]);
        denoisedI_avg = imfilter(I,C_avg);
        denoisedI_med = medfilt2(I,[n m]);
        fprintf('%d. %s\n',k-2, baseFileName);
        denoisedName_avg = strcat(resultDirAverage,"\Avg_denoised_",baseFileName);
        denoisedName_med = strcat(resultDirMedian,"\Med_denoised_",baseFileName);
        imwrite(denoisedI_avg,denoisedName_avg);
        imwrite(denoisedI_med,denoisedName_med);
      end
end
