function [XTrain,yTrain,SZNew]=SecondClassVal(X,y,Z,i)

RX = X(:,1:100);
LX = X(:,101:200);
Ry = y(1:100);
Ly = y(101:200);
W = Z(1:204);
C = Z(205);
cauchy = Z(206:405);
Rcauchy = cauchy(1:100);
Lcauchy = cauchy(101:200);

CVStart = (i-1)*20+1;
CVEnd = (i-1)*20+20;
XTest = [LX(:,CVStart:CVEnd),RX(:,CVStart:CVEnd)];

RX(:,CVStart:CVEnd)=[];
LX(:,CVStart:CVEnd)=[];
XTrain = [RX,LX];    %first cross validation 80



Ry(CVStart:CVEnd)=[];
Ly(CVStart:CVEnd)=[];
yTrain = [Ry;Ly];         %80


Rcauchy(CVStart:CVEnd)=[];
Lcauchy(CVStart:CVEnd)=[];
cauchyTrain = [Rcauchy;Lcauchy];


SZNew = [W;C;cauchyTrain];