%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Project by: Fanny Andersson och Emma Algotsson.
%
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

image = imread('DB1/db1_07.jpg');

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

%Create mouthMap
mouthMap = getMouthMap(image);


%Creating a FaceMask
FaceMask = facemask(Cr, Cb);

Mask = FaceMask.*Eyemap;

eyeMaxVal = max(max(Eyemap));
mouMaxVal = max(max(mouthMap));


%Create the binary mask
    zeroMask = zeros(size(Eyemap));
    faceCol = zeroMask(1,:);
    faceRows = zeroMask(:,1);
    mask = zeros(size(zeroMask));

    %Set value to 1 if ceritain interval of Cb and Cr
    for i = 1:length(faceRows)
        for j = 1:length(faceCol)
            if Eyemap(i,j) > 0.45 || mouthMap(i,j) > 0.12
                mask(i,j) = 1;
            end   
        end
    end
    
    SE = strel('disk',8);
    mask = imdilate(mask, SE);
    mask = imdilate(mask, SE);
    %faceMask = imdilate(faceMask, SE);
    mask = imerode(mask, SE);
    
%eyeMask = mask.*YCbCr;

%Centroids --- 

%Make mask into logical and remove border centroids
mask = logical(mask);
mask = imclearborder(mask);
%Get eye candidates
stats = regionprops('table', mask, 'centroid', 'MaxFeretProperties');
centroids = cat(1,stats.Centroid);
centAxis = cat(1, stats.MaxFeretDiameter);
%Find the amount of pontential eyes
eyesDetected = size(stats.Centroid,1);

%Detect the eyes
%First eye
j = 1;
for i = 1:length(eyesDetected)
    if centAxis(i,j) > 38 && centAxis(i,j) < 60
       firstEye = centAxis(i,j);
      
       firstEyePos(1,1) = centroids(i,1); 
           
       firstEyePos(1,2) = centroids(i,2);
           
    end 
end
%Second Eye
j = 1;
for i = 1:eyesDetected
    if centAxis(i,j) > 30 && centAxis(i,j) < 60 && centAxis(i,j) ~= firstEye
       secondEye = centAxis(i,j);
       
       secEyePos(1,1) = centroids(i,1); 
            
       secEyePos(1,2) = centroids(i,2);
           
       %secEyePos = reshape(secEyePos,[1,2]);
       break
    end   
end

imshow(mask)
hold on
plot(firstEyePos)
%plot(centroids(:,1),centroids(:,2),'b*')
hold off
%Im = rotateImage(mask);


