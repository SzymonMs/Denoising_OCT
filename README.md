# Repozytorium pracy magiserskiej - ReadMe_wersja_robocza
inż. Szymon Murawski
### Opis plików/katalogów

1. AdNet:
   - data - przykładowe obrazy
   - g15, g25, g50, gblind - modele
   - results - odszumione obrazy + plik z wynikami PSNR,...
   - models.py - implementacja sieci
   - test.py - algorytm odszumiający
2. deSpeckNet-master:
   - uruchamiać env.m, potem DeSpeckNet.m
   - Wymaga modyfikacji w MatConvNet:
	W c:\Users\szymo\MatConvNet\matlab\+dagnn\ wrzucić Multiply.m
	W c:\Users\szymo\MatConvNet\matlab\+dagnn\Loss.m zmienić wszędzie vl_nnloss na vl_nnloss_SM
	Dorzucić vl_nnloss_SM.m do \c:\Users\szymo\MatConvNet\matlab\ 
3. DnCNN_FDnCNN:
   - data - przykładowe obrazy
   - model - modele
   - results_... - rezultaty dla poszczególnych modeli
   - utilities - dodatkowe pliki m, różne funkcje od pana Zhanga
   - Demo_FDnCNN_Gray.m - algorytm odszumiający
   - Demo_FDnCNN_Gray_Clip.m - testowy kod
   - Denoising.m - testowy kod
   - env.m - kod konfiguracji środowiska - musi być odpalony pierwszy !!! Przed trzeba zrobić to co tu: https://www.vlfeat.org/matconvnet/install/#installing-and-compiling-the-library
   - results.txt - plik z wynikami PSNR,...
4. Sate_of_Art:
   - filtr uśredniający, medianowy, transformacja zafalowaniowa, dyfuzja anizotropowa
