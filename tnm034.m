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

% White lighting compensation


image = imread('DB0/db0_4.jpg');
YCbCr = rgb2ycbcr(image);
%a = uint8(zeros(size(YCbCr)));
YCbCr = im2double(YCbCr);

Y = YCbCr(:,:,1); 
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

%16 - 240
g = 1./3;
ccb = Cb.^2;
ccr = (1 - Cr).^2;
cbcr = Cb./Cr;


%Inte klar

%just_cb = cat(3,a,Cb,a);
%just_cr = cat(3,a,a,Cr);
EyeMapC = g*(ccb + ccr + cbcr);
%EyeMapC = ((Cb.^2) +((255-Cr).^2) + (Cb./Cr))/3;
%EyeMapC = ((just_cb.^2) +((255-just_cr).^2) + (just_cb./just_cr))/3;

%figure
%imshow(EyeMapC)

%EyeMapL = ...

%igray = rgb2gray(image);
%igray = ~igray;

%Structure Element
SE = strel('disk',10);
o = imdilate(Y, SE);
p = imerode(Y, SE) + 1;

EyeMapL = o./p;

%imshow(EyeMapL)

EyeMap = EyeMapC.*EyeMapL;
Dil = imdilate(EyeMap, SE);

imshow(Dil)


