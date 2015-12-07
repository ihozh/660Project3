function firstorderV = first_order(X,y,Z,lanbda,t,version)
%clean all;close all;clc;
%variable contains W,C and cauchy
%W   204
%C    1
%Cauchy 240

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



firstorderV = [];
df_w = [];
df_cauchy = [];
%first order derivate of W
for m = 1:204
    df_w_e = 0;
    for i = 1:trailSize
        df_w_e = df_w_e+X(m,i)*y(i)/(W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1);
    end
    df_w = [df_w;2*lanbda*W(m)-(df_w_e)/t];
end
%first order derivate of C
df_c_e = 0;
for i = 1:trailSize
    df_c_e = df_c_e+y(i)/(W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1);
end
df_c = -(df_c_e)/t;
%first order derivate of cauchy
for i = 1:trailSize
    df_cauchy_e = 1-1/(t*(W'*X(:,i)*y(i)+C*y(i)+cauchy(i)-1))-1/(t*cauchy(i));
    df_cauchy = [df_cauchy;df_cauchy_e];
end

firstorderV = [df_w;df_c;df_cauchy];