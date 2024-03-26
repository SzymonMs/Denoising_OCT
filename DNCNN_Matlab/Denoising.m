net = denoisingNetwork('DnCNN');
myDir = 'data';
resultDir = 'results_DnCNN';
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
        denoisedI = denoiseImage(I,net);
        fprintf('%d. %s\n',k-2, baseFileName);
        denoisedName = strcat(resultDir,"\denoised_",baseFileName);
        imwrite(denoisedI,denoisedName)
      end
end