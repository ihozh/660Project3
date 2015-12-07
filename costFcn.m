function [F, G, H] = costFcn(X,y,Z,lanbda,t,version)
% Compute the cost function F(Z)
%
% INPUTS: 
%   Z: Parameter values
% OUTPUTS
%   F: Function value
%   G: Gradient value
%   H: Hessian value
%
% @ 2011 Kiho Kwak -- kkwak@andrew.cmu.edu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To improve the excution speed, please program your code with matrix
% format. It is 30 times faster than the code using the for-loop.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

H = Hessian(X,y,Z,lanbda,t,version);
G = first_order(X,y,Z,lanbda,t,version);
F = fvalue(X,y,Z,lanbda,t,version);
