function [faceCrop] = cropFace(im, eyePos1, eyePos2, mouthPos)

eyeCenter = round((eyePos1 + eyePos2)./2);
eyedist = round(abs(eyePos1 - eyePos2));
dist = round(abs(eyeCenter - mouthPos));

xmin = max((eyeCenter(1) - eyedist(1)),0);
xmax = xmin + 2*eyedist(1);
ymin = max((eyeCenter(2)-(3/5 * dist(2))), 0);
ymax = ymin + 11/5 * dist(2);

width = xmax-xmin;
height = ymax-ymin;
faceCrop = imcrop(im, [xmin ymin width height]);


% gray = rgb2gray(im);
% binary = gray < 255;
%[x, y] = find(binary);

% xmin = min(x(:));
% ymin= min(y(:));
% xmax = max(x(:));
% ymax= max(y(:));

% width = abs(xmax-xmin);
% height = abs(ymax-ymin);
% 
% faceCrop = imcrop(im, [xmin, ymin, width, height]);


end

