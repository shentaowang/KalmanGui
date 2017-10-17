root_path = '../../../../KalmanGui';
addpath(genpath(root_path));
observe_file = 'data02_observe.txt';
true_file = 'data02_true.txt';
radar_groudtruth = load(true_file);
radar_measure = load(observe_file);
up = [
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
r_radar= [
    0.09 0 0;
    0 0.009 0;
    0 0 0.09];
q_radar = [0 0 0 0;0 0 0 0; 0 0 0.09 0;0 0 0 0.09];
ux = [8.462 0 0 0]';
data_scale = size(radar_measure,1);
filtering_data = zeros(data_scale,4);
for i = 1:data_scale
    z = radar_measure(i,:)';
    t = 0.106;
    f=@(x)[x(1)+t*x(3);x(2)+t*x(4);x(3);x(4)];
    h=@(x)[sqrt(x(1)^2+x(2)^2);atan(x(2)/x(1));(x(1)*x(3)+x(2)*x(4))/(x(1)^2+x(2)^2)];
    [ux, up] = unscented_kalman_filter(f,ux,up,h,z,q_radar,r_radar);
    filtering_data(i,:) = ux;
end
result_data = filtering_data;

radar_test_ukf_mse = sum(sum(result_data-radar_groudtruth).^2)/data_scale;

data_gap = result_data-radar_groudtruth;
mse = data_gap(:,1)' * data_gap(:,1)/data_scale;
fprintf('MSE between filtered an true dim:%d is:%f\n',1,mse);