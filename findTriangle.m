function [firstEyePos,secEyePos,mouthPos] = findTriangle(eyeMask, mouMask)
%Find the face triangle, by detecting eyes positions and mouth position.
    %Find Centroids

    %Make mask into logical and remove border centroids
    eyeMask = logical(eyeMask);
    

    %Get eye candidates
    statsEye = regionprops('table', eyeMask, 'centroid', 'MaxFeretProperties');
    eyeCentroids = cat(1,statsEye.Centroid);
    centAxisEyes = cat(1, statsEye.MaxFeretDiameter);
    %Find the amount of pontential eyes
    eyesDetected = size(statsEye.Centroid,1);
    
    %Get mouth candidates
    statsMouth = regionprops('table', mouMask, 'centroid', 'MaxFeretProperties');
    mouCentroids = cat(1,statsMouth.Centroid);
    %imshow(mouMask)
    centAxis = cat(1, statsMouth.MaxFeretDiameter);
    %Find the amount of pontential mouths
    mouthCandidates = size(statsMouth.Centroid,1);
    
    %Detect the eyes
    %First eye
    [height, width] = size(mouMask);
    
    %[X,Y] = ginput()
  
  
    for i = 1:length(eyesDetected)
       
        if  centAxisEyes(i,1) < 70 && centAxisEyes(i,1) > 30
            firstEye = centAxisEyes(i,1);
            firstEyePos(1,1) = eyeCentroids(i,1);
            firstEyePos(1,2) = eyeCentroids(i,2);
            break
        end
    end
    %First eye level
    intervalVal = firstEyePos(1,2) * 0.1;
    upperInt = firstEyePos(1,2) - intervalVal;
    lowerInt = firstEyePos(1,2) + intervalVal;
    
    %Second Eye
    j = 1;
    for i = 1:eyesDetected
        if centAxisEyes(i,j) ~= firstEye
            if  eyeCentroids(i,2) < lowerInt && eyeCentroids(i,2) > upperInt% && centAxisEyes(i,j) > 30 && centAxisEyes(i,j) < 70
                
                secondEye = centAxisEyes(i,j);
                secEyePos(1,1) = eyeCentroids(i,1);
                secEyePos(1,2) = eyeCentroids(i,2);

                %secEyePos = reshape(secEyePos,[1,2]);
                break
            end
                
        else
            if eyeCentroids(i,j) ~= firstEyePos(1,1)
               
                %secondEye = centAxisEyes(i,j);
                secEyePos(1,1) = eyeCentroids(i,1);
                secEyePos(1,2) = eyeCentroids(i,2);

                %secEyePos = reshape(secEyePos,[1,2]);
                break
            end
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
    % Munnen ligger alltid på undre delen av bilden (antal y-koord / 2 )
    for i = 1:mouthCandidates
        %if centroids(i,1) > firstEyePos(1,1) && centroids(i,1) < secEyePos(1,1) && centroids(i,2) > firstEyePos(1,2)
        if mouCentroids(i,2) > (size(eyeMask)/2)
            
            mouthPos(1,1) = mouCentroids(i,1);
            mouthPos(1,2) = mouCentroids(i,2);

            break
        end
    end
    
    %imshow(eyeMask)
    %hold on
    %plot(firstEyePos,secEyePos,'b*')
    %hold off
end

