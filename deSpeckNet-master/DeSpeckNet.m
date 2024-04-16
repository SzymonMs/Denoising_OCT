clc;
clear;

folderModel = 'model';
gpu         = [];
load('models/deSpeckNet-epoch-30.mat'); %update path accordingly
net = dagnn.DagNN.loadobj(net) ;
out1 = net.getVarIndex('prediction') ;
net.vars(net.getVarIndex('prediction')).precious = 1 ;
net.mode = 'test';


myDir = 'data';
resultDirWavelt = 'results';
filePattern = fullfile(myDir);
myFiles = dir(filePattern);
for k = 1:length(myFiles)
      baseFileName = myFiles(k).name;
      fullFileName = fullfile(myDir, baseFileName);
      if length(baseFileName) > 3
        Img = imread(fullFileName) ;
        if size(Img, 3) == 3
            Img = rgb2gray(Img);
        end
        Img = im2single(Img);
        net.eval({'input', Img}) ;
        output1 = gather(squeeze(gather(net.vars(out1).value)));
        fprintf('%d. %s\n',k-2, baseFileName);
        denoisedName = strcat(resultDirWavelt,"\Wavelt_denoised_",baseFileName);
        imwrite(output1,denoisedName);
      end
end