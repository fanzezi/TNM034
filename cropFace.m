function [faceCrop] = cropFace(im)

gray = rgb2gray(im);
binary = gray < 255;

[x, y] = find(binary);

xmin = min(x(:));
ymin= min(y(:));
xmax = max(x(:));
ymax= max(y(:));

width = xmax-xmin;
height = ymax-ymin;

faceCrop = imcrop(im, [xmin, ymin, width, height]);

end

