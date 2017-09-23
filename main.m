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

% Last Modified by GUIDE v2.5 23-Sep-2017 08:44:51

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
global transition_style; transition_style = 'matrix';
global observe_style; observe_style = 'matrix';
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



