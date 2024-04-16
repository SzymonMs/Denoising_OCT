mex -setup;
mex -setup C++;
cd( fullfile( 'c:\Users\szymo\MatConvNet' ));
addpath matlab;
vl_compilenn;
% vl_compilenn('enableGpu', true, 'cudaRoot', 'C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.4','cudaMethod', 'nvcc', 'enableCudnn', true, ...
%                'cudnnRoot', 'local/cudnn-rc4')
run matlab/vl_setupnn;
