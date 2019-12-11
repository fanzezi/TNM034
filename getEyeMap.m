function [eyemap] = getEyeMap(Y, Cr, Cb)

EyeMapC = (1./3) *((Cb.^2) +((1-Cr).^2) + (Cb./Cr));

%Eye map L, erosion and dilate
SE = strel('disk', 10); %structure element
o = imdilate(Y, SE); %dilate
p = imerode(Y, SE) + 1; %erosion

EyeMapL = o./p;

EyeMap = EyeMapC.*EyeMapL;
eyemap = imdilate(EyeMap, SE);


end

