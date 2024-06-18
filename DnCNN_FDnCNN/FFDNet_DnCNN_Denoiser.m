% This is the testing demo of Flexible DnCNN (FDnCNN) for denoising noisy grayscale images corrupted by
% AWGN with clipping setting. The noisy input is 8-bit quantized.
%
% "Beyond a Gaussian Denoiser: Residual Learning of Deep CNN for Image Denoising"
% "FFDNet: Toward a Fast and Flexible Solution for CNN based Image Denoising"
%
%  2018/05
% If you have any question, please feel free to contact with me.
% Kai Zhang (e-mail: cskaizhang@gmail.com)

clear all; clc;
format compact;
global sigmas;
sigmas = 0.05;
addpath(fullfile('utilities'));

folderModel = 'model';
folderResult= 'results';

showResult  = 1;
pauseTime   = 0;

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
AVGPSNR = zeros(1,size(subdirs,1));
AVGSSIM= zeros(1,size(subdirs,1));
AVGTimes = zeros(1,size(subdirs,1));
for xx = 1:size(subdirs,1)
myDir = subdirs(xx);
resultDirAverage = strcat(folderResult,'\',subdirs(xx));
if ~exist(resultDirAverage, 'dir')
    mkdir(resultDirAverage);
end

load(fullfile('model','FFDNet.mat')); 
net = vl_simplenn_tidy(net);

% read images
ext         =  {'*.jpeg','*.png','*.bmp','*.tiff'};
filePaths   =  [];
for i = 1 : length(ext)
    filePaths = cat(1,filePaths, dir(fullfile(myDir,ext{i})));
end

% PSNR and SSIM
PSNRs = zeros(1,length(filePaths));
SSIMs = zeros(1,length(filePaths));
Names = {};
numberOfFiles = length(filePaths);
Times = zeros(1,length(filePaths));
for i = 1:numberOfFiles
    
    % read images
    label = imread(fullfile(myDir,filePaths(i).name));
    [w,h,~]=size(label);
    if size(label,3)==3
        label = rgb2gray(label);
    end
    
    [~,nameCur,extCur] = fileparts(filePaths(i).name);
    label = im2single(label);
    input = label;
    
    % denoising
    tic;
    res    = vl_simplenn(net,input,[],[],'conserveMemory',true,'mode','test');
    output = res(end).x;
    endTime = toc;

    % calculate PSNR, SSIM and save results
    [PSNRCur, SSIMCur] = Cal_PSNRSSIM(im2uint8(label),im2uint8(output),0,0);
    if showResult
        imwrite(im2uint8(output), fullfile(resultDirAverage, [nameCur, extCur] ));
    end
    disp([filePaths(i).name,'    ',num2str(PSNRCur,'%2.2f'),'dB','    ',num2str(SSIMCur,'%2.4f'),'    ',num2str(endTime,'%2.4f'),'s']);
    PSNRs(i) = PSNRCur;
    SSIMs(i) = SSIMCur;
    Times(i) = endTime;
    Names{end+1} = filePaths(i).name;
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
writetable(T,strcat(folderResult,'/FFDNetResults.csv'));