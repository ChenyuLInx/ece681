function [pD,pF] = myroc( decisionStat,target,option)
%When option = 1, myroc will plot the distribution of decision statistics
%and the sroted data
%   Detailed explanation goes here
H0 = decisionStat(target < 1);
H1 = decisionStat(target > 0);
[D0,I] = sort(decisionStat);
H0 = sort(H0);
H1 = sort(H1);
n = length(decisionStat);
n0 = length(H0);
n1 = length(H1);
pD = 1: n+1;
pD(:) = 0;
pF = 1: n+1;
pF(:) = 0;
if option==1
figure
[H0x,X0] = ksdensity(H0);
[H1x,X1] = ksdensity(H1);
plot(X0,H0x,'b',X1,H1x,'r','LineWidth', 2);
title('Distribution of Probobility')
end
for i = 1:n
 pD(i) = nnz(H1 >= D0(i))/n1;
 pF(i) = nnz(H0 >= D0(i))/n0;
end

figure
plot(pF,pD,'LineWidth', 2);
title('ROC curve')
xlabel('P_f')
ylabel('P_d')
if option == 1
 target(I);
 figure
 X = 1:n
 plot(find(target == 0),D0(target == 0),'b*','MarkerSize',10);
 hold on
 plot(find(target == 1),D0(target == 1),'ro','MarkerSize',5);
end
end

