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

image = imread('db1_14.jpg');
%image = imresize(image, [0, 255]);
image = 255*image;
YCbCr = rgb2ycbcr(image);

Y = YCbCr(:,:,1); 
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);
 
% a = uint8(zeros(536,414));
% just_cb = cat(3,a,Cb,a);
% just_cr = cat(3,a,a,Cr);

EyeMapC = ((Cb.^2) +((255-Cr).^2) + (Cb./Cr))/3;
%EyeMapC = ((just_cb.^2) +((255-just_cr).^2) + (just_cb./just_cr))/3;
%EyeMapL = ...

figure
imshow(EyeMapC)
