function [ filtered_x ] = KF(x_init, Z, Q, R, F, H )
%   linear kalamn filter
%     Attributes
%     ----------
%     x_init :matrix(dim_x, 1)
%     The initial x
%
%     Z :matrix(dim_data, dim_z)
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
dim_z = size(Z,1);
dim_data = size(Z,1)



end

