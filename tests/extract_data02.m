source_file = 'data02.txt';
observe_file = 'ff_observe_01.txt';
true_file = 'ff_true_01.txt';
fp = fopen(source_file,'r');
observe_data = [];
true_data = [];
samplt_t = [];

while 1
    tline = fgetl(fp);
    if ~ischar(tline)
        break;
    end
    if strcmp(tline(1),'R')
        tline = tline(3:end);
        tline = str2num(tline);
        observe_data = [observe_data;tline(1:3)];
        samplt_t = [samplt_t;tline(4)];
        true_data = [true_data;tline(5:end)];
    end
end

dim_data = size(observe_data,1);
dim_x = size(true_data,2);
dim_z = size(observe_data,2);

fp = fopen(observe_file,'w');
for k = 1:dim_data
    for m = 1:dim_z;
        fprintf(fp,'%6f\t',observe_data(k,m));
    end
    fprintf(fp,'\r\n');
end

fp = fopen(true_file,'w');
for k = 1:dim_data
    for m = 1:dim_x;
        fprintf(fp,'%6f\t',true_data(k,m));
    end
    fprintf(fp,'\r\n');
end
