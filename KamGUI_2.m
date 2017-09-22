

function varargout = KamGUI_2(varargin)
% KAMGUI_2 MATLAB code for KamGUI_2.fig
%      KAMGUI_2, by itself, creates a new KAMGUI_2 or raises the existing
%      singleton*.
%
%      H = KAMGUI_2 returns the handle to a new KAMGUI_2 or the handle to
%      the existing singleton*.
%
%      KAMGUI_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAMGUI_2.M with the given input arguments.
%
%      KAMGUI_2('Property','Value',...) creates a new KAMGUI_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KamGUI_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KamGUI_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KamGUI_2

% Last Modified by GUIDE v2.5 22-Sep-2017 14:55:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KamGUI_2_OpeningFcn, ...
                   'gui_OutputFcn',  @KamGUI_2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before KamGUI_2 is made visible.
function KamGUI_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KamGUI_2 (see VARARGIN)

% Choose default command line output for KamGUI_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KamGUI_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global T1_2;
global Wei_2;
global X0_2;
global P0_2;
global Allneed2;   
X0_2=[6100,-410,0,8100,2,0]';
P0_2=diag([100^2 10^2 0 100^2 10^2 0]);         
T1_2=2;
Wei_2=2;                                                                   %！！与KamGUI_1_1的不同、改进：初始化赋值不同
Allneed2.Flag_init=62;
Allneed2.Wei_Z=2;

X0_2=[0 200 -25 0 0 25 0 0 60]';
P0_2=diag([100 10 1 100 10 1 100 10 1]);                                  %需要解决输出显示的对齐
T1_2=0.01;
Wei_2=3;
Allneed2.Flag_init=93;
Allneed2.Wei_Z=3;

%滤波器的初始化 是否在此进行，需要后续验证，但是现在不初始化的话程序也能识别了。
global A_2;
global G_2;
global Q_2;
global H_2;
global R_2;
CA_I=[1 T1_2 0.5*T1_2^2;0 1 T1_2; 0 0 1];       
A_2=[CA_I,zeros(3,6);zeros(3),CA_I,zeros(3);zeros(3,6),CA_I];
G_2=[0.5*T1_2^2,0,0;T1_2,0,0;1,0,0;  0,0.5*T1_2^2,0;0,T1_2,0;0,1,0;0 0 0.5*T1_2^2;0,0,T1_2;0 0 1];
Q_I=0.1;
Q_2=diag([Q_I,Q_I,Q_I]);

syms x y z;                                                                      %这里是二维雷达 现在需要编写三维雷达情况。
f1=sqrt(x^2+y^2);f2=atan(y/x);
h11=x/(x^2 + y^2)^(1/2);h12=y/(x^2 + y^2)^(1/2);h21=-y/(x^2 + y^2);h22=x/(x^2 + y^2);
Allneed2.Fx={f1;f2};
H={h11,h12;h21 h22};                                      %H的真正的值 应该根据Allneed.Flag_init和 Allneed.Wei_Z来确定。
H_2=[H{1,1},0,0,H{1,2},0,0;H{2,1},0,0,H{2,2},0,0];
R_2=diag([10000,0.0001]);

f1=sqrt(x^2+y^2+z^2);f2=atan(y/x);f3=atan(z/sqrt(x^2+y^2));     %为了解决atan2不能用于符号变量 可以不可以将所有函数设置为字符串形式，再通过命令eval来完成赋值。
    R1=sqrt(x^2+y^2+z^2);  r1=sqrt(x^2+y^2);
h11=x/R1;h12=y/R1; h13=z/R1;
h21=-y/(x^2+y^2); h22=-x/(x^2+y^2);  h23=0;
h31=-x*z/(R1^2*r1); h32=-y*z/(R1^2*r1); h33=r1/R1^2;
H={h11,h12,h13;h21 h22 h23; h31 h32 h33};%H的真正的值 应该根据Allneed.Flag_init和 Allneed.Wei_Z来确定。
H_2=[H{1,1},0,0,H{1,2},0,0,H{1,3},0,0;
     H{2,1},0,0,H{2,2},0,0,H{2,3},0,0;
    H{3,1},0,0,H{3,2},0,0,H{3,3},0,0;];
Allneed2.Fx={f1;f2;f3};
R_2=diag([10000,0.0001,0.0001]);




% --- Outputs from this function are returned to the command line.
function varargout = KamGUI_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function KF_Callback(hObject, eventdata, handles)
% hObject    handle to KF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
%run('KamGUI_2');
 %KamGUI_1_1
 set(0,'currentfigure', KamGUI_1_1);


% --- Executes during object creation, after setting all properties.
function pushbutton1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Original_State.
function Original_State_Callback(hObject, eventdata, handles)
% hObject    handle to Original_State (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X0_2;
global P0_2;
global Wei_2;
global T1_2;
global Allneed2;                                                            %改进，把一些全局变量放在结构体Allneed里，此时其实是handles的使用方法？
%disp(X0);
X0=X0_2;                                                                    %通过这种方式可以复制KamGUI_1_1的程序方便；但是要注意的是每个程序结尾的时候都需要赋值回来
P0=P0_2;
Wei=Wei_2;
T1=T1_2;
Wei_Z=Allneed2.Wei_Z;

%===================初始状态的初始化======================================
for r=1:1
prompt={'X0:(n×1)           PS：The "X0" format is given!','P0:(n×n)','Sampling Period','Spatial Dimension','Measurement Space'};
title='Original State Parameters';
row=[8,8,1,1,1]';col=[50,50,50,50,50]';
lines=[row,col];
def={num2str(X0),num2str(P0),num2str(T1),num2str(Wei),num2str(Wei_Z)};
  options.Resize='on';options.WindowStyle='normal';options.Interpreter='none';
answer=inputdlg(prompt,title,lines,def,options);

    if isempty(answer)
      msgbox('滤波初始状态将保持原值，请确认','提示','warn')                         %此处仍旧弹出确认窗口，因为感觉这里的初始化比较重要，需要根据调试结果看一下此处是否要保留
      return;                                                               %改进！ 当点击取消的时候程序应该直接跳出 以便保留上次的值
    else        
        if ~isempty(answer{1})
           % cc=answer{1}
           X0=str2num(answer{1});
           [n1,m1]=size(X0);
           if m1~=1
              msgbox('X0必须是列向量','确认初始化','warn') 
              return;
           end                          
        end
        if ~isempty(answer{2})
           P0=str2num(answer{2});
           [n2,m2]=size(P0);
           if m2~=n2
              msgbox('P0必须是方阵！','确认初始化','warn') 
              return;
           elseif n2~=n1
               msgbox('P0与X0维数不符！','确认初始化','warn') 
              return;
           end

        end
        if ~isempty(answer{3})
            %disp(answer{3})
           T1=str2num(answer{3});
          % disp(T1)
           n3=length(T1);
           if n3~=1
              msgbox('T1必须是标量','确认初始化','warn') 
              return;
           end  
        end
        if ~isempty(answer{4})
           Wei=str2num(answer{4}); 
           n4=length(Wei);
           if n4~=1
              msgbox('维数必须是标量','确认初始化','warn') 
              return;
           end  
        end
        if ~isempty(answer{5})
           Wei_Z=str2num(answer{5});
           n5=length(Wei_Z);
           if n5~=1
              msgbox('测量空间维数必须是标量','确认初始化','warn') 
              return;
           end  
        end
    end
    % =========当滤波初值维数或者周期变化的时候 下拉菜单 应该重启 
    [n6,m6]=size(X0_2);       %此时X0_2 T1_2代表的是上一个时刻的值
    if n1~=n6||T1~=T1_2
        set(handles.Motion_Popup,'visible','off');
        set(handles.CompletelyManual,'visible','off');
        set(handles.Classical,'visible','on','value',0);
    end
end
X0_2 =X0;          %通过这种方式可以复制KamGUI_1_1的程序方便，以后调试改错也方便；但是要注意的是每个程序结尾的时候，如果程序中有对全局变量的赋值需要赋值回来
P0_2=P0;
Wei_2=Wei;
T1_2=T1;  
Allneed2.Wei_Z =Wei_Z;  %本程序中只用到了最后一个 在此是为了IMM编程序试用 ，同时其余几个参数已经设为全局变量 再改恐麻烦

%================根据X0，Wei对应的关系，设置一个标志========================
 %Flag等于-1表示初始化的时候 X0的维数和Wei没有对应的值  Flag=-2表输入的X0不是标准的机动运动向量;
%程序一个问题就是当X0,Wei的输入不是标准值的时候，即Flag取值-1 -2时候，是否使用return函数，即是否对Allneed.Flag_init重新赋值  这里的做法是不使用return       

Flag=Allneed2.Flag_init;
for r=1:1
    n=length(X0_2);
    switch n
        case 2
            if Wei==1
                Flag=21;%     前面的数字表示的是X0的维数，后面的数字表示的是空间维数
            elseif Wei==2
                Flag=22;
            else
                % msgbox('初始化没有对应的默认模型，请确认输入或者手动输入','请确认','warn');return;
                Flag=-1;
            end
        case 3
            if Wei==1
                Flag=31;
            else
                Flag=-1;
            end
        case 4
            if Wei==2
                Flag=42;
            else
                Flag=-1;
            end
        case 6
            if Wei==2
                Flag=62;
            elseif Wei==3
                Flag=62;
            else
                Flag=-1;
            end
        case 9
            if Wei==3
                Flag=93;
            else
                Flag=-1;
            end
        otherwise
            Flag=-2;
            msgbox('初始状态X0的维数不是默认情况，程序仍能进行，但是有可能不能够绘图，请确认','请确认','warn');
            %return;%如果使用return函数实际上Allneed.Flag_init就不可能取值-2，这样做是相对合理的，因为程序本身就是不能很好处理不是标准情况下的程序。
            %不过也可以考虑程序可以继续进行 只不过不能绘图展示纯粹的卡尔曼程序仍能进行？？
    end
    if Flag==-1
        msgbox('初始化时X0和Wei没有默认的对应状况，程序仍能进行，但是有可能不能够绘图，请确认','请确认','warn');
        %return;
    end
end
Allneed2.Flag_init=Flag;
%disp(Allneed2)

%===================强制重启滤波器 防止此时=================================%实用性有待考证


% --- Executes on button press in Motion_Model.
function Motion_Model_Callback(hObject, eventdata, handles)
% hObject    handle to Motion_Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X0_2;
global T1_2;
global A_2;
global G_2;
global Q_2;
%=================根据 X0_2,T1_2的状态自动确定默认的运动模型参数
%这里其实涉及到两个变量：X0_2的维数是否变化，T1_2的取值是否变化。下面的程序已经解决了一部分 不过其中最有意义的一个问题还没解决
%就是当X0的维数不变 而周期变化的时候，总会重新初始化A_2等，不能在保持A_2的形式前提下 只改变其中T1_2的值。解决思路 引入符号变量
%替换T1_1
%程序中的n5其实代表了上次X0的维数

[n1,m1]=size(X0_2);
[n5,m5]=size(A_2);
CV_I=[1 T1_2 0;0 1 0; 0 0 0];  %A=diag([CV_I,CV_I]);%这种表达式不能输出对角矩阵
CA_I=[1 T1_2 0.5*T1_2^2;0 1 T1_2; 0 0 1];     
try                                                                             %gaijin
   T1_pre= handles.T1_pre;
catch 
    T1_pre=1;
end
  if n5==n1&&T1_2==T1_pre                                        %这里的程序是有问题，根据初始状态来自适应变化 但是比起KamGUI_1_1这里多了一个输入 情况要复杂很多。
      %上次输入之后A的维数和X0相同，表示X0的维数没变，此时A的维数应该保持不变，不要重新初始化
      %%这里是不是有问题呢：我原想解决的问题是 A_2某次更改之后 下次回来保留不变即认为“模型变化之后不再重新赋值”  但是显然这里的判定条件好像不对啊 木有考虑到“模型不变
      %%周期更改”的情况  而后者更重要
 % elseif n5==n1&&T1_2~=T1_pre
      %这种情况编程最复杂。。
  else
      switch n1
          case 9 
              A_2=[CA_I,zeros(3,6);zeros(3),CA_I,zeros(3);zeros(3,6),CA_I];
              G_2=[T1_2,0,0;1,0,0;1,0,0;0,T1_2,0;0,1,0;0,1,0;0 0 T1_2;0,0,1;0 0 1];
              Q_I=0.1;
              Q_2=diag([Q_I,Q_I,Q_I]);
          case 6
              A_2=[CV_I,zeros(3);zeros(3),CV_I];
              G_2=[T1_2,0; 1,0; 0,0; 0,T1_2; 0,1; 0,0];
              Q_I=0.1;
              Q_2=diag([Q_I,Q_I]);
          case 4
              A_2=[1,T1_2,0,0;0 1 0 0; 0 0 1 T1_2; 0 0 0 1];
              G_2=[0.5*T1_2^2 0; T1_2 0; 0 0.5*T1_2^2; 0 T1_2];
              Q_I=0.1;
              Q_2=diag([Q_I,Q_I]);
          otherwise
              A_2=[CV_I,zeros(3);zeros(3),CV_I];
              G_2=[T1_2,0;1,0;0,0;0,T1_2;0,1;0,0];
              Q_I=0.1;
              Q_2=diag([Q_I,Q_I]);
      end
  end
 handles.T1_pre=T1_2;
 guidata(hObject, handles);
    
%============根据输入框的内容确定参数值，当点击取消的时候保存上次输入值======
prompt={'Φ(k+1,k):(n×n)','Q(k):(p×p)','Γ(k+1,k):(n×p)'};
title='Motion Model Parameters';
row=[8,4,8]';col=[60,60,60]';
lines=[row,col];
def={num2str(A_2),num2str(Q_2),num2str(G_2)};
options.Resize='on';options.WindowStyle='normal';options.Interpreter='none';
answer=inputdlg(prompt,title,lines,def,options);
                                                                         
    if isempty(answer)
      msgbox('没有确认，将保存原状态','确认初始化','warn')                         %改进，当点击取消的时候不弹出此窗口，
    else
        exist=0;
        if ~isempty(answer{1})
           A_2=str2num(answer{1});
              [n5,m5]=size(A_2);
           if m5~=n5
              msgbox('A必须是方阵！','确认初始化','warn') 
              return;
           elseif n5~=n1
               msgbox('A与X0维数不符！','确认初始化','warn') 
              return;
           end
        end
        if ~isempty(answer{2})
           Q_2=str2num(answer{2});
             [n6,m6]=size(Q_2);
           if m6~=n6
              msgbox('Q必须是方阵！','确认初始化','warn') 
              return;
           end
        end
        if ~isempty(answer{3})
           G_2=str2num(answer{3});
            [n7,m7]=size(G_2);
           if m7~=n6
              msgbox('G与Q维数不符！','确认初始化','warn') 
              return;
           elseif n7~=n1
               msgbox('G与X0维数不符！','确认初始化','warn') 
              return;
           end
        end
    end
 %===========此段程序直接对全局变量进行操作，不是十分保险，编程要尽量避免===
   
    
    
% --- Executes on button press in Measure_Model.
function Measure_Model_Callback(hObject, eventdata, handles)
% hObject    handle to Measure_Model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global H_2;
global R_2;
global Allneed2;
H= H_2;
R= R_2;
Wei_Z=Allneed2.Wei_Z;
Fx=Allneed2.Fx;
Flag=Allneed2.Flag_init;
try
Wei_Z_Pre=handles.Wei_Z;
catch
    Wei_Z_Pre=2;
end%第一次输入的情形
for r=1:1
%==================输入观测矩阵==========================
    syms x y z;
    switch Wei_Z
        case 2
            
            if Wei_Z_Pre==Wei_Z
                f1=Fx{1};
                f2=Fx{2};
            else
            %==默认情况下的==                                                %根据条件可以跳过此处 以便保留上一次的值
            f1=sqrt(x^2+y^2);
            f2=atan(y/x);
            R=diag([6400,0.000025]);
            end
            
            %===根据对话框输入的==
            prompt={['Z=F(X):', char(13), char(10),'f1(X)'],'f2(X)','R(k):(m×m)'};%单独的换行建也可以满足要求 回车键 不行  回车键原意是回到行首
            title='Measure Model Parameters';
            row=[4,4,4]';col=[30,30,30]';
            lines=[row,col];
            def={char(f1),char(f2),num2str(R)};
            %options.Resize='on';options.WindowStyle='normal';options.Interpreter='tex';
            %answer=inputdlg(prompt,title,lines,def,options);%options.Interpreter设置为'tex'貌似没用啊
            answer=inputdlg(prompt,title,lines,def);
            if isempty(answer)
                msgbox('请确认是否进行初始化','确认初始化','warn')
            else
                if ~isempty(answer{1})                    
                    A1=answer{1};
                    f1=sym(A1);
                    h11=diff(f1,x);
                    h12=diff(f1,y);
                    %disp(H);
                end
                if ~isempty(answer{2})
                    A2=answer{2};
                    f2=sym(A2);
                    h21=simple(diff(f2,x));
                    h22=simple(diff(f2,y));                    
                end
                if ~isempty(answer{3})
                    R=str2num(answer{3});
                end                
            end
            H={h11,h12;h21 h22};
            Fx={f1;f2};
        case 3
            %================如何跳过，以便保留上次的输入值=================
             
                if Wei_Z_Pre==Wei_Z
                    f1=Fx{1};
                    f2=Fx{2};
                    f3=Fx{3};
                else
                    f1=sqrt(x^2+y^2+z^2);
                    %f2=atan2(y,x);
                    f2=atan(y/x);
                    f3=atan(z/sqrt(x^2+y^2));
                    R=diag([6400,0.000025,0.000025]);
                end
            %==========
            prompt={['Z=F(X):', char(13), char(10),'f1(X)'],'f2(X)','f3(X)','R(k):(m×m)'};%单独的换行建也可以满足要求 回车键 不行  回车键原意是回到行首
            title='Measure Model Parameters';
            row=[4,4,4,4]';col=[30,30,30,30]';
            lines=[row,col];
            def={char(f1),char(f2),char(f3),num2str(R)};
            answer=inputdlg(prompt,title,lines,def);
            if isempty(answer)
                msgbox('请确认是否进行初始化','确认初始化','warn')
            else
                if ~isempty(answer{1})                    
                    A1=answer{1};
                    f1=sym(A1);
                    h11=diff(f1,x);
                    h12=diff(f1,y);
                    h13=diff(f1,z);
                    %disp(H);
                end
                if ~isempty(answer{2})
                    A2=answer{2};
                    f2=sym(A2);
                    h21=simple(diff(f2,x));
                    h22=simple(diff(f2,y));       
                    h23=simple(diff(f3,z)); 
                end
                if ~isempty(answer{3})
                    A3=answer{3};
                    f3=sym(A3);
                    h31=simple(diff(f3,x));
                    h32=simple(diff(f3,y)); 
                    h33=simple(diff(f3,z));  
                end
                if ~isempty(answer{4})
                    R=str2num(answer{4});
                end                
            end
             H={h11,h12,h13;h21 h22 h23;h31 h32 h33};
             Fx={f1;f2;f3};
        case 1
            if Wei_Z_Pre==Wei_Z
                f1=Fx{1};
            else
                f1=atan(y/x);
                R=diag([0.000025]);
            end
            
            prompt={['Z=F(X):','  ','f1(X)'],'R(k):(m×m)'};
            title='Measure Model Parameters';
            row=[4,4]';col=[30,30]';
            lines=[row,col];
            def={char(f1),num2str(R)};
            answer=inputdlg(prompt,title,lines,def);
            if isempty(answer)
                msgbox('请确认是否进行初始化','确认初始化','warn')
            else
                if ~isempty(answer{1})                    
                    A1=answer{1};
                    f1=sym(A1);
                    h11=diff(f1,x);
                    h12=diff(f1,y);                   
                end
                 if ~isempty(answer{2})
                    R=str2num(answer{2});
                end   
                
            end
             H={h11,h12}
             Fx={f1};
        otherwise
            msgbox('观测空间不符实际的情况(维数>3)，暂时未能处理','确认初始化','warn');            
    end
    %===============具体确定H的形式==================
    switch Flag
        case 62
            switch Wei_Z            %全部都采用一样的形式 这是一种新思路 就是这个程序可以应对所有方程个数分别为 1 2 3的情形，进一步可以把观测方程个数为1 2当成3 的特殊情形 反正求导为0
                case 1
                    H=[H{1,1},0,0,H{1,2},0,0];                    %这里Flag Wei_Z的三个量：比如Wei_Z=2;Flag=63 分别决定了H的行数、列数、H{i,j}的位置
                case 2
                    H=[H{1,1},0,0,H{1,2},0,0;
                        H{2,1},0,0,H{2,2},0,0];
                case 3
                    H=[H{1,1},0,0,H{1,2},0,0;
                        H{2,1},0,0,H{2,2},0,0;
                        H{3,1},0,0,H{3,2},0,0];
            end            
        case 63
            switch Wei_Z
                case 1
                    H=[H{1,1},0,H{1,2},0,H{1,3},0];                    
                case 2
                    H=[H{1,1},0,H{1,2},0,H{1,3},0;
                       H{2,1},0,H{2,2},0,H{2,3},0];
                      
                case 3
                    H=[H{1,1},0,H{1,2},0,H{1,3},0;
                       H{2,1},0,H{2,2},0,H{2,3},0;
                       H{3,1},0,H{3,2},0,H{3,3},0];
            end
        case 93
            switch Wei_Z
                case 1
                    H=[H{1,1},0,0,H{1,2},0,0,H{1,3},0,0];                    
                case 2
                    H=[H{1,1},0,0,H{1,2},0,0,H{1,3},0,0;
                       H{2,1},0,0,H{2,2},0,0,H{2,3},0,0];
                case 3
                    H=[H{1,1},0,0,H{1,2},0,0,H{1,3},0,0;
                        H{2,1},0,0,H{2,2},0,0,H{2,3},0,0;
                        H{3,1},0,0,H{3,2},0,0,H{3,3},0,0;];
            end
        case 42
            switch Wei_Z  
                case 1
                    H=[H{1,1},0,H{1,2},0];                    
                case 2
                    H=[H{1,1},0,H{1,2},0;
                        H{2,1},0,H{2,2},0];
                case 3
                    H=[H{1,1},0,H{1,2},0;
                        H{2,1},0,H{2,2},0;
                        H{3,1},0,H{3,2},0];
            end
        otherwise
            msgbox('暂时未编写对应程序','注意','warn');
    end
end
handles.Wei_Z=Wei_Z;
guidata(hObject, handles);
H_2= H;
disp(H(1,1));disp(H(1,4));disp(H(2,1));disp(H(2,4));
Allneed2.Fx=Fx;
R_2=R;


% --- Executes on selection change in Motion_Popup.
function Motion_Popup_Callback(hObject, eventdata, handles)
% hObject    handle to Motion_Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Motion_Popup contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Motion_Popup

global T1_2;
global A_2;
global G_2;
global Q_2;
global Allneed2;
A=A_2;
G=G_2;
Q=Q_2;
T1=T1_2;
Flag=Allneed2.Flag_init;

Which=get(handles.Motion_Popup,'value');
for r=1:1
CV_I=[1 T1 0;0 1 0; 0 0 0];
CA_I=[1 T1 0.5*T1^2;0 1 T1; 0 0 1];   

G_AI=[0.5*T1^2,T1,1]';
G_VI=[T1,1,0]';
Q_I=0.1;

switch Which
    case 1       %CA模型 
        switch Flag
            case 21
                msgbox('当前初始数据下无默认的此模型，请重新选择','Warning','warn');return;
            case 22
                msgbox('当前初始数据下无默认的此模型，请重新选择','Warning','warn');return;
            case 31
                A=CA_I;
                G=G_AI;
                Q=Q_I;
            case 42
                 msgbox('当前初始数据下无默认的此模型，请重新选择','Warning','warn');return;
            case 62
                  A=[CA_I,zeros(3);zeros(3),CA_I];
                  G=[G_AI,zeros(3,1);zeros(3,1),G_AI];
                  Q=diag([Q_I,Q_I]);
            case 63
                msgbox('当前初始数据下无默认的此模型，请重新选择','Warning','warn');return;
            case 93
                A=[CA_I,zeros(3,6);zeros(3),CA_I,zeros(3);zeros(3,6),CA_I];
                G=[0.5*T1^2,0,0;T1,0,0;1,0,0;  0,0.5*T1^2,0;0,T1,0;0,1,0;0 0 0.5*T1^2;0,0,T1;0 0 1];
                Q=diag([Q_I,Q_I,Q_I]);
            otherwise
                msgbox('当前初始数据下无默认的此模型，请重新选择','Warning','warn');return;   
        end
    case 2  %CV模型
        switch Flag
            case 21
                A=[T1,1];
                G=1;
                Q=Q_I;
            case 22
                msgbox('当前初始数据下无默认的此模型，请重新选择','Warning','warn');return;
            case 31
                A=[1 T1 0;0 1 0; 0 0 0];
                G=[T1,1,0]';
                Q=Q_I;
            case 42
                 A=[1 T1 0 0;0 1  0 0; 0 0 1 T1; 0 0 0 1];
                 G=[T1 0; 1 0; 0 T1;0 1];
                 Q=diag([Q_I,Q_I]);
            case 62
                A=[CA_I,zeros(3);zeros(3),CA_I];
                G=[G_AI,zeros(3,1);zeros(3,1),G_AI];
                Q=diag([Q_I,Q_I]);
            case 63
                 A=[ 1 T1 0 0 0 0;
                     0 1  0 0 0 0;
                     0 0 1 T1 0 0; 
                     0 0 0 1 0 0 ;
                     0 0 0 0 1 T1
                     0 0 0 0 0 1 ];
                   
                 G=[T1 0 0; 1 0 0; 0 T1 0;0 1 0; 0 0 T1; 0 0 1];
                 Q=diag([Q_I,Q_I,Q_I]);
            case 93
                 A=[CV_I,zeros(3,6);zeros(3),CV_I,zeros(3);zeros(3,6),CV_I];
                G=[G_VI,zeros(3,2);zeros(3,1),G_VI,zeros(3,1);zeros(3,2),G_VI;];
                   Q=diag([Q_I,Q_I,Q_I]);
            otherwise
                msgbox('当前初始数据下无默认的此模型，请重新选择','Warning','warn');return;   
        end
    case 3
        
         w1=2*pi/100;     %%0.0628rad/s=3.6°/s     %之所以用w1不用w是因为与T1对应   %需要编写程序保留w1上次的输入值
         
        prompt={'Angular velocity'};
        title='Angular velocity';
        row=[2]';col=[30]';
        lines=[row,col];
        def={num2str(w1)};
        options.Resize='on';options.WindowStyle='normal';options.Interpreter='none';
        answer=inputdlg(prompt,title,lines,def,options);
        if isempty(answer)
           msgbox('角速度保留原值，将保存原状态','确认初始化','warn')                         %改进，当点击取消的时候不弹出此窗口，
        else
           w1=str2num(char(answer));
           %w1=answer;
        end
         
               switch Flag
                   case 42
                       A=[ 1  sin(w1*T1)/w1          0  (cos(w1*T1)-1)/w1   ;
                           0  cos(w1*T1)             0   -sin(w1*T1)        ;
                           0  (1-cos(w1*T1))/w1      1   sin(w1*T1)/w1      ;
                           0  sin(w1*T1)             0   cos(w1*T1)         ];
                       G=[1/2*T1^2,0; T1,0;   0,1/2*T1^2; 0,T1];
                       Q=diag([Q_I,Q_I]);
                   case 62
                       A=[ 1  sin(w1*T1)/w1        0   0  (cos(w1*T1)-1)/w1  0 ;
                           0  cos(w1*T1)           0   0   -sin(w1*T1)       0 ;
                           0   0                   0   0     0               0 ;
                           0  (1-cos(w1*T1))/w1    0   1   sin(w1*T1)/w1     0 ;
                           0  sin(w1*T1)           0   0   cos(w1*T1)        0 ;
                           0   0                   0   0     0              0 ];
                       G=[1/2*T1^2,0; T1,0;  0 0; 0,1/2*T1^2; 0,T1 ;0 0];
                       Q=diag([Q_I,Q_I]);
                   case 63
                       A=[ 1  sin(w1*T1)/w1          0  (cos(w1*T1)-1)/w1    0 0;
                           0  cos(w1*T1)             0   -sin(w1*T1)         0 0  ;
                           0  (1-cos(w1*T1))/w1      1   sin(w1*T1)/w1       0 0  ;
                           0  sin(w1*T1)             0   cos(w1*T1)          0 0  ;
                           0       0                 0        0              1 T1 ;
                           0       0                 0        0              0 1];
                       G=[T1,0 0; 1,0 0;  0  T1 0; 0,1 0; 0, 0 T1 ;0  0 1];
                       Q=diag([Q_I,Q_I,Q_I]);
                   case 93
                       chose=questdlg('Z方向机动否','请选择三维空间中CT模型','X-Y:CT,Z:CV','三维CT','X-Y:CT,Z:CV') ; %此时Z方向可单独建模
                       if strcmp(chose,'X-Y:CT,Z:CV')
                           A=[ 1  sin(w1*T1)/w1        0   0  (cos(w1*T1)-1)/w1  0  0  0  0;
                               0  cos(w1*T1)           0   0   -sin(w1*T1)       0  0  0  0 ;
                               0   0                   0   0     0               0  0  0  0;
                               0  (1-cos(w1*T1))/w1    0   1   sin(w1*T1)/w1     0  0  0  0 ;
                               0  sin(w1*T1)           0   0   cos(w1*T1)        0  0  0  0 ;
                               0   0                   0   0     0               0  0  0  0
                               0   0                   0   0     0               0  1 T1  0
                               0   0                   0   0     0               0  0  1  0
                               0   0                   0   0     0               0  0  0  0];
                           G=[T1,0 0; 1,0 0; 0 0 0; 0  T1 0; 0,1 0; 0 0 0; 0, 0 T1 ;0  0 1; 0 0 0;];
                           Q=diag([Q_I,Q_I,Q_I]);
                       else
                           F_w3_I=[ 1  sin(w1*T1)/w1   (1-cos(w1*T1))/w1^2   ;
                                    0   cos(w1*T1)       sin(w1*T1)/w1       ;
                                    0   -w1*sin(w1*T1)     cos(w1*T1)         ];
                           G_=[0.167*T1^3 0.5*T1^2 T1]';

                           %A=diag([F_w3_I F_w3_I F_w3_I]);%FUCK 这种写法不行！！！
                           A=[F_w3_I,zeros(3,6);zeros(3),F_w3_I,zeros(3);zeros(3,6),F_w3_I;];
                          % A=[CV_I,zeros(3,6);zeros(3),CV_I,zeros(3);zeros(3,6),CV_I];
                           G=[G_,zeros(3,2);zeros(3,1),G_,zeros(3,1);zeros(3,2),G_;];
                           Q=diag([Q_I,Q_I,Q_I]);
                       end
                   otherwise
                       msgbox('当前初始数据下无默认的CT模型，请重新选择','Warning','warn');return;
               end
           
          
    case 4
        msgbox('暂未编写Singer模型，请重新选择','Warning','warn');return;   
        return;
    case 5
        msgbox('暂未编写CS模型，请重新选择','Warning','warn');return;   
        return;
    otherwise
        msgbox('暂未编写模型，请重新选择','Warning','warn');return;   
        return;
end

end  
A_2=A;
G_2=G;
Q_2=Q;
%T1_2=T1;


% --- Executes during object creation, after setting all properties.
function Motion_Popup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Motion_Popup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Classical.
function Classical_Callback(hObject, eventdata, handles)
% hObject    handle to Classical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Classical
if get(handles.Classical,'value')==1
    set(handles.Motion_Popup,'visible','on');
    set(handles.CompletelyManual,'visible','on','value',0);
    set(handles.Classical,'visible','off');
end
Motion_Popup_Callback(hObject, eventdata, handles)


% --- Executes on button press in Prompt.
function Prompt_Callback(hObject, eventdata, handles)
% hObject    handle to Prompt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'The "X0" format is given!';'  ';'After clicking "Original State",the filter needs to be restarted'},'Prompt')


% --- Executes on button press in CompletelyManual.
function CompletelyManual_Callback(hObject, eventdata, handles)
% hObject    handle to CompletelyManual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CompletelyManual
if get(handles.CompletelyManual,'value')==1         %由于放在自己的回调函数内 ，并且会有相应的处理  在这里这个判断貌似没用了
    set(handles.Motion_Popup,'visible','off');
    set(handles.CompletelyManual,'visible','off');
    set(handles.Classical,'visible','on','value',0);
end


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in True.
function True_Callback(hObject, eventdata, handles)
% hObject    handle to True (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Wei_2;
global Xtrue_Data_2;
Wei=Wei_2;
Xtrue_Data=Xtrue_Data_2;

%=========导入数据=========
for r=1:1
[F_name,P_name]= uigetfile('*.mat');
Fullname=fullfile(P_name, F_name);
if isequal(F_name,0) || isequal(P_name,0)
      msgbox('User pressed cancel','确认载入数据','warn')
       return
end
try 
    F= load (Fullname);
catch
    msgbox('数据载入失败','Warning','warn','modal');
    return
end
F_cell=struct2cell(F);%%这里面需要一个判定程序判定 几维数据
Xtrue_Data=F_cell{1};

%==========绘图=================



 [m,n]=size(F_cell{1});
     switch m
         case 2
             if Wei==1
                 axes(handles.axes1);          %三维数据应该与二维数据分别画在不同坐标系里以解决 坐标系不能自动顺利的切换问题
                 set(handles.axes1,'Visible','on');       %当在下面的坐标系里关掉axes1,按道理下次没有这句语句，axes1应该看不见的啊——解释：axes(handles.axes1); 这条语句不仅将坐标系axes1置为当前坐标系而且可见
                 cla(handles.axes_3wei);
                 legend off;
                 set(handles.axes_3wei,'Visible','off');
                 plot(F_cell{1}(1,:));
             elseif Wei==2
                 axes(handles.axes1);
                 set(handles.axes1,'Visible','on');
                 cla(handles.axes_3wei);
                 legend off;
                 set(handles.axes_3wei,'Visible','off');
                 plot(F_cell{1}(1,:),F_cell{1}(2,:));
             else
                 msgbox('载入的数据与空间维数不符','Warning','warn','modal');
             end
         case 3
             if Wei==1
                 axes(handles.axes1);
                 set(handles.axes1,'Visible','on');
                 cla(handles.axes_3wei);
                 legend off;
                 set(handles.axes_3wei,'Visible','off');
                 plot(F_cell{1}(1,:));
             else
                 msgbox('载入的数据与空间维数不符','Warning','warn','modal');
             end
         case 4
             if Wei==2
                 axes(handles.axes1);
                 set(handles.axes1,'Visible','on');
                 cla(handles.axes_3wei);
                 legend off;
                 set(handles.axes_3wei,'Visible','off');
                 plot(F_cell{1}(1,:),F_cell{1}(3,:));
             else
                 msgbox('载入的数据与空间维数不符','Warning','warn','modal');
             end
         case 6
             if Wei==2
                 axes(handles.axes1);
                 set(handles.axes1,'Visible','on');
                 cla(handles.axes_3wei);
                 legend off;
                 set(handles.axes_3wei,'Visible','off');
                 plot(F_cell{1}(1,:),F_cell{1}(4,:));
             elseif Wei==3
                 cla(handles.axes1);
                 legend off;
                 set(handles.axes1,'Visible','off');
                 set(handles.axes_3wei,'Visible','on');     %每次运行在switch 之前都要关闭axes2 然后程序里再打开
                 axes(handles.axes_3wei);
                 plot3(F_cell{1}(1,:),F_cell{1}(3,:),F_cell{1}(5,:))         %所有三维坐标系的地方应该添加一个坐标系 已解决坐标系不能顺利切换的问题。
             else
                 msgbox('载入的数据与空间维数不符','Warning','warn','modal');
             end

         case 9
             if Wei==3
                 cla(handles.axes1);
                 legend off;
                 set(handles.axes1,'Visible','off');
                 set(handles.axes_3wei,'Visible','on');     %每次运行在switch 之前都要关闭axes2 然后程序里再打开
                 axes(handles.axes_3wei);
                 plot3(F_cell{1}(1,:),F_cell{1}(4,:),F_cell{1}(7,:))
             else
                 msgbox('载入的数据与空间维数不符','Warning','warn','modal');
             end
         otherwise
             msgbox('载入的数据不是标准的真实数据，无法绘图','Warning','warn','modal'); %之后的程序仍旧执行，retrun直接退出函数
             %return;
             cla(handles.axes1);
     end
end
Xtrue_Data_2=Xtrue_Data; 


% --- Executes on button press in Observed.
function Observed_Callback(hObject, eventdata, handles)
% hObject    handle to Observed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Obs_Data_2;
global Wei_2;
%global Allneed2;
Wei= Wei_2;
Obs_Data=Obs_Data_2;
%Wei_Z=Allneed2.Wei_Z; %Wei_Z的数值可以根据Obs_Data_2来取得

for r=1:1
%%===========输入数据===========
[F_name,P_name]= uigetfile('*.mat');
Fullname=fullfile(P_name, F_name);
if isequal(F_name,0) || isequal(P_name,0)
       msgbox('User pressed cancel','确认载入数据','warn')
       return
%else  disp(['User selected ', Fullname]) %调试程序时用
end
try 
     F= load (Fullname);
catch
    msgbox('数据载入失败','Warning','warn','modal');
    return
end
F_cell=struct2cell(F);%%这里面需要一个判定程序判定 几维数据
Obs_Data=F_cell{1};
               

% =========尝试显示观测数据=============
% %%%！！！！！！！！！！！显示观测数据的过程应该由已得到的函数反向解析出来该函数的三维空间坐标值 我这里用到了已知方程 作为通用性来讲是不行的
% 灵位一种做法是 不尝试绘图 最后只比较真实值和滤波值


  %应该判定不绘图的状态，实际上 我下面的程序出了标准的雷达情形外都不能绘图       
                                  

% 观测数据 需要根据 Wei和Wei_Z来自动转化为直角坐标系用于绘图
 [m,n]=size(F_cell{1});                    
 switch Wei
     case 1
             if m==1
                 msgbox('载入的数据不是标准空间的观测数据，','Warning','warn','modal');return;
             else

                 Back=questdlg('载入的数据不是标准的观测数据,是否继续','请选择','继续','退出','退出');%最后一项是默认选项
                 if strcmp(Back,'继续')
                     msgbox('仍能继续滤波，但不会绘图','Warning');
                 else
                     return
                 end
             end
     case 2
             if m==2                 %这里面要注意 3维空间里只有两个角度的情况，此时不能绘图 但程序应该仍能进行
                 axes(handles.axes1);
                 set(handles.axes1,'Visible','on');
                 cla(handles.axes_3wei);
                 legend off;
                 set(handles.axes_3wei,'Visible','off');
                 
              %=====使用先验信息绘图===   
                 hold on;
                 RLook=F_cell{1};
                 zx=RLook(1,:).*cos(RLook(2,:));
                 zy=RLook(1,:).*sin(RLook(2,:));
                 RLook_Zhi=[zx;zy];
                 plot(RLook_Zhi(1,:),RLook_Zhi(2,:),'k');
             %elseif m==1
             else
                 Back=questdlg('载入的数据不是标准的观测数据00000000,是否继续','请选择','继续','退出','退出');%最后一项是默认选项
                 if strcmp(Back,'继续')
                     msgbox('仍能继续滤波，但不会绘图','Warning');
                 else
                     return
                 end
             end
     case 3
             if m==3
                 cla(handles.axes1);
                 legend off;
                 set(handles.axes1,'Visible','off');
                 set(handles.axes_3wei,'Visible','on');     %每次运行在switch 之前都要关闭axes2 然后程序里再打开
                 axes(handles.axes_3wei);
                 
%=====使用先验信息绘图===   
                 hold on;
                 RLook=F_cell{1};
                 Zx=RLook(1,:).*cos(RLook(2,:)).*cos(RLook(3,:));          %依次的量是：距离、方位角、俯仰角 不同于球坐标系
                 Zy=RLook(1,:).*sin(RLook(2,:)).*cos(RLook(3,:));
                 Zz=RLook(1,:).*sin(RLook(3,:));
                 RLook_Zhi=[Zx;Zy;Zz];
                 plot3(RLook_Zhi(1,:),RLook_Zhi(2,:),RLook_Zhi(3,:),'k');
                 %elseif m==2
             else
                 Back=questdlg('载入的数据不是标准的观测数据,是否继续','请选择','继续','退出','退出');%最后一项是默认选项
                 if strcmp(Back,'继续')
                     msgbox('仍能继续滤波，但不会绘图','Warning');
                 else
                     return
                 end
             end
     otherwise        
          Back=warndlg('不是在真实空间,是否继续','注意');%最后一项是默认选项
           return;
 end
end

Obs_Data_2=Obs_Data; 


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)
% hObject    handle to Start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X0_2;%1
global P0_2;
global T1_2;
global Wei_2;

global A_2;%2
global G_2;
global Q_2;
global H_2;%3
global R_2;

global Xtrue_Data_2;%4
global Obs_Data_2;
global Result_EKF;
global Allneed2;
X0=X0_2;
P0=P0_2;
T1=T1_2;
Wei= Wei_2;
A= A_2;
G=G_2;
Q= Q_2;
H=H_2;
R=R_2;
Obs_Data=Obs_Data_2;
Xtrue_Data=Xtrue_Data_2;

Flag=Allneed2.Flag_init;
Fx=Allneed2.Fx;
Wei_Z=Allneed2.Wei_Z;

%========滤波部分==================================================

for r=1:1
 %=========准备部分=============
     if isempty(Obs_Data)
         msgbox('没有观测数据','确认初始化','warn')
         return;
     end
     n=length(X0);
     [m,Num]=size(Obs_Data);         %正常情况下观测数据的维数m 应该就是空间维数Wei,

     times=Num*T1;
     re_X=zeros(n,Num);    re_P=zeros(n,n,Num);  re_K=zeros(n,m,Num);

     try
         re_X(:,1)=X0;
         re_P(:,:,1)=P0;
     catch
         msgbox('滤波失败','Warning','warn','modal');
         return
     end
     [n_A,m_A]=size(A);
     if isempty(A)||(n_A~=n)
         msgbox('注意滤波器（Motion Model）是否（重新）进行初始化','确认初始化','warn')
     end
     [n_H,m_H]=size(H);   %H的行代表了观测方程的个数即Wei_Z 列数代表了空间维数Wei_2  %H的具体形式有待讨论
     if isempty(H)||(m_H~=n)                                                       %改进
         msgbox('注意滤波器（Measrue Model）是否（重新）进行初始化','确认初始化','warn')
     end

%==========正式滤波=========

    for k=2:Num
        Z=Obs_Data(:,k);  
        xyuce=A*re_X(:,k-1);
        syms x y z;
        
        %同样需要根据Flag 和Wei_Z来赋值，同时由于符号变量不能做参数 这里同时计算了Zyuce
        switch Flag
            case 62
                H1=subs(H,{x,y},[xyuce(1),xyuce(4)]); 
               
                zyuce=subs(Fx,{x,y},[xyuce(1),xyuce(4)]);%由于符号变量中atan2函数无法使用导致zyuce的角度取值范围缩小 因此滤波不可以。
                                                                             %这个式子导致仍旧使用了先验信息。。。如果先输入 方位角 再输入距离呢。
if xyuce(1)<0                                                                %这个问题对于x没有小于0的情形需要解决。
    zyuce(2)= zyuce(2)+pi;
end

            case 63
                H1=subs(H,{x,y,z},[xyuce(1),xyuce(3),xyuce(5)]); 
                zyuce=subs(Fx,{x,y,z},[xyuce(1),xyuce(3),xyuce(5)]);
            case 93
                H1=subs(H,{x,y,z},[xyuce(1),xyuce(4),xyuce(7)]); 
                zyuce=subs(Fx,{x,y,z},[xyuce(1),xyuce(4),xyuce(7)]);
 if xyuce(1)<0                                                              %这个问题对于x没有小于0的情形需要解决。                        
    zyuce(2)= zyuce(2)+pi;
end
            case 42
                H1=subs(H,{x,y},[xyuce(1),xyuce(3)]); 
                zyuce=subs(Fx,{x,y},[xyuce(1),xyuce(3)]);
            otherwise
                msgbox('暂时未编写对应程序','注意','warn');
        end
       

       [re_X(:,k),re_P(:,:,k),re_K(:,:,k)]=EKf_GUI(re_X(:,k-1),re_P(:,:,k-1),Z,A,G,Q,H1,R,zyuce); %参数Flag貌似不用了 但是需要一个参数来计算预测的观测值Zk
    end
%======保存结果Result_EKF======
    Result_EKF.X=re_X;
    Result_EKF.P=re_P;
    Result_EKF.K=re_K;    %在此有没有必要多存一遍re_K 
    Result_EKF.Flag=Flag;  %通过设置一个标志位来确定是何种情况，后面的程序只要根据此标志位就行了Flag

    Gain.K=re_K;
    Result_EKF.Gain=0;  
    Result_EKF.Error=0;%初始化，防止程序中出现没有域名的错误
end

% ============================绘图======================================
for r=1:1

    switch Flag
        case 21
            axes(handles.axes1);
            set(handles.axes1,'Visible','on');
            cla(handles.axes_3wei);
            legend off;
            set(handles.axes_3wei,'Visible','off');
            plot(re_X(1,:),'r');
        case 22
            axes(handles.axes1);
            set(handles.axes1,'Visible','on');
            cla(handles.axes_3wei);
            legend off;
            set(handles.axes_3wei,'Visible','off');
            plot(re_X(1,:),re_X(2,:),'r');
        case 31
            axes(handles.axes1);
            set(handles.axes1,'Visible','on');
            cla(handles.axes_3wei);
            legend off;
            set(handles.axes_3wei,'Visible','off');
            plot(re_X(1,:),'r');
        case 42
            axes(handles.axes1);
            set(handles.axes1,'Visible','on');
            cla(handles.axes_3wei);
            legend off;
            set(handles.axes_3wei,'Visible','off');
            plot(re_X(1,:),re_X(3,:),'r',re_X(1,1),re_X(3,1),'sr');
        case 62
            axes(handles.axes1);
            set(handles.axes1,'Visible','on');
            cla(handles.axes_3wei);
            legend off;
            set(handles.axes_3wei,'Visible','off');
            plot( re_X(1,:),re_X(4,:),'r',re_X(1,1),re_X(4,1),'sr');
            legend('真实值','观测值','滤波值','滤波初始点','Location','Best' );
            % set(handles.axes1,'XLim',[-90000,10000],'YLim',[7800,8200])
        case 63
            %三维绘图需要专门设置一个坐标系
            cla(handles.axes1);
            legend off;
            set(handles.axes1,'Visible','off');
            set(handles.axes_3wei,'Visible','on');
            axes(handles.axes_3wei);
            plot3(re_X(1,:),re_X(3,:),re_X(5,:),'r',re_X(1,1),re_X(3,1),X0(5,1),'sr');
        case 93
            cla(handles.axes1);
            legend off;
            set(handles.axes1,'Visible','off');
            set(handles.axes_3wei,'Visible','on');
            axes(handles.axes_3wei);
            plot3(re_X(1,:),re_X(4,:),re_X(7,:),'r',re_X(1,1),re_X(4,1),re_X(7,1),'sr');
            Flag=93;
            % disp(re_X);
        otherwise
            msgbox('滤波完成，但绘图出错','Warning','warn');
            %return;
            cla(handles.axes1);
            return;
    end
end
 set(handles.DataAnalysis,'Visible','on');    %--------成功绘图之后才展示ShowResult弹出菜单
 
% ============================数据分析==================================

for r=1:1
    switch Flag
        case 21
            msgbox('滤波完成，暂时未编写数据处理的程序请见谅','Warning','warn');return;%加不加return 呢？
        case 22
            
            msgbox('滤波完成，暂时未编写数据处理的程序请见谅','Warning','warn');
            
        case 31
            msgbox('滤波完成，暂时未编写数据处理的程序请见谅','Warning','warn');
        case 42
            msgbox('滤波完成，暂时未编写数据处理的程序请见谅','Warning','warn');
        case 62                        %误差分析以及K值变化处理
            
            try
                [Error.x,Error.y,Error.xv,Error.yv,Error.xa,Error.ya,Error.X,Error.V,Error.A]=Err(re_X,Xtrue_Data);
                
                Result_EKF.Error=Error;
                
                %disp(Result)  %调试程序时使用
                %disp(Result.Error.x)  %这种调用格式可以
                Kx=reshape(re_K(1,1,:),1,size(re_K(1,1,:),3));Kx(1)=Kx(2);
                Ky=reshape(re_K(4,2,:),1,size(re_K(4,2,:),3));Ky(1)=Ky(2);
                Kxv=reshape(re_K(2,1,:),1,size(re_K(2,1,:),3));Kxv(1)=Kxv(2);
                Kyv=reshape(re_K(5,2,:),1,size(re_K(5,2,:),3));Kyv(1)=Kyv(2);
                Kxa=reshape(re_K(3,1,:),1,size(re_K(3,1,:),3));Kxa(1)=Kxa(2);
                Kya=reshape(re_K(6,2,:),1,size(re_K(6,2,:),3));Kya(1)=Kya(2);
                
                Gain.Kx=Kx; Gain.Kxv=Kxv;   Gain.Kxa=Kxa;
                Gain.Ky=Ky; Gain.Kyv=Kyv;   Gain.Kya=Kya;
               Result_EKF.Gain=Gain;
                %disp(Result)
                %disp(Result.Gain.Kxv)
            catch
                msgbox('滤波完成，但数据分析出错','Warning','warn');
            end
        case 63
            msgbox('滤波完成，暂时未编写数据处理的程序请见谅','Warning','warn');
        case 93
                % try
                     [Error.x,Error.y,Error.z,  Error.xv,Error.yv,Error.zv,  Error.xa,Error.ya,Error.za,  Error.X,Error.V,Error.A]=Err93(re_X,Xtrue_Data);
                     Result_EKF.Error=Error;

                     %disp(Result)  %调试程序时使用
                     %disp(Result.Error.x)  %这种调用格式可以
                     Kx=reshape(re_K(1,1,:),1,size(re_K(1,1,:),3));Kx(1)=Kx(2);
                     Ky=reshape(re_K(4,2,:),1,size(re_K(4,2,:),3));Ky(1)=Ky(2);
                     Kz=reshape(re_K(7,3,:),1,size(re_K(7,3,:),3));Kz(1)=Kz(2);

                     Kxv=reshape(re_K(2,1,:),1,size(re_K(2,1,:),3));Kxv(1)=Kxv(2);
                     Kyv=reshape(re_K(5,2,:),1,size(re_K(5,2,:),3));Kyv(1)=Kyv(2);
                     Kzv=reshape(re_K(8,3,:),1,size(re_K(8,3,:),3));Kzv(1)=Kzv(2);

                     Kxa=reshape(re_K(3,1,:),1,size(re_K(3,1,:),3));Kxa(1)=Kxa(2);
                     Kya=reshape(re_K(6,2,:),1,size(re_K(6,2,:),3));Kya(1)=Kya(2);
                     Kza=reshape(re_K(9,3,:),1,size(re_K(9,3,:),3));Kza(1)=Kza(2);
                     Gain.Kx=Kx; Gain.Kxv=Kxv;   Gain.Kxa=Kxa;
                     Gain.Ky=Ky; Gain.Kyv=Kyv;   Gain.Kya=Kya;
                     Gain.Kz=Kz; Gain.Kzv=Kzv;   Gain.Kza=Kza;
                     Result_EKF.Gain=Gain;
                 %catch
                  %   msgbox('滤波完成，但数据分析出错','Warning','warn');
                % end
        otherwise
            msgbox('滤波完成，但数据分析出错','Warning','warn');
            cla(handles.axes1);
            return;
    end
end
 save Result_EKF Result_EKF  %前面的是保存到当前目录下的文件名 后面的是要保存的变量  

% --- Executes on button press in ClearF.
function ClearF_Callback(hObject, eventdata, handles)
% hObject    handle to ClearF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Wei_2;
Wei=Wei_2;
    cla(handles.axes1);
    legend(handles.axes1,'off')
    cla(handles.axes2);
    legend(handles.axes2,'off')
    cla(handles.axes3);
    legend(handles.axes3,'off')
    cla(handles.axes_3wei);
    legend(handles.axes_3wei,'off')
%axes(handles.axes1);
 
 set(handles.axes2,'Visible','off');  
 set(handles.axes3,'Visible','off');  
 if Wei==3
     set(handles.axes_3wei,'Visible','on');  %这里需要一个判定当前坐标系 是3维还是 2维
     set(handles.axes1,'Visible','off');
 else
     set(handles.axes_3wei,'Visible','off');  %这里需要一个判定当前坐标系 是3维还是 2维
     set(handles.axes1,'Visible','on');
 end
  set(handles.DataAnalysis,'Visible','off'); 

% --- Executes on button press in Export.
function Export_Callback(hObject, eventdata, handles)
% hObject    handle to Export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Popout.
function Popout_Callback(hObject, eventdata, handles)
% hObject    handle to Popout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Popout
ShowResult_Callback(hObject, eventdata, handles);

% --- Executes on selection change in ShowResult.
function ShowResult_Callback(hObject, eventdata, handles)
% hObject    handle to ShowResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ShowResult contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ShowResult
global Xtrue_Data_2;
global Obs_Data_2;
global Result_EKF;
Xtrue_Data=Xtrue_Data_2;
Obs_Data=Obs_Data_2;
Result=Result_EKF;
if isempty(Obs_Data)
         msgbox('没有观测数据','确认初始化','warn') 
      return;
end
re_X=Result.X;
re_P=Result.P;
re_K=Result.K;
Gain=Result.Gain;  
Error=Result.Error;
Flag=Result.Flag;

ShowWhich=get(handles.ShowResult,'value');
%disp(ShowWhich)

%判断是否弹出显示
if get(handles.Popout,'value')==1
    figure;
else

axes(handles.axes1);             %--------此处决定了是画在同一个坐标系 还是另外单独的坐标系,在此设置的话默认画在同一个坐标系！！！！！！
            
set(handles.axes1,'Visible','on');       %当在下面的坐标系里关掉axes1,按道理下次没有这句语句，axes1应该看不见的啊——解释：axes(handles.axes1); 这条语句不仅将坐标系axes1置为当前坐标系而且可见
cla(handles.axes2);
set(handles.axes2,'Visible','off');   
cla(handles.axes3);
set(handles.axes3,'Visible','off');
cla(handles.axes_3wei);
legend( handles.axes_3wei,'off');
set(handles.axes_3wei,'Visible','off');
%---------------------------------
end

hold off;
for r=1:1
switch ShowWhich
    case 1    
        switch Flag
            case 21
                plot(re_X(1,:),'r');
            case 22
                plot(re_X(1,:),re_X(2,:),'r');
            case 31
                plot(re_X(1,:),'r'); 
            case 42
                 plot(re_X(1,:),re_X(3,:),'r',re_X(1,1),re_X(3,1),'sr');    
            case 62
                   % hold on; 放在此处不行，比如画完位移误差，再画轨迹图的时候 这句语句与程序开头的hold  off抵消了，因此可以先画一个图
                 plot(Xtrue_Data(1,:),Xtrue_Data(4,:));
                 hold on; 
                 
                 RLook=Obs_Data;
                 zx=RLook(1,:).*cos(RLook(2,:));
                 zy=RLook(1,:).*sin(RLook(2,:));
                 RLook_Zhi=[zx;zy];
                plot(RLook_Zhi(1,:),RLook_Zhi(2,:),'k');
               % plot(Obs_Data(1,:),Obs_Data(2,:),'k');
                
                plot( re_X(1,:),re_X(4,:),'r',re_X(1,1),re_X(4,1),'sr'); 
                legend('真实值','观测值','滤波值','滤波初始点','Location','Best' );  
                hold off;
            case 63
                if get(handles.Popout,'value')==1
                    plot3(Xtrue_Data(1,:),Xtrue_Data(3,:),Xtrue_Data(3,:));
                    hold on;
                    %不能直接画观测数据
             %plot3(Obs_Data(1,:),Obs_Data(2,:),Obs_Data(3,:),'k');
                    plot3(re_X(1,:),re_X(3,:),re_X(5,:),'r',re_X(1,1),re_X(3,1),re_X(5,1),'sr');
                    legend('真实值','观测值','滤波值','滤波初始点','Location','Best' );
                else
                    cla(handles.axes1);
                    legend off;
                    set(handles.axes1,'Visible','off');
                    set(handles.axes_3wei,'Visible','on');
                    axes(handles.axes_3wei);
                    
                    plot3(Xtrue_Data(1,:),Xtrue_Data(3,:),Xtrue_Data(5,:));
                    hold on;
                    %不能直接这样画观测数据 观测数据的图像显示 其实很麻烦 因为这里有涉及到先验信息的缘故了 通用性情形下
                    %要用观测数据解析出来再画
              % plot3(Obs_Data(1,:),Obs_Data(2,:),Obs_Data(3,:),'k');
                    plot3(re_X(1,:),re_X(3,:),re_X(5,:),'r',re_X(1,1),re_X(3,1),re_X(5,1),'sr');
                    legend('真实值','观测值','滤波值','滤波初始点','Location','Best' );
                    hold off;
                end
            case 93
                if get(handles.Popout,'value')==1
                    plot3(Xtrue_Data(1,:),Xtrue_Data(4,:),Xtrue_Data(7,:));
                    hold on;
                    
                    RLook=Obs_Data;
                    Zx=RLook(1,:).*cos(RLook(2,:)).*cos(RLook(3,:));          %依次的量是：距离、方位角、俯仰角 不同于球坐标系
                    Zy=RLook(1,:).*sin(RLook(2,:)).*cos(RLook(3,:));
                    Zz=RLook(1,:).*sin(RLook(3,:));
                    RLook_Zhi=[Zx;Zy;Zz];
                    plot3(RLook_Zhi(1,:),RLook_Zhi(2,:),RLook_Zhi(3,:),'k');
                    plot3(re_X(1,:),re_X(4,:),re_X(7,:),'r',re_X(1,1),re_X(4,1),re_X(7,1),'sr');
                    legend('真实值','观测值','滤波值','滤波初始点','Location','Best' );
                else
                    cla(handles.axes1);
                    legend off;
                    set(handles.axes1,'Visible','off');
                    set(handles.axes_3wei,'Visible','on');
                    axes(handles.axes_3wei);
                    
                    plot3(Xtrue_Data(1,:),Xtrue_Data(4,:),Xtrue_Data(7,:));
                    hold on;
                    RLook=Obs_Data;
                    Zx=RLook(1,:).*cos(RLook(2,:)).*cos(RLook(3,:));          %依次的量是：距离、方位角、俯仰角 不同于球坐标系
                    Zy=RLook(1,:).*sin(RLook(2,:)).*cos(RLook(3,:));
                    Zz=RLook(1,:).*sin(RLook(3,:));
                    RLook_Zhi=[Zx;Zy;Zz];
                    plot3(RLook_Zhi(1,:),RLook_Zhi(2,:),RLook_Zhi(3,:),'k');
                    
                    plot3(re_X(1,:),re_X(4,:),re_X(7,:),'r',re_X(1,1),re_X(4,1),re_X(7,1),'sr');
                    legend('真实值','观测值','滤波值','滤波初始点','Location','Best' );
                    hold off;
                end
                
            otherwise
                 msgbox('滤波完成，但绘图出错','Warning','warn'); 
                 cla(handles.axes1);         
                 return;
        end
    case 2
         switch Flag
            case 21
                 msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');return;
            case 22
                msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');return;
            case 31
                msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');return;
            case 42
                msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');return;
            case 62
                %hold off;
                 plot(Error.X,'r');  %这里的X表示不是x方向，而是合位移，其与V A对应，而x,y,z分别代表各个方向
                %hold on;
                 title('总的位移估计误差');
            case 63
                msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');return;
            case 93
                 plot(Error.X,'r');
                title('总的位移估计误差');  
            otherwise
                 msgbox('滤波完成，但绘图出错','Warning','warn'); 
                 cla(handles.axes1);                                               %%改进 是否要清楚
                 return;
        end
    case 3        %暂时只对62的情况编程，其他情况下的程序有待完善   case 93需要首先编写
        switch Flag
            case 62 
                 plot(Error.V,'r'); 
                 title('总的速度估计误差');
            case 93
                plot(Error.V,'r');
                title('总的速度估计误差');
            otherwise
                msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 4
         switch Flag
             case 62
                  plot(Error.A,'r'); 
                  title('总的加速度估计误差');
             case 93
                    plot(Error.A,'r');
                    title('总的加速度估计误差');
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 5
        switch Flag
             case 62
                
%                    %subplot(2,1,1);                 %subplot是把图分别在不同的坐标当中即不同的axes中 因此这里面暂时放弃了这中编写方式
%                                                     %都直接写在一个图里，通过legend区分
%                                                     %解决方法：1、多坐标系；2、不使用subplot;3、寻找坐标系控制语句控制这个问题4、弹出
%                   plot(Error.x,'r');                %在此 为了尝试多坐标系的编程特意让case特殊一下，这里的源程序也好用 
%                   hold on;           
%                   % subplot(2,1,2); 
%                   plot(Error.y,'g'); 
%                   title('位移估计误差');
%                   legend('x方向','y方向');
%                   hold off;           %之所以加这个语句是想表明，这里hold on;hold off;只是在小的语句块里做的变化，并不影响上一次switch的相关语句，保持一定独立性
%                   
%----------------------尝试多坐标系绘图--------
                    if get(handles.Popout,'value')==1
                        subplot(2,1,1);
                        plot(Error.x,'r');
                        title('x方向位移估计误差');
                        subplot(2,1,2);
                        plot(Error.y,'g');
                        title('y方向位移估计误差');
                    else
                        cla(handles.axes1);
                        legend off;
                        set(handles.axes1,'Visible','off');
                        set(handles.axes2,'Visible','on');     %每次运行在switch 之前都要关闭axes2 然后程序里再打开
                        set(handles.axes3,'Visible','on');
                        axes(handles.axes2);
                        plot(Error.x,'r');
                        title('x方向位移估计误差');
                        axes(handles.axes3);
                        plot(Error.y,'g');
                        title('y方向位移估计误差');
                    end
                case 93                                 
                  plot(Error.x,'r');               
                  hold on;           
                  plot(Error.y,'g'); 
                  plot(Error.z,'b'); 
                  title('位移估计误差');
                  legend('x方向','y方向','z方向');
                  hold off;    
                  
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 6
        switch Flag
             case 62
                  
                  plot(Error.xv,'r'); 
                  hold on;
                  plot(Error.yv,'g'); 
                  title('速度估计误差');
                  legend('x方向','y方向');
                  hold off;
              case 93                  
                  plot(Error.xv,'r'); 
                  hold on;
                  plot(Error.yv,'g'); 
                  plot(Error.zv,'b');
                  title('速度估计误差');
                  legend('x方向','y方向','z方向');
                  hold off;
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 7
        switch Flag
             case 62
                  
                  plot(Error.xa,'r');    
                  hold on;
                  plot(Error.ya,'g'); 
                  title('加速度估计误差');
                  legend('x方向','y方向');
                  hold off;
             case 93
                 plot(Error.xa,'r');    
                  hold on;
                  plot(Error.ya,'g'); 
                   plot(Error.za,'b');
                  title('加速度估计误差');
                  legend('x方向','y方向','z方向');
                  hold off;
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 8
        switch Flag
               case 62           
                  plot(Gain.Kx,'r');                  
                  title('x方向位移K值变化');   
                  legend('位移'); 
               case 93           
                  plot(Gain.Kx,'r');                  
                  title('x方向位移K值变化');   
                  legend('位移'); 
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 9
        switch Flag
             case 62                   
                  plot(Gain.Kx,'r'); 
                  hold on;                   
                  plot(Gain.Kxv,'g');
                  plot(Gain.Kxa,'b'); 
                  title('x方向K值变化');   
                  legend('位移','速度','加速度');
                  hold off;
            case 93
                  plot(Gain.Kx,'r'); 
                  hold on;                  
                  plot(Gain.Kxv,'g');                   
                  plot(Gain.Kxa,'b'); 
                  title('x方向K值变化');   
                  legend('位移','速度','加速度');
                  hold off;                  
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 10
         switch Flag
             case 62
                
                  plot(Gain.Ky,'r'); 
                  hold on;
                  plot(Gain.Kyv,'g');                    
                  plot(Gain.Kya,'b'); 
                  title('y方向K值变化');  
                  legend('位移','速度','加速度');
                  hold off;
             case 93
                  plot(Gain.Ky,'r'); 
                  hold on;
                  plot(Gain.Kyv,'g');                    
                  plot(Gain.Kya,'b'); 
                  title('y方向K值变化');  
                  legend('位移','速度','加速度');
                  hold off;                      
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
        end
    case 11
         switch Flag
             case 62
                  msgbox('图像不存在Z方向数据','Warning','warn');   
             case 93
              
                  plot(Gain.Kz,'r'); 
                  hold on;                 
                  plot(Gain.Kzv,'g');              
                  plot(Gain.Kza,'b'); 
                  title('z方向K值变化'); 
                  legend('位移','速度','加速度');
                   hold off;
             otherwise  
                    msgbox('滤波完成，暂时未编写数据处理展示绘图程序','Warning','warn');
                   return;
         end
    otherwise  
         msgbox('滤波完成，但数据分析展示绘图出错','Warning','warn'); 
         cla(handles.axes1);         
         return;
end
        
end        
hold on;%在同一个坐标系画图的时候必须考虑的问题

% --- Executes during object creation, after setting all properties.
function ShowResult_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShowResult (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T1_2;
global Wei_2;
global X0_2;
global P0_2;
global Allneed2;   
% X0_2=[6100,-410,0,8100,2,0]';
% P0_2=diag([100^2 10^2 0 100^2 10^2 0]);         
% T1_2=2;
% Wei_2=2;                                                                   %！！与KamGUI_1_1的不同、改进：初始化赋值不同
% Allneed2.Flag_init=62;
% Allneed2.Wei_Z=2;

X0_2=[0 200 -25 0 0 25 0 0 60]';
P0_2=diag([100 10 1 100 10 1 100 10 1]);                                  %需要解决输出显示的对齐
T1_2=0.01;
Wei_2=3;
Allneed2.Flag_init=93;
Allneed2.Wei_Z=3;

%滤波器的初始化 是否在此进行，需要后续验证，但是现在不初始化的话程序也能识别了。
global A_2;
global G_2;
global Q_2;
global H_2;
global R_2;
CA_I=[1 T1_2 0.5*T1_2^2;0 1 T1_2; 0 0 1];       
A_2=[CA_I,zeros(3,6);zeros(3),CA_I,zeros(3);zeros(3,6),CA_I];
G_2=[0.5*T1_2^2,0,0;T1_2,0,0;1,0,0;  0,0.5*T1_2^2,0;0,T1_2,0;0,1,0;0 0 0.5*T1_2^2;0,0,T1_2;0 0 1];
Q_I=0.1;
Q_2=diag([Q_I,Q_I,Q_I]);

syms x y z;                                                                      %这里是二维雷达 现在需要编写三维雷达情况。
% f1=sqrt(x^2+y^2);f2=atan(y/x);
% h11=x/(x^2 + y^2)^(1/2);h12=y/(x^2 + y^2)^(1/2);h21=-y/(x^2 + y^2);h22=x/(x^2 + y^2);
% Allneed2.Fx={f1;f2};
% H={h11,h12;h21 h22};                                      %H的真正的值 应该根据Allneed.Flag_init和 Allneed.Wei_Z来确定。
%H_2=[H{1,1},0,0,H{1,2},0,0;H{2,1},0,0,H{2,2},0,0];
% R_2=diag([10000,0.0001]);

f1=sqrt(x^2+y^2+z^2);f2=atan(y/x);f3=atan(z/sqrt(x^2+y^2));
    R1=sqrt(x^2+y^2+z^2);  r1=sqrt(x^2+y^2);
h11=x/R1;h12=y/R1; h13=z/R1;
h21=-y/(x^2+y^2); h22=-x/(x^2+y^2);  h23=0;
h31=-x*z/(R1^2*r1); h32=-y*z/(R1^2*r1); h33=r1/R1^2;
H={h11,h12,h13;h21 h22 h23; h31 h32 h33};%H的真正的值 应该根据Allneed.Flag_init和 Allneed.Wei_Z来确定。
H_2=[H{1,1},0,0,H{1,2},0,0,H{1,3},0,0;
     H{2,1},0,0,H{2,2},0,0,H{2,3},0,0;
    H{3,1},0,0,H{3,2},0,0,H{3,3},0,0;];
Allneed2.Fx={f1;f2;f3};
R_2=diag([10000,0.0001,0.0001]);
%========
ClearF_Callback(hObject, eventdata, handles)



% --- Executes on button press in PromptObserve.
function PromptObserve_Callback(hObject, eventdata, handles)
% hObject    handle to PromptObserve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox({'Symbols are limited to be used as "x y z"';'  '},'Prompt')


function pushbutton23_Callback(hObject, eventdata, handles)


function Observed_KeyPressFcn(hObject, eventdata, handles)


function Observed_ButtonDownFcn(hObject, eventdata, handles)
