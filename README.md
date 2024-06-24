# Repozytorium pracy magiserskiej 
inż. Szymon Murawski
### Opis plików/katalogów


1. SEGMENTACJA  - MATLAB 2019b
   - uruchamiać OCTSegmentationApp.m
   - B-skany do katalogu data
2. AdNet:
   - data - przykładowe obrazy
   - model - modele
   - results - odszumione obrazy + plik z wynikami PSNR,...
   - models.py - implementacja sieci
   - test.py - algorytm odszumiający

4. DnCNN_FDnCNN:
   - data - przykładowe obrazy
   - model - modele
   - results_... - rezultaty dla poszczególnych modeli
   - utilities - dodatkowe pliki m, różne funkcje od pana Zhanga
   - Demo_FDnCNN_Gray.m - algorytm odszumiający
   - Demo_FDnCNN_Gray_Clip.m - testowy kod
   - Denoising.m - sieć DnCNN Matlab
   - env.m - kod konfiguracji środowiska - musi być odpalony pierwszy !!! Przed trzeba zrobić to co tu: https://www.vlfeat.org/matconvnet/install/#installing-and-compiling-the-library
   - results.txt - plik z wynikami PSNR,...
5. Sate_of_Art:
   - filtr uśredniający, medianowy
