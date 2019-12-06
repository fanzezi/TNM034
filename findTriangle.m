function [firstEyePos,secEyePos,mouthPos] = findTriangle(mask)
%Find the face triangle, by detecting eyes positions and mouth position.
    %Find Centroids

    %Make mask into logical and remove border centroids
    mask = logical(mask);
    

    %Get eye candidates
    stats = regionprops('table', mask, 'centroid', 'MaxFeretProperties');
    centroids = cat(1,stats.Centroid);
    centAxis = cat(1, stats.MaxFeretDiameter);
    %Find the amount of pontential eyes
    eyesDetected = size(stats.Centroid,1);

    %Detect the eyes
    %First eye
    j = 1;
    for i = 1:length(eyesDetected)
        if centAxis(i,j) > 30 && centAxis(i,j) < 60

            firstEye = centAxis(i,j);
            firstEyePos(1,1) = centroids(i,1);
            firstEyePos(1,2) = centroids(i,2);

        end
    end

    %Second Eye
    j = 1;
    for i = 1:eyesDetected
        if centAxis(i,j) > 30 && centAxis(i,j) < 60 && centAxis(i,j) ~= firstEye

            secondEye = centAxis(i,j);
            secEyePos(1,1) = centroids(i,1);
            secEyePos(1,2) = centroids(i,2);

            %secEyePos = reshape(secEyePos,[1,2]);
            break
        end
    end

    %Get eyes in right order
    if firstEyePos(1,1) > secEyePos(1,1)
        pre = secEyePos;
        post = firstEyePos;

        firstEyePos = pre;
        secEyePos = post;
    end


    % Find mouth
    for i = 1:eyesDetected
        if centroids(i,1) > firstEyePos(1,1) && centroids(i,1) < secEyePos(1,1) && centroids(i,2) > firstEyePos(1,2)

            mouthPos(1,1) = centroids(i,1);
            mouthPos(1,2) = centroids(i,2);

            break
        end
    end

    %hold on
    %plot(centroids(:,1),centroids(:,2),'b*')
    %hold off
end

