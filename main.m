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

% Last Modified by GUIDE v2.5 22-Sep-2017 20:52:59

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
global observe_data; observe_data = [];
global compare_data; compare_data = [];
global init_x; init_x = 0;
global init_p; init_p = [];
global init_q; init_q = [];
global init_r; init_r = [];
global init_f; init_f = 0;
global init_h; init_h = 0;
global dim_x; dim_x = 0;
global dim_z; dim_z = 0;
global sample_t; sample_t = 0;
%may have:
% lti_kf(linear time invariant and use basic kalman filter)
% ltv_kf(linear time-varying  and use basic kalman filter)
% nlti_ekf(Nonlinear Time invariant and use extend kalman filter)
% nlti_ukf(Nonlinear Time invariant and use unscented kalman filter)
% nltv_ekf(Nonlinear Time varying and use extend kalman filter)
% nltv_ukf(Nonlinear Time varying and use unscented kalman filter)
handles.model = 'lti_kf';

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


function init_state_Callback(hObject, eventdata, handles)
global init_x;
global init_p;
global dim_x;
global dim_z;
global sample_t;
prompt = {'Enter the x dimension', 'Enter the z dimension',...
    'Enter the sampling time:(s)'};
title = 'Original State Part1 ';
customer = [1 50;1 50; 1 50];
defaultans  = {'0', '0', '0'};
options.Resize='off';options.WindowStyle='normal';options.Interpreter='none';
answer=inputdlg(prompt,title,customer,defaultans,options);
if isempty(answer)
    return;
else
    dim_x = str2num(answer{1});
    dim_z = str2num(answer{2});
    sample_t = str2num(answer{3});
end

if (dim_x * dim_z) == 0
    msgbox('Please init the data dimension', 'Error', 'error');
    return;
else
    if sample_t == 0
         button = questdlg('Do you want to reload the sampling time',...
             'prompt','Yes', 'No', 'Yes');
    else
        button = 'No';
    end
end
if strcmp(button, 'No')
    prompt = {'Initial the x:(n*1)', 'Initial the p:(n*n)'};
    title = 'Original State Part2 ';
    customer = [10 60;10 60];
    defaultans  = {num2str(zeros(dim_x,1)), num2str(zeros(dim_x,dim_x))};
    options.Resize='off';options.WindowStyle='normal';options.Interpreter='none';
    answer=inputdlg(prompt,title,customer,defaultans,options);
else
    return;
end

if isempty(answer)
    return;
else
    init_x = str2num(answer{1});
    init_p = str2num(answer{2});
end

if isequal(init_x, zeros(dim_x,1)) || isequal(init_p, zeros(dim_x,dim_x))
    msgbox('Please initial the state', 'Error', 'error');
end
    
function init_model_Callback(hObject, eventdata, handles)
% lti_kf(linear time invariant and use basic kalman filter)
str_kf = 'basic kalman filter';
str_lti = 'linear time invariant';
% ltv_kf(linear time-varying  and use basic kalman filter)
str_ltv = 'linear time-varying';
% nlti_ekf(Nonlinear Time invariant and use extend kalman filter)
% nlti_ukf(Nonlinear Time invariant and use unscented kalman filter)
str_ekf = 'extend kalman filter';
str_ukf = 'unscent kalman filter';
str_nlti = 'Nonlinear Time invariant';
% nltv_ekf(Nonlinear Time varying and use extend kalman filter)
% nltv_ukf(Nonlinear Time varying and use unscented kalman filter)
str_nltv = 'Nonlinear Time varying';
try
    choice = menu('choose the model type', str_lti, str_ltv, str_nlti, str_nltv);
catch
    return;
end

switch choice
    case 1
        handles.model = 'lti';
    case 2
        handles.model = 'ltv';
    case 3
        handles.model = 'nlti';
    case 4
        handles.model = 'nltv';
    otherwise
            return;
end


try
    choice = menu('choose the model type', str_kf, str_ekf, str_ukf);
catch
    return;
end
switch choice
    case 1
        handles.model = strcat(handles.model,'_kf');
    case 2
        handles.model = strcat(handles.model,'_ekf');
    case 3
        handles.model = strcat(handles.model,'_ukf');
    otherwise
            return;
end
handles.model

