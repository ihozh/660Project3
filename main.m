%main
close all;clear all;clc;
%load('feaSubEImg.mat');
load('feaSubEOvert.mat');
lanbdaSet = [0.01,1,100,10000];
t = 1;
tol = 0.000002;
[X,y,Z] = initPro(class);
Acc = [];
TAcc = [];
TStd = [];
for i = 1:6
    [XTrain,yTrain,ZNew]=FirstClassVal(X,y,Z,i);
    optLamda = getOptLamda(ZNew,tol,lanbdaSet,XTrain,yTrain,t);
    [optSolution, err] = solveOptProb_NM(ZNew,tol,optLamda,XTrain,yTrain,t,1);
    
    W = optSolution(1:204);
    A = (W'*X).*y';
    acc = sum(A>0)/240;
    Acc = [Acc,acc];
        
end
caMean = sum(Acc)/6;
caStd =  std(Acc);
TAcc = [TAcc,caMean];
TStd = [TStd,caStd];
    
%end

% optLamda = getOptLamda(X, Y, setPara);
% [optSolution, err] = solveOptProb_NM(Z,tol,lanbda,X,y,t);
% W = optSolution(1:204);
% 
% show_chanWeights(abs(W));
