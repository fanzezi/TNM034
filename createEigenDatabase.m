function [top_eigenface] = createEigenDatabase()
    
    % Load files
    imagefiles = dir('/Users/FannyBanny/Documents/TNM034/DB1/*.jpg');
    nr_img = length(imagefiles);
    all_vec = zeros(85800,16);
    
    for i = 1:nr_img

        %Load file
        currFileName = imagefiles(i).name;
        % Color Correlation
        currImage = imread(currFileName(:,:));
        %currImage = rgb2gray(imresize(currImage,[330, 260]));
        currImage = faceDetection(currImage);
        %imshow(currImage)
        [m,n] = size(currImage);
        % Flatten images
        images_vec = double(reshape(currImage, [m*n, 1]));
        all_vec(:, i) = images_vec;
        
    end
    % Remove 12 from the database, because failure
    %all_vec(:,12) = [];
   
    % find mean image 
    mean_face = mean(all_vec, 2);
   
     % Subtract the mean face
    for i = 1:16
        face_diff(:, i) = all_vec(:, i) - mean_face; 
    end
    
    % get eigenvector
    C = mtimes(face_diff',face_diff); 
    [eVec, ~] = eig(C);

    % get eigenfaces 
    top_eigenface = mtimes(face_diff,eVec);
    % project the images into subspace
    weights = mtimes(top_eigenface',face_diff);
    
    % Save to database
    save('database.mat','eVec', 'mean_face', 'weights', 'top_eigenface')
end
