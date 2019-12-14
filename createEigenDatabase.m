function [topEigenface] = createEigenDatabase()
    
    % Load files
    imagefiles = dir('/Users/FannyBanny/Documents/TNM034/DB1/*.jpg');
    numImg = length(imagefiles);
    allVec = zeros(85800,16);
    
    for i = 1:numImg

        %Load file
        currFileName = imagefiles(i).name;
        % Color Correlation
        currImage = imread(currFileName(:,:));
        %currImage = rgb2gray(imresize(currImage,[330, 260]));
        currImage = faceDetection(currImage);
        %imshow(currImage)
        [m,n] = size(currImage);
        % Flatten images
        imagesVec = double(reshape(currImage, [m*n, 1]));
        allVec(:, i) = imagesVec;
        
    end
    % Remove 12 from the database, because failure
    %all_vec(:,12) = [];
   
    % find mean image 
    meanFace = mean(allVec, 2);
   
     % Subtract the mean face
    for i = 1:16
        faceDiff(:, i) = allVec(:, i) - meanFace; 
    end
    
    % get eigenvector
    C = mtimes(faceDiff',faceDiff); 
    [eVec, ~] = eig(C);

    % get eigenfaces 
    topEigenface = mtimes(faceDiff,eVec);
    % project the images into subspace
    weights = mtimes(topEigenface',faceDiff);
    
    % Save to database
    save('database.mat','eVec', 'meanFace', 'weights', 'topEigenface')
end
