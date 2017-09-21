root_path = 'E:\Light\学习\研究生准备\蔡老师\背景知识\code\KalmanGui';
addpath(genpath(root_path));
fp = fopen('data01.txt');
ZS = [];
while 1
    tline = fgetl(fp);
    if ~ischar(tline)
        break;
    end
    tline = str2num(tline);
    ZS = [ZS tline];
end
length = size(ZS,2);
init_x = ZS(1);
P = 1e-5;
H = 1;
F = 1;
R = 1e-5;
Q = 1e-6;

filtered_x = KF(init_x,ZS,P,Q,R,F,H);
plot_x = [1:length];
plotyy(plot_x, ZS', plot_x, filtered_x', 'plot');
legend('test\_data','flitered\_data');

