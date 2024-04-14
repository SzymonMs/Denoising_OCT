clc;
clear;
myDir = 'data';
resultDirAverage = 'Average_Filter';
resultDirMedian = 'Median_Filter';
% resultDirWavelt = 'Wavelt_Filter';
filePattern = fullfile(myDir);
myFiles = dir(filePattern);
n = 3;
m = 3;
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
        % denoisedI_wavelt=wdenoise2(im2uint8(I),3,'Wavelet','coif5','NoiseEstimate','LevelDependent','DenoisingMethod','Bayes','ThresholdRule','Soft','NoiseDirection',["h","v","d"]);
        % denoisedI_wavelt = wdenoise2(I,2,'wavelet',"haar");
        fprintf('%d. %s\n',k-2, baseFileName);
        denoisedName_avg = strcat(resultDirAverage,"\Avg_denoised_",baseFileName);
        denoisedName_med = strcat(resultDirMedian,"\Med_denoised_",baseFileName);
        % denoisedName_wavelt = strcat(resultDirWavelt,"\Wavelt_denoised_",baseFileName);
        imwrite(denoisedI_avg,denoisedName_avg);
        imwrite(denoisedI_med,denoisedName_med);
        % imwrite(denoisedI_wavelt,denoisedName_wavelt);
      end
end
