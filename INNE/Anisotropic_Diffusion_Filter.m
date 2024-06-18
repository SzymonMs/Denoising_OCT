clc;
clear;
myDir = 'data';
resultDirDiffusion = 'Diffusion_Filter';
filePattern = fullfile(myDir);
myFiles = dir(filePattern);
for k = 1:length(myFiles)
      baseFileName = myFiles(k).name;
      fullFileName = fullfile(myDir, baseFileName);
      if length(baseFileName) > 3
        I = imread(fullFileName) ;
        if size(I, 3) == 3
            I = rgb2gray(I);
        end
        [gradThresh,numIter] = imdiffuseest(I);
        denoisedI_diff = imdiffusefilt(I,'GradientThreshold',gradThresh,'NumberOfIterations',numIter);
        % denoisedI_diff = specklefilt(I,"DegreeOfSmoothing",0.4,"NumIterations",30);
        fprintf('%d. %s\n',k-2, baseFileName);
        denoisedName_diff = strcat(resultDirDiffusion,"\Diffusion_denoised_",baseFileName);
        imwrite(denoisedI_diff,denoisedName_diff);
      end
end
