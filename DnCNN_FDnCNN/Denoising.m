addpath(fullfile('utilities'));
net = denoisingNetwork('DnCNN');
myDir = 'data';
resultDir = 'results';
files = dir(myDir);
isSubdir = [files.isdir] & ~ismember({files.name}, {'.', '..'});
subdirs = strings(sum(isSubdir), 1);
idx = 1;
for i = 1:length(files)
    if isSubdir(i)
        subdirs(idx) = fullfile(myDir, files(i).name);
        idx = idx + 1;
    end
end
AVGPSNR = zeros(1,size(subdirs,1));
AVGSSIM= zeros(1,size(subdirs,1));
AVGTimes = zeros(1,size(subdirs,1));
for xx = 1:size(subdirs,1)
myDir = subdirs(xx);
resultDirAverage = strcat(resultDir,'\',subdirs(xx));
if ~exist(resultDirAverage, 'dir')
    mkdir(resultDirAverage);
end
ext         =  {'*.jpeg','*.png','*.bmp','*.tiff'};
myFiles = [];
for i = 1 : length(ext)
    myFiles = cat(1,myFiles, dir(fullfile(myDir,ext{i})));
end
PSNRs = zeros(1,length(myFiles));
SSIMs = zeros(1,length(myFiles));
Names = {};
numberOfFiles = length(myFiles);
Times = zeros(1,length(myFiles));
for i = 1:numberOfFiles
      baseFileName = myFiles(i).name;
      fullFileName = fullfile(myDir, baseFileName);
      if length(baseFileName) > 3
        I = imread(fullFileName) ;
        if size(I, 3) == 3
            I = rgb2gray(I);
        end
            tic;
            denoisedI = denoiseImage(I,net);
            endTime = toc;
            denoisedName = strcat(resultDirAverage,"\",baseFileName);
            imwrite(denoisedI,denoisedName)
            [PSNRCur, SSIMCur] = Cal_PSNRSSIM(im2uint8(I),im2uint8(denoisedI),0,0);
            PSNRs(i) = PSNRCur;
            SSIMs(i) = SSIMCur;
            Times(i) = endTime;
            Names{end+1} = myFiles(i).name;
      end
end
Names = Names';
PSNRs = PSNRs';
SSIMs = SSIMs';
Times = Times';
T= table(Names,PSNRs,SSIMs,Times);
writetable(T,strcat(resultDirAverage,'/results.csv'));
AVGPSNR(xx) = mean(PSNRs);
AVGSSIM(xx) = mean(SSIMs);
AVGTimes(xx) = mean(Times);
end
AVGPSNR=AVGPSNR';
AVGSSIM=AVGSSIM';
AVGTimes=AVGTimes';
T= table(AVGPSNR,AVGSSIM,AVGTimes);
writetable(T,strcat(resultDir,'/DnCNNtResults.csv'));