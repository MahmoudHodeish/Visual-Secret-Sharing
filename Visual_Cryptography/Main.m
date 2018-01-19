%Program for Construction of a two-out-of-two Visual Cryptography Scheme

%Author : Athi Narayanan S
%M.E, Embedded Systems,
%K.S.R College of Engineering
%Erode, Tamil Nadu, India.
%http://sites.google.com/site/athisnarayanan/
%s_athi1983@yahoo.co.in

%Program Description
%This program is the main entry of the application.
%This program generates a two-out-of-two Visual Cryptography Scheme shares.
%The input image for this program should be a binary image.
%The shares and the overlapping result of the shares are written as output.
%The Shares (1 & 2) can be printed in separate transparent sheets and overlapping them 
%reveals the secret image.

%Clear Memory & Command Window
clc;
clear all;
close all;

%Read Input Binary Secret Image
clc;
inImg=imread('E:\images\m1.bmp');
%  x=rgb2gray(x);
inImg=im2bw(inImg,0.4);
% inImg=unit8(inImg);
% maxpixel=max(x(:));
[m,n]=size(inImg);
AR=m/n;
disp(AR);
%  imwrite(inImg,'E:\images\inImg.bmp');
imshow(inImg);

%Visual Cryptography
tic;
[share1, share2, share12] = VisCrypt(inImg);
toc;
%disp(toc);
%Outputs
figure;imshow(share1);title('Share 1');
figure;imshow(share2);title('Share 2');

figure;imshow(share12);title('Overlapping Share 1 & 2');

imwrite(share1,'E:\images\vc\Share1.bmp');
imwrite(share2,'E:\images\vc\Share2.bmp');
imwrite(share12,'E:\images\vc\Overlapped.bmp');
 
[a,b]=size(share12);
AR=a/b;
%disp(AR);
B = imresize(share12, [m n]);
  Qualite=PSNR(inImg,B);
disp(Qualite);

 MSE=mse(inImg,B);
y=['The MSE= ',num2str(MSE)];
disp(y);
Qualite=PSNR(inImg,B);
r=['The PSNR= ',num2str(Qualite)];
disp(r);
   %UIQ calculation
block_size=8;
N = block_size.^2;
sum2_filter = ones(block_size);

img1_sq   = inImg.*inImg;
img2_sq   = B.*B;
img12 = inImg.*B;

img1_sum   = filter2(sum2_filter, inImg, 'valid');
img2_sum   = filter2(sum2_filter, B, 'valid');
img1_sq_sum = filter2(sum2_filter, img1_sq, 'valid');
img2_sq_sum = filter2(sum2_filter, img2_sq, 'valid');
img12_sum = filter2(sum2_filter, img12, 'valid');

img12_sum_mul = img1_sum.*img2_sum;
img12_sq_sum_mul = img1_sum.*img1_sum + img2_sum.*img2_sum;
numerator = 4*(N*img12_sum - img12_sum_mul).*img12_sum_mul;
denominator1 = N*(img1_sq_sum + img2_sq_sum) - img12_sq_sum_mul;
denominator = denominator1.*img12_sq_sum_mul;

quality_map = ones(size(denominator));
index = (denominator1 == 0) & (img12_sq_sum_mul ~= 0);
quality_map(index) = 2*img12_sum_mul(index)./img12_sq_sum_mul(index);
index = (denominator ~= 0);
quality_map(index) = numerator(index)./denominator(index);

quality = mean2(quality_map);
disp(quality);
