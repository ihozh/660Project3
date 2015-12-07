function [X,y,Z] = initPro(class)
Z = [];
% W,C
W = [];
W_init = ones(204,1);
C_init = 0;
W = W_init;
C = C_init;

% y
Ly = ones(120,1);
Ry = -1*ones(120,1);
y = [Ly;Ry];
% X
% Lmat = [];
% Rmat = [];
% for i = 1:120
%     trail_l = class{1}(:,i);
%     trail_r = class{2}(:,i);
%     Lmat = [Lmat, trail_l];
%     Rmat = [Rmat, trail_r];
% end
% X = [Lmat,Rmat];
LX = class{1};
RX = class{2};
X = [class{1},class{2}];

% cauchy
cauchy = [];
for i = 1:240
    tmp = 1-y(i)*(W'*X(:,i)+C);
    if tmp<0
        cauchy_e = 0.001;
    else
        cauchy_e = tmp+0.001;
    end
    cauchy = [cauchy;cauchy_e];
end


Z = [W;C;cauchy];