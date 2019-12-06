function mouthMap = getMouthMap(im)

YCbCr = rgb2ycbcr(im); %rgb till ycbcr
YCbCr = im2double(YCbCr); %change to double

Cb = YCbCr(:,:,2);
Cr = YCbCr(:,:,3);

crcb = Cr./Cb; %cr is larger than cb in mouth region
cr2 = Cr.^2;

%mean of cr^2 and cr/cb to get eta
eta = 0.95*(sum(sum(cr2))/(sum(sum(crcb))));

mouthMap = cr2.*((cr2-(eta.*crcb)).^2);

SE = strel('disk', 10);
mouthMap = imclose(mouthMap, SE);
%mouthMap = imdilate(mouthMap, SE);

mouthMap = mouthMap.*100;

end

