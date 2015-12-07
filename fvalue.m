function [F] = fvalue(X,y,Z,lanbda,t,version)

if version == 0
    casize = 120;
    
elseif version == 1
    casize = 100;
else
    casize = 80;
    
end
trailSize = 2*casize;
W = Z(1:204);
C = Z(205);
cauchy = Z(206:205+trailSize);
firstPart = sum(W);
secondPart = lanbda*(W'*W);

thirdPart = sum(log(W'*X.*y'+(C*y)'+cauchy'-1))/t;
forthPart = sum(log(cauchy))/t;

F = firstPart+secondPart+thirdPart+forthPart;