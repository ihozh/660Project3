Tmax = 10000;
t = 1;
delta = 1;
while (t<Tmax)
    t = 15*t
    while (1)
        firstorderV = first_order(X,y,Z,lanbda,t);
        HessianM = Hessian(X,y,Z,lanbda,t);
        deltaZ = -HessianM\firstorderV;
        delta = abs(firstorderV'*deltaZ)
        if(delta<0.00002)
            break;
        end
        s = 1;
        flag = 1;
        while (flag==1)
            tmpZ = Z+s*deltaZ;
            W = tmpZ(1:204);
            C = tmpZ(205);
            cauchy = tmpZ(206:445);
            for i =1:240
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
end
W = Z(1:204);
C = Z(205);
cauchy = Z(206:445);
show_chanWeights(abs(W));
