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
clc

image = imread('DB1/db1_10.jpg');

% Color Correlation with Gray World compensation
image = colorCorr(image);

%Get image to YCbCr
YCbCr = rgb2ycbcr(image);
YCbCr = im2double(YCbCr);

Y = YCbCr(:,:,1); 
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);


%Creating a EyeMap
Eyemap = getEyeMap(Y, Cr, Cb);


%Creating a FaceMask
FaceMask = facemask(Cr, Cb);

imshow(FaceMask)

