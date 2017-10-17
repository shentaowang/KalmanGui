observe_file = 'mm_observe_01.txt';
true_file = 'mm_true_01.txt';

dim_data = 50;
dim_x = 2;
dim_z = 1;
x = 0;
vel = 1;
z_var = 10;
p_var = 0.01;
z_std = sqrt(z_var);
p_std = sqrt(p_var);
xs = zeros(dim_data,dim_x);
zs = zeros(dim_data,dim_z);

for k = 1:dim_data
    v = vel + wgn(1,1,0) * p_std;
    %dt == 1
    x = x + v;
    xs(k,:) = [x v]';
    zs(k,:) = x + wgn(1,1,0) * z_std;
end

fp = fopen(observe_file,'w');
for k = 1:dim_data
    fprintf(fp,'%6f',zs(k,1));
    for m = 2:dim_z;
        fprintf(fp,'\t');
        fprintf(fp,'%6f',zs(k,m));
    end
    fprintf(fp,'\r\n');
end

fp = fopen(true_file,'w');
for k = 1:dim_data
    fprintf(fp,'%6f',xs(k,1));
    for m = 2:dim_x;
        fprintf(fp,'\t');
        fprintf(fp,'%6f',xs(k,m));
    end
    fprintf(fp,'\r\n');
end

