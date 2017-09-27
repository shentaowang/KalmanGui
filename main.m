function varargout = main(varargin)
%main MATLAB code file for main.fig
%      main, by itself, creates a new main or raises the existing
%      singleton*.
%
%      H = main returns the handle to a new main or the handle to
%      the existing singleton*.
%
%      main('Property','Value',...) creates a new main using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to main_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      main('CALLBACK') and main('CALLBACK',hObject,...) call the
%      local function named CALLBACK in main.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 27-Sep-2017 11:20:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


function main_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for main
handles.output = hObject;
%add the path
root_path = '../KalmanGui';
addpath(genpath(root_path));
%define the global variable
%need to add the explain for variable
global observe_data;
global compare_data;
global filtered_x;
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
global islegal_param;
global DIM_MAX; DIM_MAX = 10;
global SAMPLE_T_MAX; SAMPLE_T_MAX = 10000;
global dim_show;
dim_show = 1;
if isempty(islegal_param)
    islegal_param = 0;
    observe_data = [];
    compare_data = [];
    init_x = 0;
    init_p = [];
    init_q = [];
    init_r = [];
    init_f = 0;
    init_h = 0;
    dim_x = 0;
    dim_z = 0;
    sample_t = 0;
    transition_style = 'matrix';
    observe_style = 'matrix';
else
    if islegal_param == 0
        init_x = 0;
        init_p = [];
        init_q = [];
        init_r = [];
        init_f = 0;
        init_h = 0;
        dim_x = 0;
        dim_z = 0;
        sample_t = 0;
        transition_style = 'matrix';
        observe_style = 'matrix';
    end
end

%init the wave we can choose
show_list = [];
str_prefix = '显示x(';
str_suffix = ')';
if dim_x > 0
    for k=1:dim_x
        show_list = [show_list;strcat(str_prefix,num2str(k),str_suffix)];
    end
    show_list = mat2cell(show_list,size(show_list,1),size(show_list,2));
    set(handles.popupmenu_showlist,'string',show_list{1,1},'value',1);
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = main_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


function import_observe_Callback(hObject, eventdata, handles)
global observe_data;
observe_data = [];
[f_name, p_name] = uigetfile('*.txt');
%if choose the cancle
if isequal(p_name,0)
    return;
end
full_name = fullfile(p_name, f_name);

fp = fopen(full_name);
while 1
    tline = fgetl(fp);
    if ~ischar(tline)
        break;
    end
    tline = str2num(tline);
    %check if the data is standard, but need more rule
    if isempty(tline)
        msgbox('Please input the standard data', 'Error', 'error');
        observe_data = [];
        return;
    end
    observe_data = [observe_data tline'];
end


function import_compare_Callback(hObject, eventdata, handles)
global compare_data;
compare_data = [];
[f_name, p_name] = uigetfile('*.txt');
%if choose the cancle
if isequal(p_name,0)
    return;
end
full_name = fullfile(p_name, f_name);

fp = fopen(full_name);
while 1
    tline = fgetl(fp);
    if ~ischar(tline)
        break;
    end
    tline = str2num(tline);
    %check if the data is standard, but need more rule
    if isempty(tline)
        msgbox('Please input the standard data', 'Error', 'error');
        compare_data = [];
        return;
    end
    compare_data = [compare_data tline'];
end


function init_param_Callback(hObject, eventdata, handles)
close(main);
init_param();

function pushbutton_filter_Callback(hObject, eventdata, handles)
global observe_data;
global filtered_x;
global init_x;
global init_p;
global init_q;
global init_r;
global init_f;
global init_h;
global dim_z;
global transition_style;
global observe_style;
global islegal_param;
is_match = size(observe_data,1) == dim_z;
if ~islegal_param
    msgbox('参数初始化不合法','Error','error');
    return;
end
if ~is_match
    msgbox('模型和数据不匹配','Error','error');
    return;
end
combine_style = strcat(transition_style,observe_style);
switch combine_style
    case 'matrixmatrix'
        filtered_x = kalman_filter(init_x,observe_data,init_p,init_q,init_r,init_f,init_h);
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


function pushbutton_showwave_Callback(hObject, eventdata, handles)
global dim_show
global filtered_x;
global compare_data;
global islegal_param;
plot_x = 1:size(filtered_x,2);
isnot_match =  ~isempty(compare_data) && ~(size(compare_data,1) == ...
    size(filtered_x,1) && size(compare_data,2) == size(filtered_x,2));

if islegal_param && ~isempty(filtered_x)
    if isnot_match
        msgbox('滤波数据和比较数据不匹配，只显示滤波数据','Error','error');
        compare_data = [];
        axes(handles.axes_showcompare);
        plot(plot_x,filtered_x(dim_show,:));
        legend('滤波后数据');
    elseif isempty(compare_data)
        axes(handles.axes_showcompare);
        plot(plot_x,filtered_x(dim_show,:));
    elseif ~isempty(compare_data)
        axes(handles.axes_showcompare);
        plot(plot_x,filtered_x(dim_show,:),plot_x,compare_data(dim_show,:),'--');
        legend('滤波后数据','比较数据')
    end
end


function popupmenu_showlist_Callback(hObject, eventdata, handles)
global dim_show;
dim_show = get(hObject,'Value');

function popupmenu_showlist_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function axes_showcompare_CreateFcn(hObject, eventdata, handles)


function output_filtered_Callback(hObject, eventdata, handles)


function output_analyze_Callback(hObject, eventdata, handles)
