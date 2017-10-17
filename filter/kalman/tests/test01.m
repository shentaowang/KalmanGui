root_path = '../../../../KalmanGui';
addpath(genpath(root_path));
true_file = 'data01_true.txt';
observe_file = 'data01_observe.txt';
data_true = load(true_file)';
data_observe = load(observe_file)';

dim_x = size(data_true,1);
dim_z = size(data_observe,1);
init_p = [500 0;0 49];
init_h = [1 0];
init_f = [1 1;0 1];
init_r = 10;
init_q = [0.01 0;0 0.01];
init_x = [0; 0];

filtered_xs = kalman_filter(init_x, data_observe, init_p, init_q, init_r,...
    init_f, init_h);
data_gap = filtered_xs - data_true;

mse = data_gap(1,:) * data_gap(1,:)'/size(data_gap,2);
fprintf('MSE between filtered an true dim:%d is:%f\n',1,mse);


