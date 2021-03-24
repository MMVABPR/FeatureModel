import torch
import torch.nn as nn
from torch.autograd import Variable
from torchvision import models, transforms
from PIL import Image
import numpy as np
import pandas as pd
import os, glob
import scipy.io as sio

txt_path = ''
save_path = ''

class Encoder(nn.Module):
    def __init__(self):
        super(Encoder, self).__init__()
        VGG = models.vgg16(pretrained=True)
        self.feature = VGG.features
        self.classifier = nn.Sequential(*list(VGG.classifier.children())[:-3])
        pretrained_dict = VGG.state_dict()
        model_dict = self.classifier.state_dict()
        pretrained_dict = {k: v for k, v in pretrained_dict.items() if k in model_dict}
        model_dict.update(pretrained_dict)
        self.classifier.load_state_dict(model_dict)

    def forward(self, x):
        output = self.feature(x)
        output = output.view(output.size(0), -1)
        output = self.classifier(output)
        return output
model = Encoder()
model = model.cuda()

extensions = ['jpg', 'jpeg', 'JPG', 'JPEG' ,'png']
features = []
files_list = []
imgs_path = open(txt_path).read().splitlines()
use_gpu = torch.cuda.is_available()
for i, im in enumerate(imgs_path):
    print("%d %s" % (i, im))
    print("")
    transform = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor()]
    )
    img = Image.open(im)
    img = transform(img)
    print(im)
    print(img.shape)

    x = Variable(torch.unsqueeze(img, dim=0).float(), requires_grad=False)
    print(x.shape)

    if use_gpu:
        x = x.cuda()
        model = model.cuda()
    y = model(x).cpu()
    y = torch.squeeze(y)
    y = y.data.numpy()
    print(y.shape)
    feature = np.reshape(y, [1, -1])
    features.append(feature)

features = np.array(features)
features_tmp = np.reshape(features, (features.shape[0],features.shape[2]))
features_csv = pd.DataFrame(features_tmp)
features_csv.to_csv(save_path+'vgg16.csv',index=False,header=False)

# dic = {'vgg16': features_tmp}
# sio.savemat(save_path + 'vgg16' + '.mat', dic)
