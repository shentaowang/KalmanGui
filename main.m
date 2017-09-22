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

% Last Modified by GUIDE v2.5 22-Sep-2017 15:02:25

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
full_name = fullfile(p_name, f_name);

fp = fopen(full_name);
while 1
    tline = fgetl(fp);
    if ~ischar(tline)
        break;
    end
    tline = str2num(tline);
    if isempty(tline)
        msgbox('please input the standard data', 'Error', 'error');
        observe_data = [];
        return;
    end
    observe_data = [observe_data tline'];
end


    

function import_compare_Callback(hObject, eventdata, handles)


function init_state_Callback(hObject, eventdata, handles)


function init_model_Callback(hObject, eventdata, handles)
