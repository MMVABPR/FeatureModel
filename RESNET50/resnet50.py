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


class net(nn.Module):
    def __init__(self):
        super(net, self).__init__()
        self.net = models.resnet50(pretrained=True)

    def forward(self, input):
        output = self.net.conv1(input)
        output = self.net.bn1(output)
        output = self.net.relu(output)
        output = self.net.maxpool(output)
        output = self.net.layer1(output)
        output = self.net.layer2(output)
        output = self.net.layer3(output)
        output = self.net.layer4(output)
        output = self.net.avgpool(output)
        return output


model = net()
# // 加载cuda
model = model.cuda()

extensions = ['jpg', 'jpeg', 'JPG', 'JPEG', 'png']
features = []
files_list = []
imgs_path = open(txt_path).read().splitlines()
for i, img in enumerate(imgs_path):
    print("%d %s" % (i, img))
print("")
use_gpu = torch.cuda.is_available()

for i, im in enumerate(imgs_path):
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
    # np.savetxt(saved_path, y, delimiter=',')
    feature = np.reshape(y, [1, -1])
    print(feature.shape)
    features.append(feature)

features = np.array(features)

features_tmp = np.reshape(features, (features.shape[0], features.shape[2]))
# features_csv = pd.DataFrame(features_tmp)
# features_csv.to_csv(save_path + 'resnet50.csv', index=False, header=False)
#
dic = {'resnet50': features_tmp}
sio.savemat(save_path + 'resnet50' + '.mat', dic)
