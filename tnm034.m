%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Project by: Fanny Andersson och Emma Algotsson.
% OBS!! runs only with matlab 2019b!
%
function id = tnm034(im) 
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
   
    % Detect face
    Img = faceDetection(im);
    if Img == 0
        id = 0;
        return
    end

    % Get Eigenfaces
    createEigenDatabase();
    load('database.mat');

    % Get Eigenface weight for Image
    Img_weight = getEigenface(Img, meanFace, topEigenface);
    weight_diff = zeros(1,length(weights));

    %Get best fitting ID
     for i=1:length(weights)
         weight_diff(:, i) = norm(Img_weight - weights(:,i));
     end   

    [min_dist, best_ID] = min(weight_diff);
    
    %bestID
    if min_dist < 30
        id = best_ID;
    else
        id = 0;
    end
end





