function [ decisionStatistic ] = runClassifier( features,class )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
switch class.class
    case{'FLD'}
        total = size(features,1);
        decisionStatistic = zeros(total,1);
        w = class.sw*(class.m1-class.m0)';
        for i = 1:total
            decisionStatistic(i) = w'*features(i,:)';
        end
    case{'DLRT'}
        a = size(class.features,1);
        D = size(class.features,2);
        n1 = sum(class.target); n0 = a-n1;
        for i = 1:length(features)
            testset = repmat(features(i,:),a,1);
            diff = abs(testset - class.features).^2;
            dist = sum(diff,2);
            [Y,I] = sort(dist);
            targetAfterSort = class.target(I);
            dist0 = Y(targetAfterSort == 0);
            dist1 = Y(targetAfterSort == 1);
            k0 = dist0(class.k);
            k1 = dist1(class.k);
            decisionStatistic(i) = log(n0/n1)+D*(log(k0)-log(k1));
        end
    case{'Bayes'}
        total = size(features,1)
        decisionStatistic = zeros(total,1);

        for i = 1:total
            diff1 = (features(i,:) - class.miu1);
            diff0 = (features(i,:) - class.miu0);
            decisionStatistic(i) = [-1/2*diff1*pinv(class.cov1)*diff1'-1/2*log(det(class.cov1))+log(class.p1)]-...
                [-1/2*diff0*pinv(class.cov0)*diff0'-1/2*log(det(class.cov0))+log(class.p0)];
        end
    case{'KNN'}
        for i = 1 : size (features,2)
        norm(:,i) = (features(:,i) - class.mean(i))/class.var(i);
        end
        a = size(class.feature,1)
        for i = 1:length(norm)
            testset = repmat(norm(i,:),a,1);
            diff = abs(testset - class.feature).^2;
            dist = sum(diff,2);
            [Y,I] = sort(dist);
            neiborInd = I(1:class.k);
            neibor = class.target(neiborInd);
            decisionStatistic(i) = sum(neibor)/class.k;
        end
end

end

