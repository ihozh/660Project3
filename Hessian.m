function [HessianM] = Hessian(X,y,Z,lanbda,t,version)

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



HessianM = [];
%de vector
de = [];
for i = 1:trailSize
    de(i) = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
end

hi = 1;
hj = 1;
%W
for m = 1:204
    % WW
    hj = 1;
    for n = 1:204
        tmp = 0;
        if (m~=n)
            for i = 1:trailSize
                nu = X(m,i)*y(i)*X(n,i)*y(i);
                %de = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
                tmp = tmp+nu/de(i);   
            end
            HessianM(hi,hj) = tmp/t;
        else
            for i = 1:trailSize
                nu = X(m,i)*y(i)*X(m,i)*y(i);
                %de = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
                tmp = tmp+nu/de(i);   
            end 
            HessianM(hi,hj) = 2*lanbda+tmp/t;
        end
        hj = hj+1; 
    end
    %WC
    tmp = 0;
    for i = 1:trailSize
        nu = X(m,i)*y(i)*y(i);
        %de = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
        tmp = tmp+nu/de(i);
    end
    HessianM(hi,hj) = tmp/t;
    hj=hj+1;
    %WCauchy
    tmp = 0;
    for i = 1:trailSize
        nu = X(m,i)*y(i);
        %de = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
        tmp = nu/de(i);
        HessianM(hi,hj) = tmp/t;
        hj = hj+1;
    end
    hi = hi+1;
end
% C
hj = 1;
% CW
for m = 1:204
    
    tmp = 0;
    for i = 1:trailSize
        nu = X(m,i)*y(i)*y(i);
        %de = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
        tmp = tmp+nu/de(i);
    end
    HessianM(hi,hj) = tmp/t;
    hj = hj+1; 
end
% CC
tmp = 0;
for i = 1:trailSize
    nu = y(i)*y(i);
    %de = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
    tmp = tmp+nu/de(i);
end
HessianM(hi,hj) = tmp/t;
hj = hj+1;
% CCauchy
tmp = 0;
for i = 1:trailSize
    nu = y(i);
    %de = (W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1)^2;
    tmp = nu/de(i);
    HessianM(hi,hj) = tmp/t;
    hj = hj+1;
end
hi = hi+1;

% Cauchy
for i = 1:trailSize
    hj = 1;
    % CauchyW
    for m = 1:204
        nu = X(m,i)*y(i);
        tmp = nu/de(i);
        HessianM(hi,hj) = tmp/t;
        hj = hj+1;
    end
    % CauchyC
    nu = y(i);
    tmp = nu/de(i);
    HessianM(hi,hj) = tmp/t;
    hj = hj+1;
    % CauchyCauchy
    for j = 1:trailSize
        if i == j
            tmp = 1/de(i)+1/cauchy(i)^2;
            HessianM(hi,hj) = tmp/t;
        else
            HessianM(hi,hj) = 0;   
        end
        hj = hj+1;
    end
    hi = hi+1;
end

