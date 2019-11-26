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

%White ligthning compensation
% 5% of the lightest pixels

image = imread('db1_14.jpg');
YCbCr = rgb2ycbcr(image);
YCbCr = im2double(YCbCr);

Y = YCbCr(:,:,1); 
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

% Y= normalize(Y, 255);
% Cb = normalize(Cb, 255);
% Cr = normalize(Cr, 255);

EyeMapC = (1./3) *((Cb.^2) +((1-Cr).^2) + (Cb./Cr));
%J = histeq(EyeMapC);
%figure
%imshow(EyeMapC);
%title('EyeMapC');

%Eye map L, erosion and dilate
SE = strel('disk', 10); %structure element
o = imdilate(Y, SE); %dilate
p = imerode(Y, SE); %erosion

EyeMapL = o./(p+1);

EyeMap = EyeMapC.*EyeMapL;
Dil = imdilate(EyeMap, SE);

%imshow(Dil, [])

test = mouthMap(image);
imshow(test, [])


