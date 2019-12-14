function [testWeight] = getEigenface(im, meanFace, topEigenface)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    % reshape Im
    [m,n] = size(im);
    imagesVec = double(reshape(im, [m*n, 1]));
    
    % Subtract the mean face
    faceDiff = imagesVec - meanFace; 
    
    % get image weight
    testWeight = mtimes(topEigenface', faceDiff);
    
end
