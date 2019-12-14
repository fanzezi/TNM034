function [firstEyePos,secEyePos,mouthPos] = findTriangle(eyeMask, mouMask)
%Find the face triangle, by detecting eyes positions and mouth position.
    %Find Centroids

    %Make mask into logical and remove border centroids
    eyeMask = logical(eyeMask);
    
    %Get eye candidates
    statsEye = regionprops('table', eyeMask, 'centroid', 'MaxFeretProperties');
    eyeCentroids = cat(1,statsEye.Centroid);
    [m] = size(eyeCentroids);
    if m == 0
        return % Return if no eyes found!
    end
    centAxisEyes = cat(1, statsEye.MaxFeretDiameter);
    %Find the amount of pontential eyes
    eyesDetected = size(statsEye.Centroid,1);
    
    %Get mouth candidates
    statsMouth = regionprops('table', mouMask, 'centroid', 'MaxFeretProperties');
    mouCentroids = cat(1,statsMouth.Centroid);
    [m] = size(mouCentroids);
    if m == 0
        return % Return if no mouth found!
    end
    centAxis = cat(1, statsMouth.MaxFeretDiameter);
    %Find the amount of pontential mouths
    mouthCandidates = size(statsMouth.Centroid,1);

    [height, width] = size(mouMask);   
   
        % Find mouth
        for i = 1:mouthCandidates
            % The mouth can only be on the lower part between of the image
            if mouCentroids(i,2) > (size(eyeMask)/2)     
                mouthPos(1,1) = mouCentroids(i,1);
                mouthPos(1,2) = mouCentroids(i,2);
                break
            end
        end 

        % Detect the eyes

        % Find first eye 
        % For images where ther is more than 2 candidates
        if eyesDetected > 2
            for i = 1:eyesDetected
                [x,y] = max(eyeCentroids(:,1));
                if eyeCentroids(i,1) == x
                    secEyePos(1,1) = eyeCentroids(i,1);
                    secEyePos(1,2) = eyeCentroids(i,2);
                end       
            end  
            
            diff_mouth_1 = secEyePos(1,1) - mouthPos(1,1);
            smallest_diff = 9999;
            smallest_index = 0;
            for i = 1:eyesDetected-1    
                diff_mouth_2 = eyeCentroids(i,1) - mouthPos(1,1);
                if abs(diff_mouth_1) - abs(diff_mouth_2) < smallest_diff
                    smallest_diff = abs(abs(diff_mouth_1) - abs(diff_mouth_2));
                    smallest_index = i;
                end 
            end
            firstEyePos(1,1) = eyeCentroids(smallest_index,1);
            firstEyePos(1,2) = eyeCentroids(smallest_index,2);
        end    
        % For two candidates
        if eyesDetected <= 2
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
                    if  eyeCentroids(i,2) < lowerInt && eyeCentroids(i,2) > upperInt
                        secondEye = centAxisEyes(i,j);
                        secEyePos(1,1) = eyeCentroids(i,1);
                        secEyePos(1,2) = eyeCentroids(i,2);
                        break
                    end

                else
                    if eyeCentroids(i,j) ~= firstEyePos(1,1)
                        secEyePos(1,1) = eyeCentroids(i,1);
                        secEyePos(1,2) = eyeCentroids(i,2);
                        break
                    end
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
end

