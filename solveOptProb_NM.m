function [optSolution, err] = solveOptProb_NM(Z,tol,lanbda,X,y,t,version)
% Compute the optimal solution using Newton method
%
% INPUTS:
%   costFcn: Function handle of F(Z)
%   init_Z: Initial value of Z
%   tol: Tolerance
%
% OUTPUTS:
%   optSolution: Optimal soultion
%   err: Errorr
%
% @ 2011 Kiho Kwak -- kkwak@andrew.cmu.edu

if version == 0
    casize = 120;
    
elseif version == 1
    casize = 100;
else
    casize = 80;
    
end
trailSize = 2*casize;

Tmax = 1000000;
delta = 1;
while (t<Tmax)
    
    while (1)
        [F, G, H] = costFcn(X,y,Z,lanbda,t,version);
        %firstorderV = first_order(X,y,Z,lanbda,t);
        %HessianM = Hessian(X,y,Z,lanbda,t);
        deltaZ = -H\G;
        delta = abs(G'*deltaZ)
        if(delta/2<tol)
            break;
        end
        s = 1;
        flag = 1;
        while (flag==1)
            tmpZ = Z+s*deltaZ;
            W = tmpZ(1:204);
            C = tmpZ(205);
            cauchy = tmpZ(206:205+trailSize);
            for i =1:trailSize
                if (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1<0)
                    flag = 1;
                    s = 0.5*s;
                    break;
                end
                if cauchy(i)<0
                    flag = 1;
                    s = 0.5*s;
                    break;
                end
                flag = 0;
            end
        end
        Z = tmpZ;
    end
    t = 15*t
end
err = delta;
optSolution = Z;