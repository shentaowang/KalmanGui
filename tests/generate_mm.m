observe_file = 'mm_observe_02.txt';
true_file = 'mm_true_02.txt';
noise_file = 'mm_noise_02.txt';

dim_x = 4;
dim_z = 3;
dim_data = 100;
observe_data = zeros(dim_data,dim_z);
true_data = zeros(dim_data,dim_x);
noise_data = zeros(dim_data,dim_x);

init_x = [200;200;300;400];
init_f = [
    1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 1];
init_h = [
    1 0 1 0;
    0 1 0 1;
    0 0 0 1];
x = init_x;
for k = 1:dim_data
    noise_x = wgn(4,1,0);
    x = init_f * x + noise_x;
    noise_data(k,:) = x;
    noise_z = wgn(3,1,0);
    observe_data(k,:) = init_h * x + noise_z;
end
x  = init_x;
for k = 1:dim_data
    x = init_f * x;
    true_data(k,:) = x;
end

fp = fopen(observe_file,'w');
for k = 1:dim_data
    for l = 1:dim_z;
        fprintf(fp,'%6f\t',observe_data(k,l));
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

fp = fopen(noise_file,'w');
for k = 1:dim_data
    for l = 1:dim_x
        fprintf(fp,'%6f\t',noise_data(k,l));
    end
    fprintf(fp,'\r\n');
end
