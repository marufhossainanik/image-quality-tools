clear;
clc;

%% Setup IQA Enviornment
addpath('metrix_mux','ESIM','IWSSIM');

%Initial Setup
configure_metrix_mux

% Change image file names and put images in the code folder
%% Reference Image
ref_img=imread('Lena_Original_image.tif');

%% Test Image
test_img=imread('Lena_Restored_image.tif');
% test_img=imgaussfilt(test_img,100);

%% Additional Options
% Uncomment if images are not of same size
% ref_img = imresize(ref_img, [512 512]);
% test_img = imresize(test_img, [512 512]);

% To use with IQMs which need B&W Images
ref_img_bw=rgb2gray(ref_img);
test_img_bw=rgb2gray(test_img);

%% Initialize Score varriable
Score={};

%Lable of Scores
Score{1,1} =    {'MSE'};
Score{2,1} =    {'SNR'};
Score{3,1} =    {'PSNR'};
Score{4,1} =    {'WSNR'};
Score{5,1} =    {'VSNR'};
Score{6,1} =    {'SSIM'};
Score{7,1} =    {'MSSIM'};
Score{8,1} =    {'UQI'};
Score{9,1} =    {'NQM'};
Score{10,1} =   {'PSNRHVSM'};
Score{11,1} =   {'PSNRHVS'};
Score{12,1} =   {'FSIM'};
Score{13,1} =   {'FSIMc'};
Score{14,1} =   {'VSI'};
Score{15,1} =   {'MDSI'};
Score{16,1} =   {'WPSNR'};
Score{17,1} =    {'ESSIM'};
Score{18,1} =    {'GMSD'};
Score{19,1} =    {'RFSIM'};
Score{20,1} =    {'ESIM'};
Score{21,1} =    {'IWSSIM'};
Score{22,1}=     {'VIF'};

%% Run IQAs
%Calculate Scores
Score{1,2}=                 metrix_mux(ref_img, test_img, 'MSE');
Score{2,2}=                 metrix_mux(ref_img, test_img, 'SNR');
Score{3,2}=                 metrix_mux(ref_img, test_img, 'PSNR');
Score{4,2}=                 metrix_mux(ref_img, test_img, 'WSNR');
Score{5,2}=                 metrix_mux(ref_img, test_img, 'VSNR');
Score{6,2}=                 metrix_mux(ref_img, test_img, 'SSIM');
Score{7,2}=                 metrix_mux(ref_img, test_img, 'MSSIM');
Score{8,2}=                 metrix_mux(ref_img, test_img, 'UQI');
Score{9,2}=                 metrix_mux(ref_img, test_img, 'NQM');
[Score{10,2},Score{11,2}]=  psnrhvsm(ref_img,test_img);
[Score{12,2},Score{13,2}]=  FeatureSIM(ref_img, test_img);
Score{14,2}=                VSI(ref_img,test_img);
Score{15,2}=                MDSI(ref_img,test_img);
Score{16,2}=                wpsnr((ref_img_bw/255),(test_img_bw/255));
Score{17,2}=                ESSIM(ref_img, test_img);
Score{18,2}=                GMSD(ref_img_bw, test_img_bw);
Score{19,2}=                RFSIM(ref_img_bw, test_img_bw);
Score{20,2}=                ESIM(ref_img, test_img);
Score{21,2}=                iwssim(ref_img_bw, test_img_bw, 1,2);
oldDir = pwd;
cd('./VIF');
Score{22,2}=                vifvec(ref_img,test_img);
cd(oldDir);

%% Print IQA Score
for i=1:1:22
    Score{i,1}
    Score{i,2}
end

%% Save IQA Score
save("IQA_score.mat","Score");