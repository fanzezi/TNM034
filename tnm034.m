%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Project by: Fanny Andersson och Emma Algotsson.
% OBS!! runs only with matlab 2019b!
%
%function id = tnm034(im) 
% 
% im: Image of unknown face, RGB-image in uint8 format in the 
% range [0,255] 
% 
% id: The identity number (integer) of the identified person,
% i.e. 1, 2,..., 16 for the persons belonging to db1 
% and 0 for all other faces. 
% 
% Your program code. 
%%%%%%%%%%%%%%%%%%%%%%%%%%
% Translatera, rotera, skala, tonv?rde, kombinationer.
% returnera 0 f?r ok?nda ansikten
% detektera ansiktet
% normalisera ansiktet
clc
%Works for picture id's: 1,7,9,16
image = imread('DB1/db1_09.jpg');

% Color Correlation with Gray World compensation
image = colorCorr(image);

% Get image to YCbCr
YCbCr = rgb2ycbcr(image);
YCbCr = im2double(YCbCr);
Y = YCbCr(:,:,1); 
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);


% Creating a EyeMap
Eyemap = getEyeMap(Y, Cr, Cb);

% Create mouthMap
mouthMap = getMouthMap(image);

% Creating a FaceMask
FaceMask = facemask(Cr, Cb);

% Combinding FaceMask and Eyemap ( get interval )
Mask = FaceMask.*Eyemap;
% Find threshold values
%eyeMaxVal = max(max(Eyemap));
%mouMaxVal = max(max(mouthMap));


% Create the binary mask
zeroMask = zeros(size(Eyemap));
faceCol = zeroMask(1,:);
faceRows = zeroMask(:,1);
mask = zeros(size(zeroMask));

% Set value to 1 if ceritain interval of Cb and Cr
for i = 1:length(faceRows)
    for j = 1:length(faceCol)
        if Eyemap(i,j) > 0.45 || mouthMap(i,j) > 0.12
           mask(i,j) = 1;
        end   
    end
end

% Morphological operations to remove unnecessary blobs
SE = strel('disk',8);
mask = imdilate(mask, SE);
mask = imdilate(mask, SE);
mask = imerode(mask, SE);
mask = imclearborder(mask);

mask = Y.*mask;

% Get Eyes and mouth position
[eyePos1, eyePos2, mouthPos] = findTriangle(mask);
% Rotate the image based on the position of the eyes
ImgRot = rotateImage(eyePos1, eyePos2, mask);

Img = cropFace(Y, eyePos1, eyePos2, mouthPos);
imshow(Img, [])

% Training images
% Eigenfaces! 
ImgVector = reshape(Img, 1, []);
% OBS!!! This must change for the computer running!!!!!
imagefiles = dir('Macintosh HD/Anv�ndare/FannyBanny/Dokument/TNM034/DB1/*.jpg');
nfiles = length(imagefiles);

for ii = 1:nfiles
    currFileName = imagefiles(ii).name;
    currImage = rgb2gray(imread(currFileName));
    currImage = size(currImage);
    [m,n] = size(currImage);
    images = reshape(currImage, [m*n, 1]);
end





