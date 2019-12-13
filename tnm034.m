%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Project by: Fanny Andersson och Emma Algotsson.
% OBS!! runs only with matlab 2019b!
%
%function id = tnm034(im) 
% 
% im: Image of unknown face, RGB-image in uint8 format in the 
% range [0,255] 
% 
% id: The identity number (integer) of the identified person,
% i.e. 1, 2,..., 16 for the persons belonging to db1 
% and 0 for all other faces. 
% 
% Your program code. 
%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear

%Do not work for picture id: 12  (02 weird crop)
image = imread('DB1/db1_06.jpg');

% Detect face
[Img] = faceDetection(image);

% Get Eigenfaces
createEigenDatabase();
load('database.mat');

% Get Eigenface weight for Image
Img_weight = getEigenface(Img, mean_face);
weight_diff = zeros(1,length(weights));

 for i=1:length(weights)
     weight_diff(:, i) = norm(Img_weight - weights(:,i));
     %distance(i) = weight_diff;

 end   

 [min_dist, bestID] = min(weight_diff);
%bestID
id = bestID;



