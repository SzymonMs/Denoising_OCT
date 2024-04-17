clc;
clear;
myDir = 'data';
resultDirWavelt = 'Wavelt_Filter';
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
        I = double(I);
        for x = 1:length(I(:,1))
            for y = 1:length(I(1,:))
                I(x,y) = log(I(x,y));
                if abs(log(I(x,y))) > 5
                    I(x,y) = -1;
                end
            end
        end
        % dwtmode('per');
        [thr,sorh,keepapp] = ddencmp('den','wv',I);
        denoisedI_wavelt = wdencmp('gbl',double(I),'sym6',15,thr,sorh,keepapp);
        fprintf('%d. %s\n',k-2, baseFileName);
        denoisedName_wavelt = strcat(resultDirWavelt,"\Wavelt_denoised_",baseFileName);
        for x = 1:length(denoisedI_wavelt(:,1))
            for y = 1:length(denoisedI_wavelt(1,:))
                denoisedI_wavelt(x,y) = exp(denoisedI_wavelt(x,y));
            end
        end
        imwrite(uint8(denoisedI_wavelt),denoisedName_wavelt);
      end
end