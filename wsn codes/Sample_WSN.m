function varargout = Sample_WSN(varargin)
% SAMPLE_WSN MATLAB code for Sample_WSN.fig
%      SAMPLE_WSN, by itself, creates a new SAMPLE_WSN or raises the existing
%      singleton*.
%
%      H = SAMPLE_WSN returns the handle to a new SAMPLE_WSN or the handle to
%      the existing singleton*.
%
%      SAMPLE_WSN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAMPLE_WSN.M with the given input arguments.
%
%      SAMPLE_WSN('Property','Value',...) creates a new SAMPLE_WSN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sample_WSN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sample_WSN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sample_WSN

% Last Modified by GUIDE v2.5 17-Jan-2015 22:36:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sample_WSN_OpeningFcn, ...
                   'gui_OutputFcn',  @Sample_WSN_OutputFcn, ...
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


% --- Executes just before Sample_WSN is made visible.
function Sample_WSN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sample_WSN (see VARARGIN)

% Choose default command line output for Sample_WSN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sample_WSN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Sample_WSN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edt_Nodes_Callback(hObject, eventdata, handles)
% hObject    handle to edt_Nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_Nodes as text
%        str2double(get(hObject,'String')) returns contents of edt_Nodes as a double
global Nodes;
str = get(hObject, 'String');
Nodes = str2num(str);

% --- Executes during object creation, after setting all properties.
function edt_Nodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_Nodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edt_NW_Range_Callback(hObject, eventdata, handles)
% hObject    handle to edt_NW_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edt_NW_Range as text
%        str2double(get(hObject,'String')) returns contents of edt_NW_Range as a double
global NW_range;
str = get(hObject, 'String');
NW_range = str2num(str)

% --- Executes during object creation, after setting all properties.
function edt_NW_Range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edt_NW_Range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btn_Run.
function btn_Run_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Nodes;
global NW_range;
deploy_net(Nodes,NW_range);
% if ((Nodes == 0)||(NW_range ==0))
%     msgbox('values are empty , Network cannot be deployed');
% else
%     deploy_net(Nodes,NW_range);
% end

% --- Executes on button press in btn_Reset.
function btn_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to btn_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
clear global;
xlim('Auto');
ylim('Auto');
title('');
xlabel('');
ylabel('');
cla;
set(handles.edt_Nodes,'String',0);
set(handles.edt_NW_Range,'String',0);
