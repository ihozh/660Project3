close all;clear all;clc;
load('feaSubEImg.mat');
[X,y,Z] = initPro(class);
lanbda = 10000;
t = 10;
% firstorderV = first_order(X,y,Z,lanbda,t);
% HessianM = Hessian(X,y,Z,lanbda,t);

%show_chanWeights(abs(W));

