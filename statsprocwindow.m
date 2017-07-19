function varargout = statsprocwindow(varargin)
% STATSPROCWINDOW M-file for statsprocwindow.fig
%      STATSPROCWINDOW, by itself, creates a new STATSPROCWINDOW or raises the existing
%      singleton*.
%
%      H = STATSPROCWINDOW returns the handle to a new STATSPROCWINDOW or the handle to
%      the existing singleton*.
%
%      STATSPROCWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATSPROCWINDOW.M with the given input arguments.
%
%      STATSPROCWINDOW('Property','Value',...) creates a new STATSPROCWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statsprocwindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statsprocwindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statsprocwindow

% Last Modified by GUIDE v2.5 13-Mar-2010 01:29:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statsprocwindow_OpeningFcn, ...
                   'gui_OutputFcn',  @statsprocwindow_OutputFcn, ...
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


% --- Executes just before statsprocwindow is made visible.
function statsprocwindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statsprocwindow (see VARARGIN)

% Choose default command line output for statsprocwindow
handles.output = hObject;
global sumaP sumaQ zeroS totbarrascsv tiempo
set(handles.text4,'String',strcat(int2str(sumaP),' MW'));
set(handles.text5,'String',strcat(int2str(sumaQ),' Mvar'));
set(handles.text6,'String',int2str(totbarrascsv));
set(handles.text8,'String',int2str(zeroS));

tiempo = tiempo/60;
min = fix(tiempo);
sec = fix((tiempo-fix(tiempo))*60);
set(handles.text10,'String',strcat([int2str(min),'m',' ',int2str(sec),'s']));


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes statsprocwindow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = statsprocwindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
