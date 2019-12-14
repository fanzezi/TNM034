function [Img] = faceDetection(image)

% Normalize the image with color correlation
% Detect the face with finding the face mask, eyes candidates and mouth candidates
% Returns the rotated and cropped image

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
    
    % Create the binary mask
    zeroMask = zeros(size(Eyemap));
    faceCol = zeroMask(1,:);
    faceRows = zeroMask(:,1);
    eyeMask = zeros(size(zeroMask));
    moumask = zeros(size(zeroMask));

    
    %Make binary mask
    eyeMask = Eyemap > 0.45; 
    mouMask = mouthMap > 0.12;
    
    % Morphological operations to remove unnecessary blobs from EyeMap
    SE = strel('disk',8);
    eyeMask = imdilate(eyeMask, SE);
    eyeMask = imdilate(eyeMask, SE);
    eyeMask = imerode(eyeMask, SE);
    eyeMask = imclearborder(eyeMask);

    % Remove impossible eye candidates
    [height, width] = size(eyeMask);
    
    statsEye = regionprops(eyeMask, 'centroid',  'PixelIdxList', 'MaxFeretProperties');
    centAxisEyes = cat(1, statsEye.MaxFeretDiameter);
    centroidseye = cat(1, statsEye.Centroid);
    [numOfEyes, ~] = size(centroidseye);

     for i=1:numOfEyes  
       if centroidseye(i,2) > height*0.66 || centroidseye(i,2) < height*0.3
         eyeMask(statsEye(i).PixelIdxList) = 0;
       end
       if centAxisEyes(i,1) > 70
           eyeMask(statsEye(i).PixelIdxList) = 0;
       end
     end
     
     % -- 
  
    
    % Morphological operations to remove unnecessary blobs from MouthMap
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
    
    
 
    % Get Eyes and mouth position
    [eyePos1, eyePos2, mouthPos] = findTriangle(eyeMask, mouMask);
    
    % Rotate the image
    ImgRot = rotateImage(eyePos1, eyePos2, mask);
    % Crop face
    Img = cropFace(Y, eyePos1, eyePos2, mouthPos);  
    
  
end

