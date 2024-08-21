# Analysis of denoising solutions for OCT B-scans of the human retina 
eng. Szymon Murawski

A repository of my master's thesis in vision systems, the topic of which was the analysis of solutions for denoising B-scans OCT of the human eye. During the preparation of the work, an analysis of specialist literature was carried out on the topic of noise removal from optical computed tomography images. The paper compares traditional techniques for denoising digital images (averaging and median filtering) with methods using neural networks: DnCNN, FFDNet and ADNet. .To evaluate the effectiveness of the denoising process, the segmentation of the layers of the human retina was used: ILM, IPL-INL, INL-OPL, IS-OS RPE and the average segmentation time of the layers. Segmentation was based on Caserel. Additionally, the PSNR, SSIM indices and the time consumption of B-scan denoising were analyzed. A detailed statistical analysis of the obtained results was performed. The software was prepared and is located in this repository. The work was carried out using:

1. Jadwiga Rogowska, Mark E Brezinski. Image processing techniques for noiseremoval, enhancement and segmentation of cartilage OCT images. Physical Biology 47, 2002 pages 641-655.
2. Kai Zhang, Wangmeng Zuo, Yunjin Chen, Deyu Meng, Lei Zhang. Beyond a Gaussian Denoiser: Residual Learning of Deep CNN for Image Denoising. arXiv:1608.03981v1, 2016.
3. Kai Zhang, Wangmeng Zuo, Lei Zhang. FFDNet: Toward a Fast and FlexibleSolution for CNN based Image Denoising. arXiv:1710.04026v2, 2018.
4. Chunwei Tian, Yong Xu, Zuoyong, Wangmeng Zuo, Lunke Fei, Hong Liu.Attention-guided CNN for image denoising. Neural Networks, 2020. 
5.  Stephanie J. Chiu, Xiao T. Li, Peter Nicholas, Cynthia A. Toth, Joseph A. Izatt, Sina Farsiu. Automatic segmentation of seven retinal layers in SDOCT images congruent with expert manual segmentation. Optics Express vol.18 no.18, 30.08.2010.

## List of Catalogs/Files in repository:

1. SEGMENTACJA
   - OCTSegmentationApp.m - main application to segmentation OCT B-scans
   - OCTSegmentationQualityCheck.m - calculate segmentation error
   - Import B-scans to /data
2. ADNet:
   - Import B-scans to /data
   - /model - models of ADNet
   - /results - denoised B-scans and file with PSNR, SSIM, denoising time
   - models.py - ADNet implementation
   - ADNet_Denoiser.py - main application to denoising B-scans using ADNet
3. DnCNN_FDnCNN:
   - Import B-scans to /data
   - /model - models of DnCNN and FFDNet
   - /results - denoised B-scans and file with PSNR, SSIM, denoising time
   - FFDNet_DnCNN_Denoiser.m - main application
   - Denoising.m - denoising with DnCNN from Matlab implementation
   - env.m - file with environment configuration. It must be run first. More information here: https://www.vlfeat.org/matconvnet/install/#installing-and-compiling-the-library
4. Sate_of_Art:
   - Average and Median filter
5. BAZA_DANYCH:
   - json_to_mat_files - files conversion
   - /images - examples of B-scans to test denoising
6. PRACA_MAGISTERSKA_SZYMON_MURAWSKI.pdf, PREZENTACJA_SZYMON_MURAWSKI.pdf - final report and presentation, only polish version

# Analiza rozwiązań odszumiania B-skanów OCT siatkówki oka ludzkiego 
inż. Szymon Murawski

Repozytorium mojej pracy dyplomowej magisterskiej z systemów wizyjnych, której tematem była analiza rozwiązań odszumiania B-skanów OCT oka ludzkiego. Podczas przygotowania pracy wykonano analizę literatury specjalistycznej, dotyczącej tematyki usuwania szumów z obrazów optycznej tomografii komputerowej. W pracy porównano tradycyjne techniki odszumiania obrazów cyfrowych (filtracja uśredniająca i medianowa) z metodami wykorzystującymi sieci neuronowe: DnCNN, FFDNet oraz ADNet. .Do oceny skuteczności procesu odszumiania wykorzystano segmentację warstw siatkówki oka ludzkiego: ILM, IPL-INL, INL-OPL, IS-OS RPE oraz średni czas segmentacji warstw. Segmentacja oparta została o program Caserel. Dodatkowo przeanalizowano wskaźniki PSNR, SSIM oraz czasochłonność odszumiania B-skanów. Dokonano szczegółowej analizy statystycznej otrzymanych rezultatów. Przygotowano oprogramowanie znajduje się w tym repozytorium. Pracę wykonano z wykorzystaniem:

1. Jadwiga Rogowska, Mark E Brezinski. Image processing techniques for noiseremoval, enhancement and segmentation of cartilage OCT images. Physical Biology 47, 2002 str. 641-655.
2. Kai Zhang, Wangmeng Zuo, Yunjin Chen, Deyu Meng, Lei Zhang. Beyond a Gaussian Denoiser: Residual Learning of Deep CNN for Image Denoising. arXiv:1608.03981v1, 2016.
3. Kai Zhang, Wangmeng Zuo, Lei Zhang. FFDNet: Toward a Fast and FlexibleSolution for CNN based Image Denoising. arXiv:1710.04026v2, 2018.
4. Chunwei Tian, Yong Xu, Zuoyong, Wangmeng Zuo, Lunke Fei, Hong Liu.Attention-guided CNN for image denoising. Neural Networks, 2020. 
5.  Stephanie J. Chiu, Xiao T. Li, Peter Nicholas, Cynthia A. Toth, Joseph A. Izatt, Sina Farsiu. Automatic segmentation of seven retinal layers in SDOCT images congruent with expert manual segmentation. Optics Express vol.18 no.18, 30.08.2010.


### Lista katalogów/plików w repozytorium


1. SEGMENTACJA
   - OCTSegmentationApp.m - aplikacja do segmentacji
   - OCTSegmentationQualityCheck.m - obliczanie błędu segmentacji
   - /data - skany do odszumienia
2. ADNet:
   - /data - skany do odszumienia
   - /model - katalog z modelem sieci
   - /results - wynikowe obrazy i plik z PSNR, SSIM oraz czasem odszumiania
   - models.py - implementacja ADNet
   - ADNet_Denoiser.py - aplikacja do odszumiania ADNet
3. DnCNN_FDnCNN:
   - /data - skany do odszumienia
   - /model - katalog z modelami sieci DnCNN/FFDNet
   - /results - wynikowe obrazy i plik z PSNR, SSIM oraz czasem odszumiania
   - FFDNet_DnCNN_Denoiser.m - aplikacja do odszumiania
   - Denoising.m - aplikacja do odszumiania z siecią DnCNN zaimplementowaną w Matlabie
   - env.m - Konfiguracja środowiska, plik musi być uruchamiany przed odszumianiem. Więcej informacji tu: https://www.vlfeat.org/matconvnet/install/#installing-and-compiling-the-library
4. Sate_of_Art:
   - Filtracja medianowa i uśredniająca
5. BAZA_DANYCH:
   - json_to_mat_files - konwersja plików
   - /images - przykładowe B-skany
6. PRACA_MAGISTERSKA_SZYMON_MURAWSKI.pdf, PREZENTACJA_SZYMON_MURAWSKI.pdf - praca magisterska i prezentacja pracy
