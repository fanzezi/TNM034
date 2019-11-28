function eyemap = getEyeMap(Y, Cr, Cb)
%Creating an EyeMap based through EyemapC & EyeMapL

    %EyeMapC
    g = 1./3;
    ccb = Cb.^2;
    ccr = (1 - Cr).^2;
    cbcr = Cb./Cr;

    eyeMapC = g*(ccb + ccr + cbcr);

    % EyeMapL
    %Structure Element
    SE = strel('disk',10);
    o = imdilate(Y, SE);
    p = imerode(Y, SE) + 1;

    eyeMapL = o./p;

    eyeMap = eyeMapC.*eyeMapL;
    eyemap = imdilate(eyeMap, SE);
    
end

