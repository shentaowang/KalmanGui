function  filtered_xs  = kalman_filter(vX, mZs, mP, mQ, mR, mF, mH)
%   linear kalamn filter
%     Attributes
%     ----------
%     vX :matrix(dim_x, 1)
%     The initial x
%
%     mZs :matrix(dim_data, dim_z)
%         Measurement inputs, dim_data means how many measurement data you
%         get
%
%     mP : matrix(dim_x, dim_x)
%         Covariance matrix
%
%
%     mR : matrix(dim_z, dim_z)
%         Measurement noise matrix
%
%     mQ : matrix(dim_x, dim_x)
%         Process noise matrix
%
%     mF : matrix(dim_x, dim_x)
%         State Transition matrix
%
%     mH : matrix(dim_z, dim_x)
%         Measurement matrix
%
%
%     You may read the following attributes.
%
%     Attributes
%     ----------
%     mK : matrix(dim_x, dim_z)
%         Kalman gain of the update step
%
%     mPpre : matrix(dim_x, dim_x)
%         The predict of Coveriance
%
%     vXpre : matrix(dim_x, 1)
%         The predict of x
dim_x = size(mP,1);
dim_z = size(mZs,1);
dim_data = size(mZs,2);
filtering_xs = zeros(dim_x, dim_data);
for k=1:dim_data
    mPpre = mF * mP * mF' + mQ;
    mK = mPpre * mH' / (mH * mPpre * mH' + mR);
    vXpre = mF * vX;
    vX = vXpre + mK * (mZs(:,k) - mH * vXpre);
    filtering_xs(:,k) = vX;
end
filtered_xs = filtering_xs;
end

