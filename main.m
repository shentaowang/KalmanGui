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

% Last Modified by GUIDE v2.5 24-Sep-2017 09:23:00

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
%define the global variable
%need to add the explain for variable
global observe_data;
global compare_data;
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
str_prefix = 'ÏÔÊ¾x(';
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



function init_param_Callback(hObject, eventdata, handles)
init_param();
pause(0.01);
close(main);


function pushbutton_filter_Callback(hObject, eventdata, handles)


function pushbutton_showwave_Callback(hObject, eventdata, handles)


function popupmenu_showlist_Callback(hObject, eventdata, handles)


function popupmenu_showlist_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
