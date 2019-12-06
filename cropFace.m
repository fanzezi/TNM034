function [faceCrop] = cropFace(im, eyePos1, eyePos2, mouthPos)

    % Cropping face to have the position of the eyes at the same level
    eyeCenter = round((eyePos1 + eyePos2)./2);
    eyedist = round(abs(eyePos1 - eyePos2));
    dist = round(abs(eyeCenter - mouthPos));

    xmin = max((eyeCenter(1) - eyedist(1)),0);
    xmax = xmin + 2*eyedist(1);
    ymin = max((eyeCenter(2)-(3/5 * dist(2))), 0);
    % 11/5 ind of 2
    ymax = ymin + 2 * dist(2);

    width = xmax-xmin;
    height = ymax-ymin;
    
    faceCrop = imcrop(im, [xmin ymin width height]);

end

