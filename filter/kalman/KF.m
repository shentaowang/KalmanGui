function  filtered_xs  = KF(x, ZS, P, Q, R, F, H)
%   linear kalamn filter
%     Attributes
%     ----------
%     x :matrix(dim_x, 1)
%     The initial x
%
%     ZS :matrix(dim_data, dim_z)
%         Measurement inputs, dim_data means how many measurement data you
%         get
%
%     P : matrix(dim_x, dim_x)
%         Covariance matrix
%
%
%     R : matrix(dim_z, dim_z)
%         Measurement noise matrix
%
%     Q : matrix(dim_x, dim_x)
%         Process noise matrix
%
%     F : matrix(dim_x, dim_x)
%         State Transition matrix
%
%     H : matrix(dim_z, dim_x)
%         Measurement matrix
%
%
%     You may read the following attributes.
%
%     Attributes
%     ----------
%     x : matrix(dim_x, 1)
%         State estimate vector
%
%     K : matrix(dim_x, dim_z)
%         Kalman gain of the update step
%
%     P_PRE : matrix(dim_x, dim_x)
%         The predict of Coveriance
%
%     x_pre : matrix(dim_x, 1)
%         The predict of x
dim_x = size(P,1);
dim_z = size(ZS,1);
dim_data = size(ZS,2);
filtering_xs = zeros(dim_x, dim_data);
for i=1:dim_data
    P_PRE = F * P * F' + Q;
    K = P_PRE * H' / (H * P_PRE * H' + R);
    x_pre = F * x;
    x = x_pre + K * (ZS(:,i) - H * x_pre);
    filtering_xs(:,i) = x;
end
filtered_xs = filtering_xs;
end

