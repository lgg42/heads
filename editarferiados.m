function varargout = editarferiados(varargin)
% EDITARFERIADOS M-file for editarferiados.fig
%      EDITARFERIADOS, by itself, creates a new EDITARFERIADOS or raises the existing
%      singleton*.
%
%      H = EDITARFERIADOS returns the handle to a new EDITARFERIADOS or the handle to
%      the existing singleton*.
%
%      EDITARFERIADOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EDITARFERIADOS.M with the given input arguments.
%
%      EDITARFERIADOS('Property','Value',...) creates a new EDITARFERIADOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before editarferiados_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to editarferiados_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help editarferiados

% Last Modified by GUIDE v2.5 28-Feb-2010 14:08:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @editarferiados_OpeningFcn, ...
                   'gui_OutputFcn',  @editarferiados_OutputFcn, ...
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


% --- Executes just before editarferiados is made visible.
function editarferiados_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to editarferiados (see VARARGIN)

% Choose default command line output for editarferiados
handles.output = hObject;

%set(handles.uitable1,'Data', zeros(12,0));
set(handles.uitable1,'ColumnEditable',[true]);
set(handles.uitable1,'ColumnFormat', {'char'})
set(handles.uitable1,'ColumnName', {'Días'})

opciones=load('opciones.mat', 'celldiasferiados');
set(handles.uitable1,'Data',opciones.celldiasferiados(:,2));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes editarferiados wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = editarferiados_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

celldiasferiados={};
datos=get(handles.uitable1,'Data');
nombres=get(handles.uitable1,'RowName');
clear counter
for counter=1:12
    celldiasferiados{counter,1}=nombres{counter};
    celldiasferiados{counter,2}=datos{counter,1};
end
save('opciones.mat', 'celldiasferiados', '-append');
close(gcf);

