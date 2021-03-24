
%% Initialization
clear ;
close all;
clc;
run('./vlfeat-0.9.20/toolbox/vl_setup.m')
%%  =========== Part 0: loading and saving file path =============
path = '../ddsm_path-1.txt';
save_path = '../result/';
if ~exist(save_path,'dir')
    mkdir(save_path);
end

%% =========== Part 1: Loading  Data =============

tic; % 开始计算时间
fprintf('Loading  Data ...\n')
SiftFeats=[];
D = importdata(path);
len = length(D);

%% =========== Part 2: Extract  SiftFea =============
for i = 1 : length(D)
    a = imread( D{i});
    if ndims(a) == 3
        I = im2double(rgb2gray(a));
    else
        I = im2double(a);
    end
    I = single(I) ;
    [frames, descrips] = vl_sift(I);
    descrips=double(descrips');
    k = size(descrips,1);
    fprintf("the %d descrips is : %d-by-128 .",i,k);
    
    if(size(descrips,1)>100||size(descrips,1)==100)
        
        descrips=descrips(randperm(size(descrips,1),100),:);
        disp(size(descrips));
    end
    SiftFeats=[SiftFeats;descrips];
    fprintf('Finished:%d--%d\n',i,len);
end

sift_=SiftFeats;

%% =========== Part 3: K-means =============

% K is the dimension of the features that you want to get in the countVectors
K=20;
%
initMeans = sift_(randperm(size(sift_,1),K),:);
%
[KMeans] = K_Means(sift_,K,initMeans);

% [ALLSiftVectors] = get_countVectors(KMeans,K,size(sift_,1));

%% =========== Part 4: Saving  Data =============

% sift=ALLSiftVectors;

toc;  % 终止时间
disp(['运行时间: ',num2str(toc)]);

% csvwrite([save_path 'sift.csv'],sift);
% save([save_path 'sift.mat'],'sift');



