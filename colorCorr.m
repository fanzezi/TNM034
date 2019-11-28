function output_image = colorCorr(image)
%Color Correlation

red = image(:,:,1);
green = image(:,:,2);
blue = image(:,:,3);

r_mean = 1/mean(red(:));
g_mean = 1/mean(green(:));
b_mean = 1/mean(blue(:));

max_RGB = max(max(r_mean,g_mean),b_mean);

%normalize

r_mean = r_mean/max_RGB;
g_mean = g_mean/max_RGB;
b_mean = b_mean/max_RGB;

red = red * r_mean;
green = green * g_mean;
blue = blue * b_mean;

output_image = cat(3, red,green,blue);
end

