% file = 'WYNIKI_AVG_MED/5_5_Average_Filter/data';
% namefile = 'AVG5.csv';
% combineCSVFiles(file,namefile);

XXX3 = readCSVAsVectors('MED3.csv');
PSNR3 = XXX3.PSNRs_Med(1:end-19);
Times3 = XXX3.Times_Med(1:end-19);
SSIM3 = XXX3.SSIMs_Med(1:end-19);
CP25_PSNR3 = prctile(PSNR3,25);
CP75_PSNR3 = prctile(PSNR3,75);
min_PSNR3 = min(PSNR3);
max_PSNR3 = max(PSNR3);
std_PSNR3 = std(PSNR3);
CP25_Times3 = prctile(Times3,25);
CP75_Times3 = prctile(Times3,75);
min_Times3 = min(Times3);
max_Times3 = max(Times3);
std_Times3 = std(Times3);
CP25_SSIM3 = prctile(SSIM3,25);
CP75_SSIM3 = prctile(SSIM3,75);
min_SSIM3 = min(SSIM3);
max_SSIM3 = max(SSIM3);
std_SSIM3 = std(SSIM3);

XXX11 = readCSVAsVectors('MED11.csv');
PSNR11 = XXX11.PSNRs_Med(1:end-19);
Times11 = XXX11.Times_Med(1:end-19);
SSIM11 = XXX11.SSIMs_Med(1:end-19);
CP25_PSNR11 = prctile(PSNR11,25);
CP75_PSNR11 = prctile(PSNR11,75);
min_PSNR11 = min(PSNR11);
max_PSNR11 = max(PSNR11);
std_PSNR11 = std(PSNR11);
CP25_Times11 = prctile(Times11,25);
CP75_Times11 = prctile(Times11,75);
min_Times11 = min(Times11);
max_Times11 = max(Times11);
std_Times11 = std(Times11);
CP25_SSIM11 = prctile(SSIM11,25);
CP75_SSIM11 = prctile(SSIM11,75);
min_SSIM11 = min(SSIM11);
max_SSIM11 = max(SSIM11);
std_SSIM11 = std(SSIM11);

XXX9 = readCSVAsVectors('MED9.csv');
PSNR9 = XXX9.PSNRs_Med(1:end-19);
Times9 = XXX9.Times_Med(1:end-19);
SSIM9 = XXX9.SSIMs_Med(1:end-19);
CP25_PSNR9 = prctile(PSNR9,25);
CP75_PSNR9 = prctile(PSNR9,75);
min_PSNR9 = min(PSNR9);
max_PSNR9 = max(PSNR9);
std_PSNR9 = std(PSNR9);
CP25_Times9 = prctile(Times9,25);
CP75_Times9 = prctile(Times9,75);
min_Times9 = min(Times9);
max_Times9 = max(Times9);
std_Times9 = std(Times9);
CP25_SSIM9 = prctile(SSIM9,25);
CP75_SSIM9 = prctile(SSIM9,75);
min_SSIM9 = min(SSIM9);
max_SSIM9 = max(SSIM9);
std_SSIM9 = std(SSIM9);

XXX7 = readCSVAsVectors('MED7.csv');
PSNR7 = XXX7.PSNRs_Med(1:end-19);
Times7 = XXX7.Times_Med(1:end-19);
SSIM7 = XXX7.SSIMs_Med(1:end-19);
CP25_PSNR7 = prctile(PSNR7,25);
CP75_PSNR7 = prctile(PSNR7,75);
min_PSNR7 = min(PSNR7);
max_PSNR7 = max(PSNR7);
std_PSNR7 = std(PSNR7);
CP25_Times7 = prctile(Times7,25);
CP75_Times7 = prctile(Times7,75);
min_Times7 = min(Times7);
max_Times7 = max(Times7);
std_Times7 = std(Times7);
CP25_SSIM7 = prctile(SSIM7,25);
CP75_SSIM7 = prctile(SSIM7,75);
min_SSIM7 = min(SSIM7);
max_SSIM7 = max(SSIM7);
std_SSIM7 = std(SSIM7);

XXX5 = readCSVAsVectors('MED5.csv');
PSNR5 = XXX5.PSNRs_Med(1:end-19);
Times5 = XXX5.Times_Med(1:end-19);
SSIM5 = XXX5.SSIMs_Med(1:end-19);
CP25_PSNR5 = prctile(PSNR5,25);
CP75_PSNR5 = prctile(PSNR5,75);
min_PSNR5 = min(PSNR5);
max_PSNR5 = max(PSNR5);
std_PSNR5 = std(PSNR5);
CP25_Times5 = prctile(Times5,25);
CP75_Times5 = prctile(Times5,75);
min_Times5 = min(Times5);
max_Times5 = max(Times5);
std_Times5 = std(Times5);
CP25_SSIM5 = prctile(SSIM5,25);
CP75_SSIM5 = prctile(SSIM5,75);
min_SSIM5 = min(SSIM5);
max_SSIM5 = max(SSIM5);
std_SSIM5 = std(SSIM5);


% boxplot([PSNR3,PSNR5,PSNR7,PSNR9,PSNR11],'Labels',{{'n = 3','n = 5','n = 7','n = 9','n = 11'}}, 'Symbol',' ','Orientation','vertical')
% title('PSNR dla filtru medianowego')
% xlabel('PSNR [dB]')

boxplot([SSIM3,SSIM5,SSIM7,SSIM9,SSIM11],'Labels',{{'n = 3','n = 5','n = 7','n = 9','n = 11'}}, 'Symbol',' ','Orientation','vertical')
title('SSIM dla filtru medianowego')
xlabel('SSIM')
