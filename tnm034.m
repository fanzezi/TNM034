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
clear

%Works for picture id's: 12, 13, 15 (02 weird crop)
% Måste croppa till samma storlek för eigenfaces!!
image = imread('DB1/db1_06.jpg');

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
eyeMask = zeros(size(zeroMask));
moumask = zeros(size(zeroMask));

% Set value to 1 if ceritain interval of Cb and Cr
% for i = 1:length(faceRows)
%     for j = 1:length(faceCol)
%         if Eyemap(i,j) > 0.45 %|| mouthMap(i,j) > 0.12
%            mask(i,j) = 1;
%         end   
%     end
% end
eyeMask = Eyemap > 0.45;
mouMask = mouthMap > 0.12;


% Morphological operations to remove unnecessary blobs
% From EyeMap
SE = strel('disk',8);
eyeMask = imdilate(eyeMask, SE);
eyeMask = imdilate(eyeMask, SE);
eyeMask = imerode(eyeMask, SE);
eyeMask = imclearborder(eyeMask);

[height, width] = size(eyeMask);
statsEye = regionprops(eyeMask, 'centroid',  'PixelIdxList');
%[~, eyeCandidates] = size(statsEye.Centroid);
centroidseye = cat(1, statsEye.Centroid);
[numOfEyes, ~] = size(centroidseye);

 for i=1:numOfEyes  
   if centroidseye(i,2) > height*0.66 || centroidseye(i,2) < height*0.3
     eyeMask(statsEye(i).PixelIdxList) = 0;
   end
 end

 imshow(eyeMask)
 
% From MouthMap
statsMouth = regionprops(mouMask, 'centroid');
centroidsMouth = cat(1, statsMouth.Centroid);
[numOfMou, ~] = size(centroidsMouth);
if numOfMou > 1

    mouMask = imdilate(mouMask, SE);
    mouMask = imerode(mouMask, SE);
    mouMask = imerode(mouMask, SE);
    mouMask = imdilate(mouMask, SE);
    mouMask = imclearborder(mouMask);
end
% Merge
mask = mouMask|eyeMask;
%mask = Y.*mask;


% Get Eyes and mouth position
[eyePos1, eyePos2, mouthPos] = findTriangle(eyeMask, mouMask);
% Rotate the image based on the position of the eyes
ImgRot = rotateImage(eyePos1, eyePos2, mask);

%stats = regionprops(ImgRot, 'centroid');
%eyeCentroids = cat(1,stats.Centroid)
% eyePos1
% eyePos2
% figure;
% 
% [X,Y] = ginput()
Img = cropFace(Y, eyePos1, eyePos2, mouthPos);
imshow(Img)

% Training images
% Eigenfaces! 
ImgVector = reshape(Img, 1, []);
% OBS!!! This must change for the computer running!!!!!
imagefiles = dir('/Users/FannyBanny/Documents/TNM034/DB1/*.jpg');
nfiles = length(imagefiles);

%Read images
for i = 1:nfiles
    currFileName = imagefiles(i).name;
    currImage = colorCorr(imread(currFileName(:,:)));
    currImage = rgb2gray(imresize(currImage,[330, 260]));
    [m,n] = size(currImage);
    % Flatten images
    images_vec = double(reshape(currImage, [m*n, 1]));
    
    % Get mean face vector
    all_vec(:, i) = images_vec;
    avg_face_vec = mean(all_vec, 2);
    
    %imshow(reshape(avg_face_vec(:,1),[330, 260]))
    
    % Subtract the mean face
    Image_subMean(:, i) = images_vec - avg_face_vec;
    
    %Calculate the ordered eigenvectora and eigenvalues
    %[evectors, score, evalues] = pca(currImage);
    
    %Find the covariance matrix C
    % C size of MxM, returns M eigenvectors size 16 x 1
    C = mtimes(Image_subMean',Image_subMean);
    
    %Find the best eigenvectors from AA'
    % U = best eigenvectors
    
    %u = Image_subMean'.*C;
    
end

% Eigenfaces








    
%sum_images = double(zeros(m,n));
%compute the average face vector
%mean_face = 

%subtract the mean face
    
%Compute the convariance matrix C






