clc;
clear all;

%% Test Image
% Change image file names and put images in the code folder
ref_img=imread('Lena_Original_image.tif');
test_img=imread('Lena_Restored_image.tif');

% To use with IQMs which need B&W Images
ref_bw=rgb2gray(ref_img);
test_bw=rgb2gray(test_img);

%% Run IQA
%Initialize Score varriable
Score={};

Score{1,1} =    {'VIF'};
addpath('MEX', 'TUTORIALS');

Score{1,2}=                 vifvec(ref_img,test_img);

for i=1:1:1
    Score{i,1}
    Score{i,2}
end
rmpath('MEX', 'TUTORIALS');