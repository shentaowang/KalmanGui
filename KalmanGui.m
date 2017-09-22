function varargout = KalmanGui(varargin)
%KALMANGUI MATLAB code file for KalmanGui.fig
%      KALMANGUI, by itself, creates a new KALMANGUI or raises the existing
%      singleton*.
%
%      H = KALMANGUI returns the handle to a new KALMANGUI or the handle to
%      the existing singleton*.
%
%      KALMANGUI('Property','Value',...) creates a new KALMANGUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to KalmanGui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      KALMANGUI('CALLBACK') and KALMANGUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in KALMANGUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KalmanGui

% Last Modified by GUIDE v2.5 22-Sep-2017 11:23:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KalmanGui_OpeningFcn, ...
                   'gui_OutputFcn',  @KalmanGui_OutputFcn, ...
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


function KalmanGui_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for KalmanGui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KalmanGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = KalmanGui_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;
