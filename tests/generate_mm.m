observe_file = 'mm_observe_02.txt';
true_file = 'mm_true_02.txt';
dim_x = 4;
dim_z = 3;
dim_data = 100;
test_data = zeros(dim_data,dim_z);
true_data = zeros(dim_data,dim_x);
init_x = [2;2;3;4];
init_f = [
    1 0 1 0;
    0 1 0 1;
    0 0 1 0;
    0 0 0 1];
init_h = [
    1 0 1 0;
    0 1 0 1;
    0 0 0 1];
x = init_x;
for k = 1:dim_data
    noise_x = [wgn(1,1,1);wgn(1,1,1);wgn(1,1,1);wgn(1,1,1)];
    x = init_f * x + noise_x;
    noise_z = [wgn(1,1,1);wgn(1,1,1);wgn(1,1,1)];
    test_data(k,:) = init_h * x + noise_z;
end
x  = init_x;
for k = 1:dim_data
    x = init_f * x;
    true_data(k,:) = x;
end

fp = fopen(observe_file,'w');
for k = 1:dim_data
    for l = 1:dim_z;
        fprintf(fp,'%6f\t',test_data(k,l));
    end
    fprintf(fp,'\r\n');
end

fp = fopen(true_file,'w');
for k = 1:dim_data
    for l = 1:dim_x
        fprintf(fp,'%6f\t',true_data(k,l));
    end
    fprintf(fp,'\r\n');
end
