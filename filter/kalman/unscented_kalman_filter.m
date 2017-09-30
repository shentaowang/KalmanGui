function [ filtered_x, mP ] = unscented_kalman_filter( fstate,vX,mP,hmeas,vZ,mQ,mR )
%Unscented Kalman Filter for nonlinear dynamic systems
dim_x = size(vX,1);
dim_z = size(vZ,1);
alpha = 1e-2;
ki = 0;
beta = 2;
lambda = alpha^2 * (dim_x+ki) - dim_x;
c = dim_x + lambda;
%weight for means
Wm = [lambda/c 0.5/c+zeros(1,2*dim_x)];
%weught for convarience
Wc = Wm;
Wc(1) = Wc(1) + (1-alpha^2+beta);
c = sqrt(c);
%sigma points around x
trans_x = sigmas(vX,mP,c);
%unscented transformation of process
[x1,X1,P1,X2] = ut(fstate,trans_x,Wm,Wc,dim_x,mQ);       
%unscented transformation of measurments
[z1,Z1,P2,Z2] = ut(hmeas,X1,Wm,Wc,dim_z,mR);
%transformed cross-covariance
P12 = X2 * diag(Wc) * Z2';                        
K = P12/P2;
%state update
filtered_x = x1 + K * (vZ - z1);
%covariance update
mP = P1 - K * P12';                                
end

function trans_x=sigmas(vX,mP,c)
%Unscented Transformation
A = c * chol(mP)';
Y = vX(:,ones(1,numel(vX)));
%now have (2*dim_X+1) element
trans_x = [vX Y+A Y-A];
end

function [y,Y,P,Y1]=ut(f,X,Wm,Wc,n,R)
%Unscented Transformation
L = size(X,2);
y = zeros(n,1);
Y = zeros(n,L);
for k=1:L
    Y(:,k)=f(X(:,k));
    y = y + Wm(k) * Y(:,k);
end
Y1 = Y-y(:,ones(1,L));
P = Y1 * diag(Wc) * Y1' + R;
end
