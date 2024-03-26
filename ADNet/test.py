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

def batch_PSNR(img, imclean, data_range):
    Img = img.data.cpu().numpy().astype(np.float32)
    Iclean = imclean.data.cpu().numpy().astype(np.float32)
    PSNR = 0
    for i in range(Img.shape[0]):
        PSNR += peak_signal_noise_ratio(Iclean[i,:,:,:], Img[i,:,:,:], data_range=data_range)
    return (PSNR/Img.shape[0])

def normalize(data):
    return data / 255.

def main():

    results_dir = 'results'
    extension = '*.bmp'#'*.JPG'#'*.png' # '*.bmp'
    model_name='g_25' #To save results
    PSNR_list = []
    times_list = []

    # Build model
    print('Loading model ...\n')
    net = ADNet(channels=1, num_of_layers=17)
    model = nn.DataParallel(net)
    desktop_path = os.path.join("g25")
    model_path = os.path.join(desktop_path,'model_70.pth')
    model.load_state_dict(torch.load(model_path, map_location=torch.device('cpu')))
    model.eval()
    # Load data info
    print('Loading data info ...\n')
    files_source = glob.glob(os.path.join('data',extension))
    files_source.sort()

    # Create a directory for results if it doesn't exist

    os.makedirs(results_dir, exist_ok=True)

    # Process data

    for f in files_source:
        # Image
        Img = cv2.imread(f)
        Img = normalize(np.float32(Img[:, :, 0]))
        Img = np.expand_dims(Img, 0)
        Img = np.expand_dims(Img, 1)
        ISource = torch.Tensor(Img)
        start = time.time()
        with torch.no_grad():  # This can save much memory
            Out = torch.clamp(model(ISource), 0., 1.)
        end = time.time()
        elapsed = end-start
        # Save the result image
        result_path = os.path.join(results_dir, model_name+'_denoised_'+os.path.basename(f))
        cv2.imwrite(result_path, (Out.squeeze().cpu().numpy() * 255).astype(np.uint8))

        # Calculate PSNR if needed
        psnr = batch_PSNR(Out, ISource, 1.)
        print("%s PSNR %fdB TIME %fs" % (f, psnr,elapsed))
        PSNR_list.append(psnr)
        times_list.append(elapsed)
    resultFile =  results_dir+'/'+model_name+'_denoising_process_data.txt'
    resulFileHandler = open(resultFile,"w")
    resulFileHandler.write('FileName                PSNR[dB]            DenoisingTime[s] \n')
    for i in range(1,len(PSNR_list)):
        resulFileHandler.write(str(files_source[i])+' '+str(PSNR_list[i])+' '+str(times_list[i])+'\n')
    resulFileHandler.close()

if __name__ == "__main__":
    main()
