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

% Last Modified by GUIDE v2.5 12-Oct-2017 20:31:21

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
global init_f_str;
global init_h;
global init_h_str;
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
    init_f_str = '';
    init_h = 0;
    init_h_str = '';
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
        init_f_str = '';
        init_h = 0;
        init_h_str = '';
        dim_x = 0;
        dim_z = 0;
        sample_t = 0;
        transition_style = 'matrix';
        observe_style = 'matrix';
    end
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function varargout = main_OutputFcn(hObject, eventdata, handles)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
global dim_x;
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
        dim_data = size(observe_data,2);
        filtering_data = zeros(dim_x,dim_data);
        fstate = @(x)init_f*x;
        hmeas = init_h;
        mP = init_p;
        mQ = init_q;
        mR = init_r;
        vX = init_x;
        mP = init_p;
        for k =1:dim_data
            vZ = observe_data(:,k);
            [vX, mP] = unscented_kalman_filter(fstate,vX,mP,hmeas,vZ,mQ,mR);
            filtering_data(:,k) = vX;
        end
        filtered_x = filtering_data;
    case 'formulamatrix'
        dim_data = size(observe_data,2);
        filtering_data = zeros(dim_x,dim_data);
        fstate = init_f;
        hmeas = @(x)init_h*x;
        mP = init_p;
        mQ = init_q;
        mR = init_r;
        vX = init_x;
        mP = init_p;
        for k =1:dim_data
            vZ = observe_data(:,k);
            [vX, mP] = unscented_kalman_filter(fstate,vX,mP,hmeas,vZ,mQ,mR);
            filtering_data(:,k) = vX;
        end
        filtered_x = filtering_data;
    case 'formulaformula'
        dim_data = size(observe_data,2);
        filtering_data = zeros(dim_x,dim_data);
        fstate = init_f;
        hmeas = init_h;
        mP = init_p;
        mQ = init_q;
        mR = init_r;
        vX = init_x;
        mP = init_p;
        for k =1:dim_data
            vZ = observe_data(:,k);
            [vX, mP] = unscented_kalman_filter(fstate,vX,mP,hmeas,vZ,mQ,mR);
            filtering_data(:,k) = vX;
        end
        filtered_x = filtering_data;
    otherwise
        msgbox('选择矩阵形式或者方程形式','Error','error');
        islegal_param = 0;
        return;
end


function pushbutton_showwave_Callback(hObject, eventdata, handles)
global dim_z;
global filtered_x;
global observe_data;
global compare_data;
global islegal_param;
global init_h;
global observe_style;
dim_data = size(filtered_x,2);
x_zoom = 1.3;
dim_show = get(handles.popupmenu_showlist,'value');
if islegal_param && ~isempty(filtered_x)
    sel = get(handles.popupmenu_showmethod,'value');
    switch sel
        case 1
            plot_x = 1:dim_data;
            axes(handles.axes_showcompare);
            plot(plot_x,filtered_x(dim_show,:));
            xlim([0 dim_data*x_zoom]);
            xlabel('数据点');
            ylabel('数据值');
            legend('滤波后数据');
        case 2
            plot_x = 1:dim_data;
            isnot_match =  ~isempty(compare_data) && ~(size(compare_data,1) == ...
                size(filtered_x,1) && size(compare_data,2) == dim_data);
            if isempty(compare_data)
                msgbox('真实数据未输入','Error','error');
            elseif isnot_match
                msgbox('滤波后数据和真实数据不匹配','Error','error');
            elseif ~isempty(compare_data)
                axes(handles.axes_showcompare);
                plot(plot_x,filtered_x(dim_show,:),plot_x,compare_data(dim_show,:),'*');
                data_gap = filtered_x(dim_show,:)-compare_data(dim_show,:);
                mse = sum(data_gap.*data_gap)/size(compare_data,2);
                str_mse = ['MSE:',num2str(mse)];
                xlim([0 dim_data*x_zoom]);
                xlabel('数据点');
                ylabel('数据值');
                legend('滤波后数据','真实数据');
                x_lim = get(handles.axes_showcompare,'XLim');
                y_lim = get(handles.axes_showcompare,'YLim');
                text(x_lim(1)+(x_lim(2)-x_lim(1))*0.8,y_lim(2)-(y_lim(2)-y_lim(1))*0.15,str_mse);
            end
        case 3
            if strcmp(observe_style,'matrix')
                trans_filtered_x = init_h * filtered_x;
            else
                trans_filtered_x = zeros(dim_z,dim_data);
                for k = 1:size(trans_filtered_x,2)
                    trans_filtered_x(:,k) = init_h(filtered_x(:,k));
                end
            end
            plot_x = 1:dim_data;
            plot(plot_x,trans_filtered_x(dim_show,:),plot_x,observe_data(dim_show,:),'*');
            data_gap = trans_filtered_x(dim_show,:)-observe_data(dim_show,:);
            mse = sum(data_gap.*data_gap)/size(observe_data,2);
            str_mse = ['MSE:',num2str(mse)];
            xlim([0 dim_data*x_zoom]);
            xlabel('数据点');
            ylabel('数据值');
            legend('滤波后数据','观测数据');
            x_lim = get(handles.axes_showcompare,'XLim');
            y_lim = get(handles.axes_showcompare,'YLim');
            text(x_lim(1)+(x_lim(2)-x_lim(1))*0.8,y_lim(2)-(y_lim(2)-y_lim(1))*0.15,str_mse);
        case 4
            plot_x = 1:dim_data;
            isnot_match =  ~isempty(compare_data) && ~(size(compare_data,1) == ...
                size(filtered_x,1) && size(compare_data,2) == dim_data);
            if isempty(compare_data)
                msgbox('真实数据未输入','Error','error');
            elseif isnot_match
                msgbox('滤波后数据和真实数据不匹配','Error','error');
            elseif ~isempty(compare_data)
                axes(handles.axes_showcompare);
                if strcmp(observe_style,'matrix')
                    trans_filtered_x = init_h * filtered_x;
                    trans_compare = init_h * compare_data;
                else
                    trans_filtered_x = zeros(dim_z,dim_data);
                    trans_compare = zeros(dim_z,dim_data);
                    for k = 1:size(trans_filtered_x,2)
                        trans_filtered_x(:,k) = init_h(filtered_x(:,k));
                        trans_compare(:,k) = init_h(compare_data(:,k));
                    end
                end
                plot(plot_x,trans_filtered_x(dim_show,:),plot_x,observe_data(dim_show,:),'*',...
                    plot_x,trans_compare(dim_show,:),'+');
                data_gap = trans_filtered_x(dim_show,:)-observe_data(dim_show,:);
                mse = sum(data_gap.*data_gap)/size(observe_data,2);
                str_mse_filter_observe = num2str(mse);
                data_gap = trans_filtered_x(dim_show,:)-trans_compare(dim_show,:);
                mse = sum(data_gap.*data_gap)/size(observe_data,2);
                str_mse_filter_true = num2str(mse);
                xlim([0 dim_data*x_zoom]);
                xlabel('数据点');
                ylabel('数据值');
                legend('滤波后数据(1)','观测数据(2)','真实数据(3)');
                x_lim = get(handles.axes_showcompare,'XLim');
                y_lim = get(handles.axes_showcompare,'YLim');
                x_pos = x_lim(1)+(x_lim(2)-x_lim(1))*0.8;
                y_pos = y_lim(2)-(y_lim(2)-y_lim(1))*0.16;
                text(x_pos,y_pos,'(1)和(2)MSE:')
                y_pos = y_lim(2)-(y_lim(2)-y_lim(1))*0.20;
                text(x_pos,y_pos,str_mse_filter_observe);
                y_pos = y_lim(2)-(y_lim(2)-y_lim(1))*0.24;
                text(x_pos,y_pos,'(1)和(3)MSE:');
                y_pos = y_lim(2)-(y_lim(2)-y_lim(1))*0.28;
                text(x_pos,y_pos,str_mse_filter_true);
            end
        otherwise
                msgbox('存在一些问题,开发者没考虑到','Error','error');
    end
end


function popupmenu_showlist_Callback(hObject, eventdata, handles)

function popupmenu_showlist_CreateFcn(hObject, eventdata, handles)

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global islegal_param;
global dim_x;
%init the wave we can choose
show_list = [];
str_prefix = '显示x(';
str_suffix = ')';
if islegal_param
    if dim_x > 0
        for k=1:dim_x
            show_list = [show_list;strcat(str_prefix,num2str(k),str_suffix)];
        end
        show_list = mat2cell(show_list,size(show_list,1),size(show_list,2));
        set(hObject,'string',show_list{1,1},'value',1);
    end
end

function axes_showcompare_CreateFcn(hObject, eventdata, handles)

function popupmenu_showmethod_Callback(hObject, eventdata, handles)
global islegal_param;
global dim_x;
global dim_z;
if islegal_param
    sel = get(hObject,'value');
    switch sel
        case 1%select only show the filtered data
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
        case 2 %select show the filtered data and ground truth data
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
        case 3 %select show the filtered data and observe data
            show_list = [];
            str_prefix = '显示z(';
            str_suffix = ')';
            if dim_z > 0
                for k=1:dim_z
                    show_list = [show_list;strcat(str_prefix,num2str(k),str_suffix)];
                end
                show_list = mat2cell(show_list,size(show_list,1),size(show_list,2));
                set(handles.popupmenu_showlist,'string',show_list{1,1},'value',1);
            end
        case 4
            show_list = [];
            str_prefix = '显示z(';
            str_suffix = ')';
            if dim_z > 0
                for k=1:dim_z
                    show_list = [show_list;strcat(str_prefix,num2str(k),str_suffix)];
                end
                show_list = mat2cell(show_list,size(show_list,1),size(show_list,2));
                set(handles.popupmenu_showlist,'string',show_list{1,1},'value',1);
            end
        otherwise
                msgbox('存在一些问题,开发者没考虑到','Error','error');
    end
end


function popupmenu_showmethod_CreateFcn(hObject, eventdata, handles)
global islegal_param;
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
if islegal_param
    str1 = '单独显示滤波后数据';
    str2 = '滤波后数据和真实数据(dim_x维)';
    str3 = '滤波后数据和观测数据(dim_z维)';
    str4 = '滤波后、观测、真实数据(dim_z维)';
    show_list = {str1;str2;str3;str4};
    set(hObject,'string',show_list,'value',1);
end



function popupmenu_analyse_CreateFcn(hObject, eventdata, handles)
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_analyse_Callback(hObject, eventdata, handles)


function edit_analyse_CreateFcn(hObject, eventdata, handles)

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton_filter_CreateFcn(hObject, eventdata, handles)


function use_help_Callback(hObject, eventdata, handles)


function fig_operate_Callback(hObject, eventdata, handles)


function uipushtool_save_ClickedCallback(hObject, eventdata, handles)


function menu_import_data_Callback(hObject, eventdata, handles)


function menu_output_data_Callback(hObject, eventdata, handles)


function menu_output_filtereddata_Callback(hObject, eventdata, handles)
global filtered_x;
[f_name, p_name ] = uiputfile({'*.txt';},'导出滤波后数据','Undefined.txt');
if isequal(p_name,0) || isequal(f_name,0)
    return;
end
full_name = fullfile(p_name, f_name);
fp = fopen(full_name,'w');
dim_data = size(filtered_x,2);
dim_x = size(filtered_x,1);

output_data = filtered_x';
for k=1:dim_data
    for m=1:dim_x
        fprintf(fp,'%6f\t',output_data(k,m));
    end
    fprintf(fp,'\r\n');
end

function menu_output_analyse_Callback(hObject, eventdata, handles)
global filtered_x;
global observe_data;
global compare_data;
global init_h;
global observe_style

is_match = size(compare_data,1) == size(filtered_x,1) &&...
    size(compare_data,1) == size(filtered_x,1);
[f_name, p_name ] = uiputfile({'*.txt';},'导出分析结果','Undefined.txt');
if isequal(p_name,0) || isequal(f_name,0)
    return;
end
full_name = fullfile(p_name, f_name);
fp = fopen(full_name,'w');
if is_match
    data_gap = (compare_data - filtered_x)';
    mse_filter_true = sum(data_gap.*data_gap)./size(data_gap,1);
    fprintf(fp,'滤波后数据和真实数据的MSE值(按状态变量维度显示)\n');
    fprintf(fp,[num2str(mse_filter_true),'\n']);
else
    fprintf(fp,'导入真实数据不匹配或者未导入\n');
    fprintf(fp,'\n');
end
trans_filtered_x = zeros(size(observe_data,1),size(observe_data,2));
if strcmp(observe_style,'matrix')
    for k=1:size(filtered_x,2)
        trans_filtered_x(:,k) = init_h * filtered_x(:,k);
    end
else
    for k=1:size(filtered_x,2)
        trans_filtered_x(:,k) = init_h(filtered_x(:,k));
    end
end
data_gap = (trans_filtered_x - observe_data)';
mse_filter_true = sum(data_gap.*data_gap)./size(observe_data,2);
fprintf(fp,'滤波后数据和测量数据的MSE值(按观测变量数据维度显示)\n');
fprintf(fp,[num2str(mse_filter_true),'\n']);

function menu_output_figure_Callback(hObject, eventdata, handles)
[filename,pathname]=uiputfile({'*.bmp';},'保存图片','Undefined.bmp');
if ~isequal(filename,0)
    str = [pathname filename];
else
    return;
end;
%     px=getframe(handles.axes_showcompare);
try
    saveas(handles.axes_showcompare,str,'bmp');
    %     imwrite(px.cdata,str,'bmp');
catch
    disp('保存失败');
end

function menu_import_observedata_Callback(hObject, eventdata, handles)
global observe_data;
[f_name, p_name] = uigetfile('*.txt');
%if choose the cancle
if isequal(p_name,0)
    return;
end
full_name = fullfile(p_name, f_name);
format long g
try
    observe_data = load(full_name)';
catch
    msgbox('请输入合法的数据','Error','error');
end

function menu_import_truedata_Callback(hObject, eventdata, handles)
global compare_data;
[f_name, p_name] = uigetfile('*.txt');
%if choose the cancle
if isequal(p_name,0)
    return;
end
full_name = fullfile(p_name, f_name);
format long g
try
    compare_data = load(full_name)';
catch
    msgbox('请输入合法的数据','Error','error');
end

function use_help_github_Callback(hObject, eventdata, handles)
url = 'https://github.com/GeniusLight/KalmanGui';
try
    web(url,'-browser');
catch
    msgbox('需使用浏览器联网查看，或者可选择看项目下文件：README.md','Warn','warn');
end


function uipanel6_CreateFcn(hObject, eventdata, handles)
