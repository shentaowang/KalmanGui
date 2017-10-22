function varargout = init_param(varargin)
% INIT_PARAM MATLAB code for init_param.fig
%      INIT_PARAM, by itself, creates a new INIT_PARAM or raises the existing
%      singleton*.
%
%      H = INIT_PARAM returns the handle to a new INIT_PARAM or the handle to
%      the existing singleton*.
%
%      INIT_PARAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INIT_PARAM.M with the given input arguments.
%
%      INIT_PARAM('Property','Value',...) creates a new INIT_PARAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before init_param_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to init_param_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help init_param

% Last Modified by GUIDE v2.5 15-Oct-2017 20:35:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @init_param_OpeningFcn, ...
                   'gui_OutputFcn',  @init_param_OutputFcn, ...
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


% --- Executes just before init_param is made visible.
function init_param_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to init_param (see VARARGIN)

%change the position
h = get(gcf,'Position');
h = [ 20 20 h(3:4)];
set(gcf,'Position',h);

% Choose default command line output for init_param
global DIM_MAX; DIM_MAX = 10;
global SAMPLE_T_MAX; SAMPLE_T_MAX = 10000;
global init_x;
global init_p;
global init_q;
global init_r;
global init_f_str;
global init_h_str;
global dim_x;
global dim_z;
global sample_t;
global islegal_param;
is_inrange = dim_x > 0 && dim_x < DIM_MAX && dim_z > 0 && dim_z < DIM_MAX;
is_integer = (dim_x == fix(dim_x)) && (dim_z == fix(dim_z));
if is_inrange && is_integer && ~islegal_param
    set(handles.edit_dim_x,'string',num2str(dim_x));
    set(handles.edit_dim_z,'string',num2str(dim_z));
    set(handles.edit_init_x,'string',num2str(zeros(1, dim_x)));
    set(handles.edit_init_p,'string',num2str(zeros(dim_x,dim_x)));
    set(handles.edit_transition,'string',num2str(zeros(dim_x,dim_x)));
    init_f_str = '';
    set(handles.edit_observe,'string',num2str(zeros(dim_z,dim_x)));
    init_h_str = '';
    set(handles.edit_init_q,'string',num2str(zeros(dim_x,dim_x)));
    set(handles.edit_init_r,'string',num2str(zeros(dim_z,dim_z)));
elseif is_inrange && is_integer && islegal_param
    set(handles.edit_dim_x,'string',num2str(dim_x));
    set(handles.edit_dim_z,'string',num2str(dim_z));
    set(handles.edit_init_x,'string',num2str(init_x'));
    set(handles.edit_init_p,'string',num2str(init_p));
    set(handles.edit_init_q,'string',num2str(init_q));
    set(handles.edit_init_r,'string',num2str(init_r));
    set(handles.edit_transition,'string',init_f_str);
    set(handles.edit_observe,'string',init_h_str);
else
    set(handles.edit_dim_x,'string','');
    set(handles.edit_dim_z,'string','');
    set(handles.edit_init_x,'string','');
    set(handles.edit_init_p,'string','');
    set(handles.edit_transition,'string','');
    init_f_str = '';
    set(handles.edit_observe,'string','');
    init_h_str = '';
    set(handles.edit_init_q,'string','');
    set(handles.edit_init_r,'string','');
end

is_inrange = sample_t > 0 && sample_t < SAMPLE_T_MAX;
if is_inrange
    set(handles.edit_sample_time,'string',num2str(sample_t));
else
    set(handles.edit_sample_time,'string','');
end
% Update handles structure
handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes init_param wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = init_param_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function edit_dim_x_Callback(hObject, eventdata, handles)
global dim_x;
global dim_z
global DIM_MAX;
str = get(hObject,'string');
val = str2double(str);
is_inrange = val > 0 && val < DIM_MAX;
is_integer = val == fix(val);
if is_inrange && is_integer
    dim_x = val;
    set(handles.edit_init_x,'string',num2str(zeros(1, dim_x)));
    set(handles.edit_init_p,'string',num2str(zeros(dim_x,dim_x)));
    set(handles.edit_transition,'string',num2str(zeros(dim_x,dim_x)));
    set(handles.edit_observe,'string',num2str(zeros(dim_z,dim_x)));
    set(handles.edit_init_q,'string',num2str(zeros(dim_x,dim_x)));
else
    dim_x = 0;
    set(handles.edit_init_x,'string','');
    set(handles.edit_init_p,'string','');
    set(handles.edit_transition,'string','');
    set(handles.edit_observe,'string','');
    set(handles.edit_init_q,'string','');
end

function edit_dim_x_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_dim_z_Callback(hObject, eventdata, handles)
global dim_z;
global dim_x;
global DIM_MAX;
str = get(hObject,'string');
val = str2double(str);
is_inrange = val > 0 && val < DIM_MAX;
is_integer = val == fix(val);
if is_inrange && is_integer
    dim_z = val;
    set(handles.edit_observe,'string',num2str(zeros(dim_z,dim_x)));
    set(handles.edit_init_r,'string',num2str(zeros(dim_z,dim_z)));
else
    dim_z = 0;
    set(handles.edit_observe,'string','');
    set(handles.edit_init_r,'string',num2str(zeros(dim_z,dim_z)));
end


function edit_dim_z_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_sample_time_Callback(hObject, eventdata, handles)
global sample_t;
global SAMPLE_T_MAX;
str = get(hObject,'string');
val = str2double(str);
is_inrange = val > 0 && val < SAMPLE_T_MAX;
if is_inrange
    sample_t = val;
else
    sample_t = 0;
end

function edit_sample_time_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_init_x_Callback(hObject, eventdata, handles)
global init_x;
str = get(hObject,'string');
val = str2num(str);
init_x = val';



function edit_init_x_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_init_p_Callback(hObject, eventdata, handles)
global init_p;
str = get(hObject,'string');
val = str2num(str);
init_p = val;



function edit_init_p_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_back_main_Callback(hObject, eventdata, handles)
close(init_param);
main();


%the simplest
function edit_transition_Callback(hObject, eventdata, handles)
global init_f;
global init_f_str;
global transition_style;
global sample_t
global dim_x
init_f_str = get(hObject,'string');
if strcmp(transition_style,'matrix')
    init_f_str_trans = '';
    for k=1:dim_x
        if ~isempty(strfind(init_f_str(k,:),'sat')) && sample_t==0
            msgbox('请输入合法采样时间','Error','error');
            return;
        elseif ~isempty(strfind(init_f_str(k,:),'sat')) && sample_t~=0
           init_f_str_trans  = char(init_f_str_trans,strrep(init_f_str(k,:),'sat',num2str(sample_t/1000)));
        else
            init_f_str_trans  = char(init_f_str_trans,init_f_str(k,:));
        end
    end
    val = str2num(init_f_str_trans);
    init_f = val;
else
    if ~isempty(strfind(init_f_str,'sat')) && sample_t==0
        msgbox('请输入合法采样时间','Error','error');
        return;
    end
    init_f_str_trans = strrep(init_f_str,'sat',num2str(sample_t/1000));
    init_f = str2func(init_f_str_trans);
end

function edit_transition_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%the simplest 
function edit_observe_Callback(hObject, eventdata, handles)
global init_h
global init_h_str
global dim_z
global observe_style
global sample_t
init_h_str = get(hObject,'string');
if strcmp(observe_style,'matrix')
    init_h_str_trans = '';
    for k=1:dim_z
        if ~isempty(strfind(init_h_str(k,:),'sat')) && sample_t==0
            msgbox('请输入合法采样时间','Error','error');
            return;
        elseif ~isempty(strfind(init_h_str(k,:),'sat')) && sample_t~=0
            init_h_str_trans  = char(init_h_str_trans,strrep(init_h_str(k,:),'sat',num2str(sample_t/1000)));
        else
            init_h_str_trans  = char(init_h_str_trans,init_h_str(k,:));
        end
    end
    val = str2num(init_h_str_trans);
    init_h = val;
else
    if ~isempty(strfind(init_h_str,'sat')) && sample_t==0
        msgbox('请输入合法采样时间','Error','error');
        return;
    end
    init_h_str_trans = strrep(init_h_str,'sat',num2str(sample_t/1000));
    init_h = str2func(init_h_str_trans);
end


function edit_observe_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_check_Callback(hObject, eventdata, handles)
global islegal_param;
global init_x;
global dim_x;
global dim_z;
global init_p
global init_q
global init_r
global init_f
global init_h
global transition_style
global observe_style
global DIM_MAX;
is_inrange = dim_x > 0 && dim_x < DIM_MAX && dim_z > 0 &&...
    dim_z < DIM_MAX;
is_integer = dim_x == fix(dim_x) && dim_z == fix(dim_z);
if ~is_inrange
    msgbox('输入参数维度和采样时间超过范围','Error','error');
    islegal_param = 0;
    return;
end
if ~is_integer
    msgbox('输入参数维度为非整数','Error','error');
    islegal_param = 0;
    return;
end
if ~check_matrix(dim_x,dim_z,init_x,init_p,init_q,...
    init_r,init_f,init_h,transition_style,observe_style)
    islegal_param = 0;
    return;
end
msgbox('初始化完成','Success');
islegal_param = 1;


function uibuttongroup_transition_CreateFcn(hObject, eventdata, handles)

function uibuttongroup_observe_CreateFcn(hObject, eventdata, handles)



function uibuttongroup_transition_SelectionChangedFcn(hObject, eventdata, handles)
global transition_style;
global dim_x;
global DIM_MAX;
is_inrange = dim_x > 0 && dim_x < DIM_MAX;
is_integer = dim_x == fix(dim_x);
if is_inrange && is_integer
    switch get(hObject , 'tag')
        case 'radiobutton_transition_matrix'
            transition_style = 'matrix';
            str  = num2str(zeros(dim_x,dim_x));
            set(handles.edit_transition,'string',str);
        case 'radiobutton_trasition_formula'
            transition_style = 'formula';
            set(handles.edit_transition,'string','');
        otherwise
            msgbox('选择状态转移方程时出错','Error','error');
    end
else
   set(handles.edit_transition,'string','');
end


function uibuttongroup_observe_SelectionChangedFcn(hObject, eventdata, handles)
global observe_style;
global dim_x;
global dim_z;
global DIM_MAX;
is_inrange = dim_x > 0 && dim_x < DIM_MAX && dim_z > 0 && dim_z < DIM_MAX;
is_integer = (dim_x == fix(dim_x)) && (dim_z == fix(dim_z));
if is_inrange && is_integer
    switch get(hObject , 'tag')
        case 'radiobutton_observe_matrix'
            observe_style = 'matrix';
            str  = num2str(zeros(dim_z,dim_x));
            set(handles.edit_observe,'string',str);
        case 'radiobutton_observe_formula'
            observe_style = 'formula';
            set(handles.edit_observe,'string','');
        otherwise
            msgbox('选择观测方程时出错','Error','error');
    end
else
    set(handles.edit_observe,'string','');
end


function radiobutton_transition_matrix_CreateFcn(hObject, eventdata, handles)
global transition_style;
if strcmp(transition_style,'matrix')
    set(hObject,'value',1);
end

function radiobutton_trasition_formula_CreateFcn(hObject, eventdata, handles)
global transition_style;
if strcmp(transition_style,'formula')
    set(hObject,'value',1);
end


function radiobutton_observe_matrix_CreateFcn(hObject, eventdata, handles)
global observe_style;
if strcmp(observe_style,'matrix')
    set(hObject,'value',1);
end

function radiobutton_observe_formula_CreateFcn(hObject, eventdata, handles)
global observe_style;
if strcmp(observe_style,'formula')
    set(hObject,'value',1);
end

function edit_init_q_Callback(hObject, eventdata, handles)
global init_q;
str = get(hObject,'string');
val = str2num(str);
init_q = val;


function edit_init_q_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_init_r_Callback(hObject, eventdata, handles)
global init_r;
str = get(hObject,'string');
val = str2num(str);
init_r = val;


function edit_init_r_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function islegal_matrix = check_matrix(dim_x,dim_z,init_x,init_p,init_q,...
    init_r,init_f,init_h,transition_style,observe_style)
if ~(size(init_x,1) == dim_x && size(init_x,2)==1)
    msgbox('状态变量x的维度不匹配','Error','error');
    islegal_matrix = 0;
    return;
end
if ~(size(init_p,1) == dim_x && size(init_p,2)==dim_x)
    msgbox('P的初始化维度不匹配','Error','error');
    islegal_matrix = 0;
    return;
end
if ~isequal(init_p,init_p')
    msgbox('P不是对称矩阵','Error','error');
    islegal_matrix = 0;
    return;
end
try chol(init_p);
catch
    msgbox('P不是正定矩阵','Error','error');
    islegal_matrix = 0;
    return;
end    
if ~(size(init_q,1) == dim_x && size(init_q,2)==dim_x)
    msgbox('Q的初始化维度不匹配','Error','error');
    islegal_matrix = 0;
    return;
end
if ~isequal(init_q,init_q')
    msgbox('Q不是对称矩阵','Error','error');
    islegal_matrix = 0;
    return;
end
if ~(size(init_r,1) == dim_z && size(init_r,2)==dim_z)
    msgbox('R的初始化维度不匹配','Error','error');
    islegal_matrix = 0;
    return;
end
if ~isequal(init_r,init_r')
    msgbox('R不是对称矩阵','Error','error');
    islegal_matrix = 0;
    return;
end
if strcmp(transition_style,'matrix')
    if ~(size(init_f,1) == dim_x&&size(init_f,2) == dim_x)
        msgbox('状态转移方程的初始化错误','Error','error');
        islegal_matrix = 0;
        return;
    end
else
    try
        res = init_f(ones(dim_x,1));
        if size(res,1) ~= dim_x
            msgbox('状态转移方程的初始化错误','Error','error');
            islegal_matrix = 0;
            return;
        end
    catch
        msgbox('状态转移方程的初始化错误','Error','error');
        islegal_matrix = 0;
        return;
    end
end

if strcmp(observe_style,'matrix')
    if ~(size(init_h,1) == dim_z&&size(init_h,2) == dim_x)
        msgbox('观测方程的初始化错误','Error','error');
        islegal_matrix = 0;
        return;
    end
else
    try
        res = init_h(ones(dim_x,1));
        if size(res,1) ~= dim_z
            msgbox('观测方程的初始化错误','Error','error');
            islegal_matrix = 0;
            return;
        end
    catch
        msgbox('观测方程的初始化错误','Error','error');
        islegal_matrix = 0;
        return;
    end
end
islegal_matrix = 1;



function radiobutton_observe_matrix_Callback(hObject, eventdata, handles)

function radiobutton_transition_matrix_Callback(hObject, eventdata, handles)



function menu_init_import_data_Callback(hObject, eventdata, handles)


function menu_init_output_data_Callback(hObject, eventdata, handles)


function menu_init_output_config_Callback(hObject, eventdata, handles)
global islegal_param;
global dim_x;
global dim_z;
global sample_t;
global init_x;
global init_p;
global init_q;
global init_r;
global transition_style;
global observe_style;
global init_f;
global init_f_str;
global init_h;
global init_h_str;

if islegal_param
    [f_name, p_name ] = uiputfile({'*.txt';},'导出配置文件','Undefined.txt');
    if isequal(p_name,0) || isequal(f_name,0)
        return;
    end
    full_name = fullfile(p_name, f_name);
    fp = fopen(full_name,'wt');
    %have 11 param
    fprintf(fp, '%s:\n%s\n\n', 'dim_x', num2str(dim_x));
    fprintf(fp, '%s:\n%s\n\n', 'dim_z', num2str(dim_z));
    fprintf(fp, '%s:\n%s\n\n', 'sample_t', num2str(sample_t));
    fprintf(fp,'%s:\n', 'init_x');
    fprintf(fp, [repmat('%f ', 1, size(init_x,2)), '\n'], init_x');
    fprintf(fp,'\n');
    fprintf(fp,'%s:\n', 'init_p'); 
    fprintf(fp, [repmat('%f ', 1, size(init_p,2)), '\n'], init_p');
    fprintf(fp,'\n');
    fprintf(fp,'%s:\n', 'init_q');
    fprintf(fp, [repmat('%f ', 1, size(init_q,2)), '\n'], init_q');
    fprintf(fp,'\n');
    fprintf(fp,'%s:\n', 'init_r');
    fprintf(fp, [repmat('%f ', 1, size(init_r,2)), '\n'], init_r');
    fprintf(fp,'\n');
    fprintf(fp, '%s:\n%s\n', 'transition_style', transition_style);
    fprintf(fp,'\n');
    if strcmp(transition_style,'matrix')
        fprintf(fp,'%s:\n', 'init_f');
        fprintf(fp, [repmat('%f ', 1, size(init_f,2)), '\n'], init_f');
        fprintf(fp,'\n');
    else
        fprintf(fp, '%s:\n%s\n\n', 'init_f', init_f_str);
    end
    fprintf(fp, '%s:\n%s\n', 'observe_style', observe_style);
    fprintf(fp,'\n');
    if strcmp(observe_style,'matrix')
        fprintf(fp,'%s:\n', 'init_h');
        fprintf(fp, [repmat('%f ', 1, size(init_h,2)), '\n'], init_h');
        fprintf(fp,'\n');
    else
        fprintf(fp, '%s:\n%s\n\n', 'init_h', func2str(init_h));
    end
    fprintf(fp, '%s\n', 'end');
else
    msgbox('参数不合法，请导出合法的参数','Error','error');
end

function menu_init_import_config_Callback(hObject, eventdata, handles)
global islegal_param;
global dim_x;
global dim_z;
global sample_t;
global init_x;
global init_p;
global init_q;
global init_r;
global transition_style;
global observe_style;
global init_f;
global init_f_str;
global init_h;
global init_h_str;
global DIM_MAX
[f_name, p_name ] = uigetfile({'*.txt';},'导人配置文件','Undefined.txt');
if isequal(p_name,0) || isequal(f_name,0)
    return;
end

full_name = fullfile(p_name, f_name);
fp = fopen(full_name);
dim_x_temp = textscan(fp,'%d','HeaderLines',1);
dim_x_temp = dim_x_temp{:};
dim_z_temp = textscan(fp,'%d','HeaderLines',1);
dim_z_temp = dim_z_temp{:};
sample_t_temp = textscan(fp,'%d','HeaderLines',1);
sample_t_temp = sample_t_temp{:};
init_x_temp = textscan(fp,'%[^init_p]','HeaderLines',1);
try
    init_x_temp = str2num(init_x_temp{:}{:});
catch
    init_x_temp = init_x_temp{:};
end
init_p_temp = textscan(fp,'%[^init_q]','HeaderLines',1);
try
    init_p_temp = str2num(init_p_temp{:}{:});
catch
    init_p_temp = init_p_temp{:};
end
init_q_temp = textscan(fp,'%[^init_r]','HeaderLines',1);
try
    init_q_temp = str2num(init_q_temp{:}{:});
catch
    init_q_temp = init_q_temp{:};
end
init_r_temp = textscan(fp,'%[^transition_style]','HeaderLines',1);
try
    init_r_temp = str2num(init_r_temp{:}{:});
catch
    init_r_temp = init_r_temp{:};
end
transition_style_temp = textscan(fp,'%s[^init_f]','HeaderLines',1);
transition_style_temp = transition_style_temp{:}{:};
if strcmp(transition_style_temp,'matrix')
    init_f_temp = textscan(fp,'%[^observe_style]','HeaderLines',3);
    try
        init_f_temp_str = init_f_temp{:}{:};
        init_f_temp = str2num(init_f_temp_str);
    catch
        init_f_temp_str = init_f_temp{:};
        init_f_temp = init_f_temp_str;
    end
    observe_style_temp = textscan(fp,'%s[^init_h]','HeaderLines',1);
else
    init_f_temp_str = textscan(fp,'%s[^observe_style]','HeaderLines',3);
    init_f_temp_str = init_f_temp_str{:}{:};
    init_f_str_trans = strrep(init_f_temp_str,'sat',num2str(double(sample_t_temp)/1000));
    init_f_temp = str2func(init_f_str_trans);
    observe_style_temp = textscan(fp,'%s[^init_h]','HeaderLines',3);
end
observe_style_temp = observe_style_temp{:}{:};
if strcmp(observe_style_temp,'matrix')
    init_h_temp = textscan(fp,'%[^the_end]','HeaderLines',3);
    try
        init_h_temp_str = init_h_temp{:}{:};
        init_h_temp = str2num(init_h_temp_str);
    catch
        init_h_temp_str = init_h_temp{:};
        init_h_temp = init_h_temp_str;
    end
else
    init_h_temp_str = textscan(fp,'%s[^end]','HeaderLines',3);
    init_h_temp_str = init_h_temp_str{:}{:};
    init_h_str_trans = strrep(init_h_temp_str,'sat',num2str(double(sample_t_temp)/1000));
    init_h_temp = str2func(init_h_str_trans);
end
%check the param 
is_inrange = dim_x_temp > 0 && dim_x_temp < DIM_MAX && dim_z_temp > 0 &&...
    dim_z_temp < DIM_MAX;
is_integer = dim_x_temp == fix(dim_x_temp) && dim_z_temp == fix(dim_z_temp);
if ~is_inrange
    msgbox('输入参数维度和采样时间超过范围,参数导入失败','Error','error');
    return;
end
if ~is_integer
    msgbox('输入参数维度为非整数，参数导入失败','Error','error');
    return;
end
if ~check_matrix(dim_x_temp,dim_z_temp,init_x_temp,init_p_temp,init_q_temp,...
    init_r_temp,init_f_temp,init_h_temp,transition_style_temp,observe_style_temp)
    return;
end
msgbox('初始化完成','Success');
islegal_param = 1;
dim_x = dim_x_temp;
dim_z = dim_z_temp;
sample_t = sample_t_temp;
init_x = init_x_temp;
init_p = init_p_temp;
init_q = init_q_temp;
init_r = init_r_temp;
init_f = init_f_temp;
init_f_str = init_f_temp_str;
init_h = init_h_temp;
init_h_str = init_h_temp_str;
transition_style = transition_style_temp;
observe_style = observe_style_temp;
set(handles.edit_dim_x,'string',num2str(dim_x));
set(handles.edit_dim_z,'string',num2str(dim_z));
set(handles.edit_init_x,'string',num2str(init_x'));
set(handles.edit_init_p,'string',num2str(init_p));
set(handles.edit_init_q,'string',num2str(init_q));
set(handles.edit_init_r,'string',num2str(init_r));
set(handles.edit_transition,'string',init_f_str);
set(handles.edit_observe,'string',init_h_str);
