function [ImgRot] = rotateImage(eyePos1, eyePos2, mask)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    % Rotate image
    % clockwise OR counterclockwise
    if eyePos2(1,2)<eyePos1(1,2)
      w=-1; % clockwise
    else
      w=+1; % counterclockwise
    end
    angle = w*atan(abs(eyePos2(1,2)-eyePos1(1,2))/(eyePos2(1,2)-eyePos1(1,2)));%*180/pi; % deg
    ImgRot = imrotate(mask,angle);

end

