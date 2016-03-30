function [ output_args ] = myPlotDLRT( class )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
n = 256;
max1 = max(class.features(:,1));
max2 = max(class.features(:,2));
min1 = min(class.features(:,1));
min2 = min(class.features(:,2));
H0 = class.features(class.target == 0,:);
H1 = class.features(class.target == 1,:);

range1 = max1-min1;
range2 = max2-min2;
a1 = 2*range1/(n-1);
a2 = 2*range2/(n-1);
len = size(class.features,1);
for i = 1:n
    for j = 1:n;
        fig((i-1)*n+j,1) = min1-range1/2+a1*(i-1);
        fig((i-1)*n+j,2) = min2-range2/2+a2*(j-1);
    end  %for j
end %for i
decision = myRunDLRT(fig,class);
xtest = reshape(decision,n,n);
x1 = [min1-range1/2,max1+range1/2];
x2 = [min2-range2/2,max2+range2/2];
figure
imagesc(x1,x2,xtest)
colormap hsv;
colorbar;
hold on
plot(H1(:,1),H1(:,2),'r*');
plot(H0(:,1),H0(:,2),'bo');
title('Decision Surface of DLRT Classifier')
xlabel('Feature 1')
ylabel('Feature 2')
legend('H1','H0')

end

