I2name = 'WYNIKI_ADNET\octid\images\06 OS - Copy.jpeg';
I1name = 'State_of_Art\data\images\06 OS - Copy.jpeg';

I1 = imread(I1name);
I2 = imread(I2name);
subplot(1, 2, 1);
imshow(I1);
title('Bez odszumiania');
subplot(1, 2, 2);
imshow(I2);
% imshowpair(I1,I2,"montage")
title('Sieæ ADNet');
