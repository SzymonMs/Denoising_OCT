%author: Adugna Mullissa

%Description: This script tests a trained deSpeckNet model using single polarization SAR intensity image. 
% This script is modified from https://github.com/cszn/DnCNN.

clc;
clear all

%% testing set
addpath(fullfile('utilities'));

folderModel = 'model';
gpu         = [];

load('models/deSpeckNet-epoch-30.mat'); %update path accordingly

net = dagnn.DagNN.loadobj(net) ;

out1 = net.getVarIndex('prediction') ;
net.vars(net.getVarIndex('prediction')).precious = 1 ;
net.mode = 'test';
Img = imread('patient1_raw0127.png'); %The image should be a grayscale image
if size(Img, 3) == 3
    Img = rgb2gray(Img);
end
Img = im2single(Img);
net.eval({'input', Img}) ;
output1 = gather(squeeze(gather(net.vars(out1).value)));