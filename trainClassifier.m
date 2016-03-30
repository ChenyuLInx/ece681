function [ class ] = trainClassifier( features,target,method,k,n)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
switch method
    case{'Bayes'}
        H0 = features(target == 0,:);
        H1 = features(target == 1,:);
        %calculate means of each feature for each class
        class.miu1 = mean(H1);
        class.miu0 = mean(H0);
        %culculate covariance matrix for each class
        class.cov0 = cov(H0);
        class.cov1 = cov(H1);
        %calculate p(W0) and p(W1)
        totalNum = size(features,1);
        class.p0 = size(H0,1)/totalNum;
        class.p1 = size(H1,1)/totalNum;
        class.features = features;
        class.target = target
        class.class = 'Bayes';
    case{'FLD'}
        H0 = features(target == 0,:);
        H1 = features(target == 1,:);
        l1 = size(H1,1);l0 = size(H0,1)
        class.m1 = sum(H1)/l1;
        class.m0 = sum(H0)/l0;
        d = size(features,2)
        s1 = zeros(d,d);s0 = zeros(d,d);
        for i = 1:l1
            s1 = s1+(H1(i)-class.m1)'*(H1(i)-class.m1);
        end
        for i = 1:l0
            s0 = s0+(H0(i)-class.m0)'*(H0(i)-class.m0);
        end
        class.sw = s0+s1;
        class.features = features;
        class.target = target
        class.class = 'FLD';
    case{'DLRT'}
        class.k = k;
        class.features = features;
        class.target = target;
        class.class = 'DLRT';
    case{'KNN'}
        for i = 1:size(features,2)
        theta(i) = sqrt(var(features(:,i)));
        miu(i) = mean(features(:,i));
        norm(:,i) = (features(:,i) - miu(i))/theta(i);
        end
        class.feature = norm;
        class.target = target;
        class.k = k;
        class.n = n;
        class.mean = miu;
        class.var = theta
        class.class = 'KNN'
end

end

