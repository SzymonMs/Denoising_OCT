import cv2
import os
import glob
import time
import numpy as np
import torch
import torch.nn as nn
from torch.autograd import Variable
from models import ADNet
from skimage.metrics.simple_metrics import peak_signal_noise_ratio
from skimage.metrics import structural_similarity
def batch_PSNR(img, imclean, data_range):
    Img = img.data.cpu().numpy().astype(np.float32)
    Iclean = imclean.data.cpu().numpy().astype(np.float32)
    PSNR = 0
    for i in range(Img.shape[0]):
        PSNR += peak_signal_noise_ratio(Iclean[i,:,:,:], Img[i,:,:,:], data_range=data_range)
    return (PSNR/Img.shape[0])

def normalize(data):
    return data / 255.

def list_subdirectories(directory):
    return [name for name in os.listdir(directory) if os.path.isdir(os.path.join(directory, name))]

def list_files_with_extension(directory, extension):
    return [f for f in os.listdir(directory) if f.endswith(extension)]

def main():



    results = 'results'
    extension = '.jpeg'
    my_dir = 'data'


    print('Loading model ...\n')
    net = ADNet(channels=1, num_of_layers=17)
    model = nn.DataParallel(net)
    desktop_path = os.path.join("g25")
    model_path = os.path.join(desktop_path,'model_70.pth')
    model.load_state_dict(torch.load(model_path, map_location=torch.device('cpu')))
    model.eval()
    print('Loading data info ...\n')

    list_of_folders = list_subdirectories(my_dir)
    PSNRAVG = []
    SSIMAVG = []
    TIMESAVG = []
    for xx in list_of_folders:
        PSNR_list = []
        SSIM_list = []
        times_list = []
        files_source = list_files_with_extension(my_dir+'/'+xx,extension)
        files_source.sort()
        results_dir = results+'/'+xx
        os.makedirs(results_dir, exist_ok=True)

        for f in files_source:
            Img = cv2.imread(my_dir+'/'+xx+'/'+f)
            Img = normalize(np.float32(Img[:, :, 0]))
            Img = np.expand_dims(Img, 0)
            Img = np.expand_dims(Img, 1)
            ISource = torch.Tensor(Img)
            start = time.time()
            with torch.no_grad():
                Out = torch.clamp(model(ISource), 0., 1.)
            end = time.time()
            elapsed = end-start
            result_path = os.path.join(results_dir, os.path.basename(f))
            cv2.imwrite(result_path, (Out.squeeze().cpu().numpy() * 255).astype(np.uint8))
            psnr = batch_PSNR(Out, ISource, 1.)
            ssim = structural_similarity(Out.squeeze().cpu().numpy(),ISource.squeeze().cpu().numpy(),data_range=1.0)
            print("%s PSNR %fdB SSIM %f TIME %fs" % (f, psnr,ssim,elapsed))
            PSNR_list.append(psnr)
            SSIM_list.append(ssim)
            times_list.append(elapsed)
        resultFile =  results_dir+'/Adnet_data.txt'
        resulFileHandler = open(resultFile,"w")
        resulFileHandler.write('FileName                PSNR[dB]            SSIM            DenoisingTime[s] \n')
        for i in range(0,len(PSNR_list)):
            resulFileHandler.write(str(files_source[i])+';'+str(PSNR_list[i])+';'+str(SSIM_list[i])+';'+str(times_list[i])+'\n')
        resulFileHandler.close()
        PSNRAVG.append(sum(PSNR_list)/len(PSNR_list))
        SSIMAVG.append(sum(SSIM_list)/len(SSIM_list))
        TIMESAVG.append(sum(times_list)/len(times_list))
    resultFile2 =  results+'/ADNet.txt'
    resulFileHandler2 = open(resultFile2,"w")
    resulFileHandler2.write('PSNR[dB]            SSIM            DenoisingTime[s] \n')
    for i in range(0,len(PSNRAVG)):
        resulFileHandler2.write(str(PSNRAVG[i])+';'+str(SSIMAVG[i])+';'+str(TIMESAVG[i])+'\n')
    resulFileHandler2.close()
if __name__ == "__main__":
    main()
