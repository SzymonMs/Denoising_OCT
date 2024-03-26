I1 = imread('05_25.png');
I2 = imread('05_25_noisy.png')
I3 = imread('g_25_denoised_05_25_noisy.png')
imagelist = [I1,I2,I3]
% montage(imagelist,Size=[1 NaN],BackgroundColor="white")

figure
tiledlayout(1,3);

nexttile
imshow(I1)
title('Obraz pierwotny','interpreter', 'latex')

nexttile
imshow(I2)
title('Obraz zaszumiony ${\sigma}=25$', 'interpreter', 'latex')

nexttile
imshow(I3)
title("Obraz odszumiony ADNet",'interpreter', 'latex')