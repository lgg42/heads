function varargout = equivalencias(varargin)
% EQUIVALENCIAS M-file for equivalencias.fig
%      EQUIVALENCIAS, by itself, creates a new EQUIVALENCIAS or raises the existing
%      singleton*.
%
%      H = EQUIVALENCIAS returns the handle to a new EQUIVALENCIAS or the handle to
%      the existing singleton*.
%
%      EQUIVALENCIAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUIVALENCIAS.M with the given input arguments.
%
%      EQUIVALENCIAS('Property','Value',...) creates a new EQUIVALENCIAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equivalencias_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equivalencias_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equivalencias

% Last Modified by GUIDE v2.5 12-Mar-2010 17:05:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equivalencias_OpeningFcn, ...
                   'gui_OutputFcn',  @equivalencias_OutputFcn, ...
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


% --- Executes just before equivalencias is made visible.
function equivalencias_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equivalencias (see VARARGIN)
global prov subvalue
% Choose default command line output for equivalencias
handles.output = hObject;

set(handles.uitable2,'ColumnEditable',[true]);
set(handles.uitable2,'ColumnFormat', {'char'})

load('opciones.mat','cellequivalencias');
string = {};
clear counter;
for counter = 1:size(cellequivalencias{1},1)
    string{end+1,1} = cellequivalencias{1}{counter,1};
end
set(handles.listbox2,'String',string);
subvalue = get(handles.listbox2,'Value');
prov = get(handles.popupmenu1,'Value');

set(handles.uitable2,'Data',cellequivalencias{1,prov}{get(handles.listbox2,'Value'),2});
set(handles.checkbox1,'Value',cellequivalencias{1,prov}{subvalue,3})

% UIWAIT makes equivalencias wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = equivalencias_OutputFcn(hObject, eventdata, handles) 
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

cellequivalencias={};
cellequivalencias=get(handles.uitable1,'Data');
save('opciones.mat', 'cellequivalencias', '-append');
nombres=get(handles.uitable1,'RowName');
clear counter
%for counter=1:12
%    cellequivalencias{counter,1}=nombres{counter};
%    cellequivalencias{counter,2}=datos{counter,1};
%end

%save('opciones.mat', 'cellequivalencias', '-append');
close(gcf);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global prov subvalue

try
subs = get(handles.uitable2,'Data');
newRowdata = cat(1,subs,{''});
set(handles.uitable2,'Data',newRowdata);
catch ME
    if ME.identifier=='MATLAB:catenate:dimensionMismatch'
        set(handles.uitable2,'Data',{});
    end
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global prov subvalue psxselected

subs = get(handles.uitable2,'Data');
clear counter;
for counter = psxselected+1:size(subs,1)
    subs{counter-1} = subs{counter};
end
subs(end)=[];

set(handles.uitable2,'Data',subs);
load('opciones.mat', 'cellequivalencias');
cellequivalencias{1,prov}{subvalue,2} = get(handles.uitable2,'Data');
save('opciones.mat', 'cellequivalencias', '-append');




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global prov

load('opciones.mat','cellequivalencias');
prov=get(hObject,'Value');
string={};
clear counter;
for counter=1:size(cellequivalencias{prov},1)
    string{end+1,1}=cellequivalencias{prov}{counter,1};
end
set(handles.listbox2,'Value',size(string,1));
set(handles.listbox2,'String',string);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2

global prov subvalue
subvalue = get(hObject,'Value');
load('opciones.mat','cellequivalencias');
set(handles.uitable2,'Data',cellequivalencias{1,prov}{get(hObject,'Value'),2});
set(handles.checkbox1,'Value',cellequivalencias{1,prov}{subvalue,3})


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
global prov subvalue

load('opciones.mat', 'cellequivalencias');
cellequivalencias{1,prov}{subvalue,2} = get(handles.uitable2,'Data');
save('opciones.mat', 'cellequivalencias', '-append');


% --- Executes when selected cell(s) is changed in uitable2.
function uitable2_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
global psxselected
try
psxselected = eventdata.Indices(1);
catch ME
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global prov nombresubexcel

load('opciones.mat', 'cellequivalencias');
uiwait(nombre);
cellequivalencias{prov} = cat(1,cellequivalencias{prov},{nombresubexcel {''} 0});

string = {};
clear counter;
for counter = 1:size(cellequivalencias{prov},1)
    string{end+1,1} = cellequivalencias{prov}{counter,1};
end
set(handles.listbox2,'String',string);
save('opciones.mat', 'cellequivalencias', '-append');


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global prov subvalue

lista = get(handles.listbox2,'String');
load('opciones.mat','cellequivalencias')
clear counter;

for counter = subvalue+1:size(get(handles.listbox2,'String'),1)
    cellequivalencias{1,prov}(counter-1,:) = cellequivalencias{1,prov}(counter,:);
    lista{counter-1} = lista{counter};
end
cellequivalencias{1,prov}(end,:)=[];
lista(end) = [];

set(handles.listbox2,'Value',size(lista,1));

set(handles.listbox2,'String',lista);
save('opciones.mat', 'cellequivalencias', '-append');


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
global prov subvalue

load('opciones.mat','cellequivalencias');
cellequivalencias{1,prov}{subvalue,3} = get(hObject,'Value');
save('opciones.mat', 'cellequivalencias', '-append');


