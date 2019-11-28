function [faceMask] = facemask(Cr, Cb)
%Creating a face mask to detect face

    %Create the binary mask
    zeroMask = zeros(size(Cr));
    faceCol = zeroMask(1,:);
    faceRows = zeroMask(:,1);
    faceMask = zeros(size(zeroMask));

    %Set value to 1 if ceritain interval of Cb and Cr
    for i = 1:length(faceRows)
        for j = 1:length(faceCol)
            if Cr(i,j) < 0.6 && Cr(i,j) > 0.51 && Cb(i,j) < 0.56 && Cb(i,j) > 0.4
                faceMask(i,j) = 1;
            end
        end
    end

    %Do morphological operations so remove noise
    SE = strel('disk',8);
    faceMask = imdilate(faceMask, SE);
    faceMask = imdilate(faceMask, SE);
    faceMask = imdilate(faceMask, SE);
    faceMask = imerode(faceMask, SE);


end

