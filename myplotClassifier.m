function [ output_args ] = myplotClassifier( class )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
n = class.n;
max1 = max(class.feature(:,1));
max2 = max(class.feature(:,2));
min1 = min(class.feature(:,1));
min2 = min(class.feature(:,2));
H0 = class.feature(class.target == 0,:);
H1 = class.feature(class.target == 1,:);

range1 = max1-min1;
range2 = max2-min2;
a1 = 2*range1/(n-1);
a2 = 2*range2/(n-1);
len = size(class.feature,1);

for i = 1:n
    for j = 1:n;
        fig((i-1)*n+j,1) = min1-range1/2+a1*(i-1);
        fig((i-1)*n+j,2) = min2-range2/2+a2*(j-1);
    end  %for j
end %for i
for i = 1:n*n
    curr = fig(i,1:2);
    testset = repmat(curr,len,1);
    diff = abs(testset - class.feature).^2;
    dist = sum(diff,2);
    [Y,I] = sort(dist);
    neiborInd = I(1:class.k);
    neibor = class.target(neiborInd);
    a = sum(neibor);
    fig(i,3) = a/class.k;
    
end %for i
xtest = fig(:,3);
xtest = reshape(xtest,n,n);
x1 = [min1-range1/2,max1+range1/2];
x2 = [min2-range2/2,max2+range2/2];
figure(1)
imagesc(x1,x2,xtest)
title('Decision Surface of KNN Classifier')
xlabel('Feature 1')
ylabel('Feature 2')
hold on
plot(H1(:,1),H1(:,2),'b*');
plot(H0(:,1),H0(:,2),'ro');
legend('H1','H0')

end

