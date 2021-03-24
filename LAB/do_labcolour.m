function [ L] = do_labcolour( file )
%DO_RGBCOLOUR is used to get colour feature of a picture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Input:
%file --- the absolute path of a picture
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Output:
%hist --- a vector to show colour feature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
picture = imread(file);  
picR = picture(:,:,1);  
picG = picture(:,:,2);  
picB = picture(:,:,3);  
  
  
% figure,imshow(picture)                   
% title('ԭʼͼ��')
  
  
% ???��??��?�¡��Ʀ�??  
[m,n]=size(picR);                            %��???????��???��? ?  
rhist=zeros(1,256);                          %����??��???�ơ�?��??��??�¡ǡ�? ?????? 
bhist=zeros(1,256); 
ghist=zeros(1,256); 

for k=0:255      
    rhist(k+1)=length(find(picR==k))/(m*n);     %????��????��??��??��??�ǡ�? ?����??��????rhist�¨C??��???�¡�
    ghist(k+1)=length(find(picG==k))/(m*n);
    bhist(k+1)=length(find(picB==k))/(m*n);   
end  
% figure,bar(0:255,rhist,'r')                   %����ֱ��ͼ
% title('R��ֱ��ͼ')
% xlabel('�Ҷ�ֵ')
% ylabel('���ָ���')
% figure,bar(0:255,ghist,'g')
% title('G��ֱ��ͼ')
% xlabel('�Ҷ�ֵ')
% ylabel('���ָ���')
% figure,bar(0:255,bhist,'b')
% title('B��ֱ��ͼ')
% xlabel('�Ҷ�ֵ')
% ylabel('���ָ���')
RGB = [reshape(rhist',1,256),reshape(ghist',1,256),reshape(bhist',1,256)]; %��?�¡��Ʀ�????�����ݡ� 256*3 ??????��?  
% RGB to XYZ
MAT = [0.412453 0.357580 0.180423;
       0.212671 0.715160 0.072169;
       0.019334 0.119193 0.950227];
XYZ = MAT * RGB;

% Normalize for D65 white point
X = XYZ(1,:) / 0.950456;
Y = XYZ(2,:);
Z = XYZ(3,:) / 1.088754;

XT = X > T;
YT = Y > T;
ZT = Z > T;

Y3 = Y.^(1/3); 

fX = XT .* X.^(1/3) + (~XT) .* (7.787 .* X + 16/116);
fY = YT .* Y3 + (~YT) .* (7.787 .* Y + 16/116);
fZ = ZT .* Z.^(1/3) + (~ZT) .* (7.787 .* Z + 16/116);

L = reshape(YT .* (116 * Y3 - 16.0) + (~YT) .* (903.3 * Y), M, N);
a = reshape(500 * (fX - fY), M, N);
b = reshape(200 * (fY - fZ), M, N);

%if nargout < 2
%  L = cat(3,L,a,b);
%end
if ((nargout == 1) || (nargout == 0))
  L = cat(3,L,a,b);
end