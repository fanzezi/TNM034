function [test_weight] = getEigenface(im, mean_face, top_eigenface)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    % reshape Im
    [m,n] = size(im);
    images_vec = double(reshape(im, [m*n, 1]));
    
    % Subtract the mean face
    face_diff = images_vec - mean_face; 
    
    % knorr = face_diff
    % u - mean_face
    % uj - eigenfaces
    
    % get image weight
    test_weight = mtimes(top_eigenface', face_diff);
    
end
