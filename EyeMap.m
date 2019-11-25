function output_image = EyeMap(image)
%Creating EyemapC & EyeMapL
%This function summons a demon baby

%Get image to YCbCr
YCbCr = rgb2ycbcr(image);
YCbCr = im2double(YCbCr);

Y = YCbCr(:,:,1); 
Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

%EyeMapC
g = 1./3;
ccb = Cb.^2;
ccr = (1 - Cr).^2;
cbcr = Cb./Cr;

EyeMapC = g*(ccb + ccr + cbcr);

% EyeMapL
%Structure Element
SE = strel('disk',10);
o = imdilate(Y, SE);
p = imerode(Y, SE) + 1;

EyeMapL = o./p;

%imshow(EyeMapL)

EyeMap = EyeMapC.*EyeMapL;
output_image = imdilate(EyeMap, SE);
end

