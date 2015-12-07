  function optLamda = getOptLamda(ZNew,tol,lanbdaSet,XTrain,yTrain,t)
% Get the optimal lamda
%
% INPUTS:
%   X(MxN) : trData(i,j) is the i-th feature from the j-th trial
%   Y(Nx1): trData(j) is the label of the j-th trial (1 or -1)
%   setPara : Initialized parameters
%            setPara.t      
%            setPara.beta   
%            setPara.Tmax   
%            setPara.tol    
%            setPara.W      
%            setPara.C      
%
% OUTPUTS:
%   optiLamda: Optimal lamda value 
%
% @ 2011 Kiho Kwak -- kkwak@andrew.cmu.edu

lanbdaErr = [];
Acc = [];
for i = 1:4
    lanbda = lanbdaSet(i);
    for j =1:5
        [SXTrain,SyTrain,SZNew]=SecondClassVal(XTrain,yTrain,ZNew,j);
        [optSolution, err] = solveOptProb_NM(SZNew,tol,lanbda,SXTrain,SyTrain,t,2);
        W = optSolution(1:204);
        A = (W'*XTrain).*yTrain';
        acc = sum(A>0)/200;
        Acc(i) = Acc(i)+acc;
    end
end
[Y,U]=max(Acc)
optLamda = lanbdaSet(U);