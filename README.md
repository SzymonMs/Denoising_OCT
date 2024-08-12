# Master final thesis repository -ENG
eng. Szymon Murawski

A repository of my master's thesis in vision systems, the topic of which was the analysis of solutions for denoising B-scans OCT of the human eye. During the preparation of the work, an analysis of specialist literature was carried out on the topic of noise removal from optical computed tomography images. The paper compares traditional techniques for denoising digital images (averaging and median filtering) with methods using neural networks: DnCNN, FFDNet and ADNet. .To evaluate the effectiveness of the denoising process, the segmentation of the layers of the human retina was used: ILM, IPL-INL, INL-OPL, IS-OS RPE and the average segmentation time of the layers. Segmentation was based on Caserel. Additionally, the PSNR, SSIM indices and the time consumption of B-scan denoising were analyzed. A detailed statistical analysis of the obtained results was performed. The software was prepared and is located in this repository. The work was carried out using:

1. Jadwiga Rogowska, Mark E Brezinski. Image processing techniques for noiseremoval, enhancement and segmentation of cartilage OCT images. Physical Biology 47, 2002 pages 641-655.
2. Kai Zhang, Wangmeng Zuo, Yunjin Chen, Deyu Meng, Lei Zhang. Beyond a Gaussian Denoiser: Residual Learning of Deep CNN for Image Denoising. arXiv:1608.03981v1, 2016.
3. Kai Zhang, Wangmeng Zuo, Lei Zhang. FFDNet: Toward a Fast and FlexibleSolution for CNN based Image Denoising. arXiv:1710.04026v2, 2018.
4. Chunwei Tian, Yong Xu, Zuoyong, Wangmeng Zuo, Lunke Fei, Hong Liu.Attention-guided CNN for image denoising. Neural Networks, 2020. 
5.  Stephanie J. Chiu, Xiao T. Li, Peter Nicholas, Cynthia A. Toth, Joseph A. Izatt, Sina Farsiu. Automatic segmentation of seven retinal layers in SDOCT images congruent with expert manual segmentation. Optics Express vol.18 no.18, 30.08.2010.

# Repozytorium pracy magiserskiej -POL
inż. Szymon Murawski

Repozytorium mojej pracy dyplomowej magisterskiej z systemów wizyjnych, której tematem była analiza rozwiązań odszumiania B-skanów OCT oka ludzkiego. Podczas przygotowania pracy wykonano analizę literatury specjalistycznej, dotyczącej tematyki usuwania szumów z obrazów optycznej tomografii komputerowej. W pracy porównano tradycyjne techniki odszumiania obrazów cyfrowych (filtracja uśredniająca i medianowa) z metodami wykorzystującymi sieci neuronowe: DnCNN, FFDNet oraz ADNet. .Do oceny skuteczności procesu odszumiania wykorzystano segmentację warstw siatkówki oka ludzkiego: ILM, IPL-INL, INL-OPL, IS-OS RPE oraz średni czas segmentacji warstw. Segmentacja oparta została o program Caserel. Dodatkowo przeanalizowano wskaźniki PSNR, SSIM oraz czasochłonność odszumiania B-skanów. Dokonano szczegółowej analizy statystycznej otrzymanych rezultatów. Przygotowano oprogramowanie znajduje się w tym repozytorium. Pracę wykonano z wykorzystaniem:

1. Jadwiga Rogowska, Mark E Brezinski. Image processing techniques for noiseremoval, enhancement and segmentation of cartilage OCT images. Physical Biology 47, 2002 str. 641-655.
2. Kai Zhang, Wangmeng Zuo, Yunjin Chen, Deyu Meng, Lei Zhang. Beyond a Gaussian Denoiser: Residual Learning of Deep CNN for Image Denoising. arXiv:1608.03981v1, 2016.
3. Kai Zhang, Wangmeng Zuo, Lei Zhang. FFDNet: Toward a Fast and FlexibleSolution for CNN based Image Denoising. arXiv:1710.04026v2, 2018.
4. Chunwei Tian, Yong Xu, Zuoyong, Wangmeng Zuo, Lunke Fei, Hong Liu.Attention-guided CNN for image denoising. Neural Networks, 2020. 
5.  Stephanie J. Chiu, Xiao T. Li, Peter Nicholas, Cynthia A. Toth, Joseph A. Izatt, Sina Farsiu. Automatic segmentation of seven retinal layers in SDOCT images congruent with expert manual segmentation. Optics Express vol.18 no.18, 30.08.2010.


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
