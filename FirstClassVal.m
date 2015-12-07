function [XTrain,yTrain,ZNew]=FirstClassVal(X,y,Z,i)

RX = X(:,1:120);
LX = X(:,121:240);
Ry = y(1:120);
Ly = y(121:240);
W = Z(1:204);
C = Z(205);
cauchy = Z(206:445);
Rcauchy = cauchy(1:120);
Lcauchy = cauchy(121:240);

CVStart = (i-1)*20+1;
CVEnd = (i-1)*20+20;
XTest = [LX(:,CVStart:CVEnd),RX(:,CVStart:CVEnd)];

RX(:,CVStart:CVEnd)=[];
LX(:,CVStart:CVEnd)=[];
XTrain = [RX,LX];    %first cross validation 100


Ry(CVStart:CVEnd)=[];
Ly(CVStart:CVEnd)=[];
yTrain = [Ry;Ly];         %100


Rcauchy(CVStart:CVEnd)=[];
Lcauchy(CVStart:CVEnd)=[];
cauchyTrain = [Rcauchy;Lcauchy];


ZNew = [W;C;cauchyTrain];


