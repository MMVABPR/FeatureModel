function hsvColorHistogram=histHSV(image,szH,szS,szV)
% input: image to be quantized in hsv color space into 8x2x2 equal bins
% output: 1x32 vector indicating the features extracted from hsv color
% space

if nargin < 2
    szH=8;
end
if nargin < 3
    szS=2;
end
if nargin < 4
    szV=2;
end

% totalPixelsOfImage = rows*cols*numOfBands;
image = rgb2hsv(image);

% split image into h, s & v planes
h = image(:, :, 1);
s = image(:, :, 2);
v = image(:, :, 3);
% create final histogram matrix of size 8x2x2
hsvColorHistogram = zeros(1,szH*szS*szV);

% quantize each h,s,v equivalently to 8x2x2
% Specify the number of quantization levels.
thresholdForH = multithresh(h, szH-1);  % szH-1 thresholds result in szH image levels
thresholdForS = multithresh(s, szS-1);  % Computing one threshold will quantize ...
                                    % the image into three discrete levels
thresholdForV = multithresh(v, szV-1);  % 7 thresholds result in 8 image levels

seg_h = imquantize(h, thresholdForH); % apply the thresholds to obtain segmented image
seg_s = imquantize(s, thresholdForS); % apply the thresholds to obtain segmented image
seg_v = imquantize(v, thresholdForV); % apply the thresholds to obtain segmented image

%param
p_h=szS+szV;
p_s=szV;

%hitung histogram hsv
for i=1:size(h,1)
    for j=1:size(h,2)
        hsvColorHistogram((seg_h(i,j)-1)*p_h+(seg_s(i,j)-1)*p_s+seg_v(i,j))=hsvColorHistogram((seg_h(i,j)-1)*p_h+(seg_s(i,j)-1)*p_s+seg_v(i,j))+1;
    end
end

end