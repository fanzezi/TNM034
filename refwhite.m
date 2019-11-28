function refwhite = refwhite(im)

%low = quantile(im(:), Lower);
%up = quantile(im(:), 0.95);
HSV = rgb2hsv(im);
V = HSV(:,:,3);
vmean = 255*mean(V(:));

red = im(:,:,1);
green = im(:,:,2);
blue = im(:,:,3);

r_mean = mean(red(:));
g_mean = mean(green(:));
b_mean = mean(blue(:));

red = uint8(double(red) * vmean /r_mean);
green = uint8(double(green) * vmean /g_mean);
blue = uint8(double(blue) * vmean /b_mean);

refwhite = cat(3, red, green, blue);

end

