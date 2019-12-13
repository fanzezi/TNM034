function [test_weight] = getEigenface(im, mean_face)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    % reshape Im
    [m,n] = size(im);
    images_vec = double(reshape(im, [m*n, 1]));
    
    % Subtract the mean face
    face_diff = images_vec - mean_face; 
    
    % knorr = face_diff
    % u - mean face
    % uj - eigenfaces
    
    % get eigenvector
    tmp = mtimes(face_diff',face_diff);
    [eVec, ~] = eig(tmp);
    
    % only retain the top eigenfaces 
    %num_eig = 16;
    top = mtimes(face_diff,eVec);
    % project the images into subspace
    test_weight = mtimes(top',face_diff);
    
end
