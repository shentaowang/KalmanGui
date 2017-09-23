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

% Last Modified by GUIDE v2.5 23-Sep-2017 09:52:12

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


function edit_x_dim_Callback(hObject, eventdata, handles)
global dim_x;
str = get(hObject,'string');
val = str2double(str);
dim_x = val;
set(handles.edit_init_x,'string',num2str(zeros(1, dim_x)));
set(handles.edit_init_p,'string',num2str(zeros(dim_x,dim_x)));

function edit_x_dim_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_dim_z_Callback(hObject, eventdata, handles)
global dim_z;
str = get(hObject,'string');
val = str2double(str);
dim_z = val;


function edit_dim_z_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_sample_time_Callback(hObject, eventdata, handles)
global sample_t;
str = get(hObject,'string');
val = str2double(str);
sample_t = val;


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

function edit_transition_Callback(hObject, eventdata, handles)


function edit_transition_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_observe_Callback(hObject, eventdata, handles)


function edit_observe_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_check_Callback(hObject, eventdata, handles)


function uibuttongroup_transition_CreateFcn(hObject, eventdata, handles)


function uibuttongroup_transition_SelectionChangedFcn(hObject, eventdata, handles)

