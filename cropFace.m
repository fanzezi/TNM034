function [faceCrop] = cropFace(im, eyePos1, eyePos2, mouthPos)

eyeCenter = round((eyePos1 + eyePos2)./2); % find center between eyes
eyedist = round(abs(eyePos1 - eyePos2)); % find distance between eyes
dist = round(abs(eyeCenter - mouthPos)); % find distance between mouth and eyes

xmin = max((eyeCenter(1) - eyedist(1)),0); % min X value
ymin = max((eyeCenter(2)-(3/5 * dist(2))), 0); % min Y value, 1*dist(2) cuts of bit of mouth 

width = 2*eyedist(1); %horizontal distant
height = 2*dist(2); %vertical distant, 2* crops chin and x>2 dont

faceCrop = imcrop(im, [xmin ymin width height]);

end

