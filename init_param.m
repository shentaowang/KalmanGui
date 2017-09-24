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

% Last Modified by GUIDE v2.5 23-Sep-2017 20:16:00

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

% Choose default command line output for init_param
handles.output = hObject;
global DIM_MAX; DIM_MAX = 10;
global SAMPLE_T_MAX; SAMPLE_T_MAX = 10000;
global init_x;
global init_p;
global init_q;
global init_r;
global init_f;
global init_h;
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
    set(handles.edit_observe,'string',num2str(zeros(dim_z,dim_x)));
    set(handles.edit_init_q,'string',num2str(zeros(dim_x,dim_x)));
    set(handles.edit_init_r,'string',num2str(zeros(dim_z,dim_z)));
elseif is_inrange && is_integer && islegal_param
    set(handles.edit_dim_x,'string',num2str(dim_x));
    set(handles.edit_dim_z,'string',num2str(dim_z));
    set(handles.edit_init_x,'string',num2str(init_x'));
    set(handles.edit_init_p,'string',num2str(init_p));
    set(handles.edit_transition,'string',num2str(init_f));
    set(handles.edit_observe,'string',num2str(init_h));
    set(handles.edit_init_q,'string',num2str(init_q));
    set(handles.edit_init_r,'string',num2str(init_r));
else
    set(handles.edit_dim_x,'string','');
    set(handles.edit_dim_z,'string','');
    set(handles.edit_init_x,'string','');
    set(handles.edit_init_p,'string','');
    set(handles.edit_transition,'string','');
    set(handles.edit_observe,'string','');
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
is_inrange = val > 1 && val < DIM_MAX;
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
is_inrange = val > 1 && val < DIM_MAX;
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
main();
pause(0.01);
close(init_param);

%the simplest
function edit_transition_Callback(hObject, eventdata, handles)
global init_f;
str = get(hObject,'string');
val = str2num(str);
init_f = val;

function edit_transition_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%the simplest 
function edit_observe_Callback(hObject, eventdata, handles)
global init_h
str = get(hObject,'string');
val = str2num(str);
init_h = val;


function edit_observe_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_check_Callback(hObject, eventdata, handles)
global islegal_param;
global init_x;
global init_p;
global init_q;
global init_r;
global init_f;
global init_h;
global dim_x;
global dim_z;
global sample_t;
global transition_style;
global observe_style;
global DIM_MAX;
global SAMPLE_T_MAX;
combine_style = strcat(transition_style,observe_style);
switch combine_style
    case 'matrixmatrix'
        is_inrange = dim_x > 0 && dim_x < DIM_MAX && dim_z > 0 &&...
            dim_z < DIM_MAX;
        is_integer = dim_x == fix(dim_x) && dim_z == fix(dim_z);
        combine_dim1 = size(init_p,1) * size(init_q,1) * size(init_r,1) *...
            size(init_f,1) * size(init_h,1) * size(init_x,1);
        combine_dim2 = size(init_p,2) * size(init_q,2) * size(init_r,2) *...
            size(init_f,2) * size(init_h,2) * size(init_x,2);
        is_matrix_true  = combine_dim1==(dim_x^4 * dim_z^2) &&...
            combine_dim2==(dim_x^4 * dim_z);
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
        if ~is_matrix_true
            msgbox('参数未全部初始化或者初始化有误','Error','error');
            islegal_param = 0;
            return;
        end
    case 'matrixformula'
        msgbox('此功能未完成','Warn','warn');
        islegal_param = 0;
        return;
    case 'formulamatrix'
        msgbox('此功能未完成','Warn','warn');
        islegal_param = 0;
        return;
    case 'formulaformula'
        msgbox('此功能未完成','Warn','warn');
        islegal_param = 0;
        return;
    otherwise
        msgbox('选择矩阵形式或者方程形式','Error','error');
        islegal_param = 0;
        return;
end
msgbox('初始化完成','Success');
islegal_param = 1;


function uibuttongroup_transition_CreateFcn(hObject, eventdata, handles)


function uibuttongroup_transition_SelectionChangedFcn(hObject, eventdata, handles)
global transition_style;
global dim_x;
global DIM_MAX;
is_inrange = dim_x > 1 && dim_x < DIM_MAX;
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
set(hObject,'value',1);


function uibuttongroup_observe_CreateFcn(hObject, eventdata, handles)

function radiobutton_observe_matrix_CreateFcn(hObject, eventdata, handles)
set(hObject,'value',1);

function radiobutton_observe_formula_CreateFcn(hObject, eventdata, handles)


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
