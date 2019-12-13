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
    all_vec(:,12) = [];
   
    % find mean image 
    mean_face = mean(all_vec, 2);
    
        % mean might not work 1/15 * all_vec_sum
    for i = 1:15
        % Subtract the mean face
        face_diff(:, i) = all_vec(:, i) - mean_face; 
    end
    %imshow(reshape(mean_face, [330,260]))
    
    % get eigenvector
    C = mtimes(face_diff',face_diff); 
    [eVec, ~] = eig(C);

    % only retain the top eigenfaces 
    top_eigenface = mtimes(face_diff,eVec);
%     top_eigen_face = max(top_eigen_face);
    % project the images into subspace
    weights = mtimes(top_eigenface',face_diff);
    % Save to database!
    save('database.mat','eVec', 'mean_face', 'weights', 'top_eigenface')
end
