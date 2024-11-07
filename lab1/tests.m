clear all;
X = [1,2,3,4,5,6;2,3,4,5,6,7]
Y = [5,6,2,4,2,1]
MapFea(X)

ratio = [0.6,0.4,0]
[Xtr,Ytr,Xval,Yval,Xte,Yte] = SplitData(X,Y,ratio)
ratio = [0.6,0.2,0.2]
[Xtr,Ytr,Xval,Yval,Xte,Yte] = SplitData(X,Y,ratio)


X = [1,1,1,1,1,1;1,2,3,4,5,6];
Y = [2,4,6,8,10,12];
Theta = [1; 2];

[J,dJ] = CostFun(X,Y,Theta)


X = [1,1,1,1,1,1,1,1,1,1; 0,1,2,3,4,5,6,7,8,9];
%Y = [1.1, 1.9, 2.9, 4.1, 4.9, 6.1, 6.9, 8.1, 8.9, 10.1];
Y = [1,2,3,4,5,6,7,8,9,10];
Theta0 = [0;0];
[ThetaOpt,JOpt] = FindTheta(Theta0,X,Y)