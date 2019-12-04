function [ImgRot] = rotateImage(im)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Find eyes pos


% find point2 (point with larger x)
if A(1)>B(1)
  P2 = A; P1 = B;
else
  P2 = B; P1 = A;
end
% clockwise OR counterclockwise
if P2(2)<P1(2)
  w=-1; % clockwise
else
  w=+1; % counterclockwise
end
angle = w*atan(abs(P2(2)-P1(2))/(P2(1)-P1(1)))*180/pi; % deg
ImgRot = imrotate(Img,angle);

end

