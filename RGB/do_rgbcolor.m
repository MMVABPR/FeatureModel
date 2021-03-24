function [ hist ] = do_rgbcolour( file )
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
hist = [reshape(rhist',1,256),reshape(ghist',1,256),reshape(bhist',1,256)]; %��?�¡��Ʀ�????�����ݡ� 256*3 ??????��?  

end