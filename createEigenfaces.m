function [] = createEigenfaces()

    dirname = 'Documents\MATLAB\TNM034-Abob\TNM034\images\DB1\'; 
    files = dir(fullfile(dirname, '*.jpg'));
    files  ={files.name}';
    nr_img = numel(files);
    images = [];
    for i = 1:nr_img
        if i<10
            imgDB = refwhite(imread(dirname, 'db1_0', int2str(i), '.jpg'));    
        end
        if i >=10
            imgDB = refwhite(imread(dirname, 'db1_', int2str(i), '.jpg'));
        end
        images(:,i) = imgDB(:);
    end
    

    % find mean image
    x = im2double(images);
    mean_face = mean(x,2); %(1/num_eigenfaces)*sum(images,2)
    shifted = images-repmat(mean_face,1,nr_img); 
    
    % get eigenvector
    tmp = (shifted').*shifted;
    %[eVec, ~] = pca(images'); 
    [eVec, ~] = eig(tmp);
   
    % only retain the top eigenfaces 
    %num_eig = 16;
    top = shifted.*eVec;
    top = top(:, 1:nr_img);
    % project the images into subspace
    weights = (top').*shifted;
    
    save('database.mat','eVec', 'mean_face', 'weights')
    
    
end

