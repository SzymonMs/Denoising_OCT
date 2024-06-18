% Wczytaj pierwszy obraz
I = imread('data_to_images/cavrii/bezSkan_nr_99.tiff');

% Wczytaj dane konturów
load('11_med_grand_true/VMA_0001S_20160715103809/Skan_nr_99.mat');
ILM = data.ILM;
INLOPL = data.IPL_INL;
IPLINL = data.INL_OPL;
RPE = data.OB_RPE;
IOOS = data.IS_OSJ;

% Wczytaj drugi obraz
I2 = imread('after_segmentation/bezSkan_nr_99.tiff_afterSegmentation.png');

% Za³ó¿my, ¿e szerokoœæ obrazu jest równa d³ugoœci konturów
[y_size, x_size] = size(I);

% Utwórz wektor x odpowiadaj¹cy szerokoœci obrazu
x = 1:x_size;

% Pobierz kolory z colormap 'jet'
colorarr = colormap('jet');
params.colorarr = colorarr(255:-16:1, :);

% Przypisz kolory do konturów
ILM_color = params.colorarr(1, :);
INLOPL_color = params.colorarr(3, :);
IPLINL_color = params.colorarr(2, :);
RPE_color = params.colorarr(4, :);
IOOS_color = params.colorarr(5, :);

% Wyœwietl obrazki obok siebie


% Pierwszy obrazek z konturami
% subplot(1, 2, 1);
imshow(I);
hold on;

% Rysuj kontury na obrazku z u¿yciem odpowiednich kolorów i liniami przerywanymi
plot(x, ILM, 'Color', ILM_color, 'LineWidth', 2, 'LineStyle', '--'); % Kolor dla ILM
plot(x, INLOPL, 'Color', INLOPL_color, 'LineWidth', 2, 'LineStyle', '--'); % Kolor dla INLOPL
plot(x, IPLINL, 'Color', IPLINL_color, 'LineWidth', 2, 'LineStyle', '--'); % Kolor dla IPLINL
plot(x, RPE, 'Color', RPE_color, 'LineWidth', 2, 'LineStyle', '--'); % Kolor dla RPE
plot(x, IOOS, 'Color', IOOS_color, 'LineWidth', 2, 'LineStyle', '--'); % Kolor dla IOOS

% Dodaj podpisy do konturów w odpowiednich kolorach
text(x(end), ILM(end), 'ilm', 'Color', ILM_color, 'FontSize', 12, 'HorizontalAlignment', 'left');
text(x(end), INLOPL(end), 'inlopl', 'Color', INLOPL_color, 'FontSize', 12, 'HorizontalAlignment', 'right');
text(x(end), IPLINL(end), 'iplinl', 'Color', IPLINL_color, 'FontSize', 12, 'HorizontalAlignment', 'left');
text(x(end), RPE(end), 'rpe', 'Color', RPE_color, 'FontSize', 12, 'HorizontalAlignment', 'left');
text(x(end), IOOS(end), 'ioos', 'Color', IOOS_color, 'FontSize', 12, 'HorizontalAlignment', 'left');

hold off;

% % Drugi obrazek bez konturów
% subplot(1, 2, 2);
% imshow(I2);
