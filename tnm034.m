%%%%%%%%%%%%%%%%%%%%%%%%%% 
%function id = tnm034(im) 
% 
% im: Image of unknown face, RGB-image in uint8 format in the 
% range [0,255] 
% 
% id: The identity number (integer) of the identified person,
% i.e. ?1?, ?2?,...,?16? for the persons belonging to ?db1? 
% and ?0? for all other faces. 
% 
% Your program code. 
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Translatera, rotera, skala, tonv?rde, kombinationer.
% returnera 0 f?r ok?nda ansikten
% detektera ansiktet
% normalisera ansiktet

image = imread('DB1/db1_01.jpg');

% Color Correlation with Gray World compensation
image = colorCorr(image);

%EyeMap, EyemapC and EyeMapL
%Creating EyemapC & EyeMapL

%Get image to YCbCr
YCbCr = rgb2ycbcr(image);
YCbCr = im2double(YCbCr);

Y = YCbCr(:,:,1); 
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

%EyeMapC
g = 1./3;
ccb = Cb.^2;
ccr = (1 - Cr).^2;
cbcr = Cb./Cr;

EyeMapC = g*(ccb + ccr + cbcr);

% EyeMapL
%Structure Element
SE = strel('disk',10);
o = imdilate(Y, SE);
p = imerode(Y, SE) + 1;

EyeMapL = o./p;

%imshow(EyeMapL)

EyeMap = EyeMapC.*EyeMapL;
Eyemap = imdilate(EyeMap, SE);

%imshow(EyeMap) 
%------------------------

