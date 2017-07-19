function varargout = pruebagui(varargin)
% PRUEBAGUI M-file for pruebagui.fig
%      PRUEBAGUI, by itself, creates a new PRUEBAGUI or raises the existing
%      singleton*.
%
%      H = PRUEBAGUI returns the handle to a new PRUEBAGUI or the handle to
%      the existing singleton*.
%
%      PRUEBAGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRUEBAGUI.M with the given input arguments.
%
%      PRUEBAGUI('Property','Value',...) creates a new PRUEBAGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pruebagui_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pruebagui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pruebagui

% Last Modified by GUIDE v2.5 14-Apr-2010 16:29:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pruebagui_OpeningFcn, ...
                   'gui_OutputFcn',  @pruebagui_OutputFcn, ...
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


% --- Executes just before pruebagui is made visible.
function pruebagui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pruebagui (see VARARGIN)

% Choose default command line output for pruebagui
handles.output = hObject;

% Comprueba si es al primera vez que se ejecuta el programa, y en caso
% positivo pregunta al usuario la ruta donde se guaradá la base de datos y
% creas los directorios dentro de esta ruta.

load('opciones.mat', 'ftr');
if ftr == 0
    uiwait(msgbox({'Es la primera vez que se ejecuta la aplicación, seleccione a','continuación el directorio donde se creará la base de datos.'},'Antipudre v1.0','help'));
    path = uigetdir;
    save('opciones.mat', 'path', '-append');
    date = clock;
    year = num2str(date(1));
    provincias = {'Pinar del Rio' 'Provincia Habana' 'Ciudad Habana' 'Matanzas' 'Cienfuegos' 'Villa Clara' 'Sancti Spiritus' 'Ciego de Avila' 'Camaguey' 'Las Tunas' 'Holguin' 'Granma' 'Santiago de Cuba' 'Guantanamo'};
    for i=1:14
        mkdir(strcat(path,'\',provincias{i}));
        mkdir(strcat(path,'\',provincias{i},'\',year));
    end
    ftr = 1;
    save('opciones.mat', 'ftr', '-append');
    clear date ftr path provincias i year;
end

% Carga la ruta del opciones.mat
opciones = load('opciones.mat', 'path');
handles.path = opciones.path;

% Fija en el Edit del año, el año actual
fecha = clock;
set(handles.edit3,'String',int2str(fecha(1)));
clear fecha;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pruebagui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pruebagui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function archivo_Callback(hObject, eventdata, handles)
% hObject    handle to archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

% Carga la ruta del opciones.mat
opciones = load('opciones.mat', 'path');
handles.path = opciones.path;

try
handles.mes=get(hObject,'Value');
mes_lista=get(hObject,'String');
handles.mes_string=mes_lista{handles.mes};

provincia_indice=get(handles.popupmenu3,'Value');
provincia_lista=get(handles.popupmenu3,'String');
handles.provincia=provincia_lista{provincia_indice};
handles.ano=get(handles.edit3,'String');

load('opciones.mat', 'celldiasferiados');
handles.diasferiados=str2num(celldiasferiados{handles.mes,2});
diasferiados_string=celldiasferiados{handles.mes,2};

set(handles.edit4,'String',diasferiados_string);

handles.file=strcat(handles.path,'\',handles.provincia,'\',handles.ano,'\',handles.mes_string,'.xls');
[typ, desc]=xlsfinfo(handles.file);
clear typ;
set(handles.listbox2,'Value',size(desc,2));
set(handles.listbox2,'String',desc);
nbarras=size(desc);
set(handles.text7,'String',int2str(nbarras(2)));
catch ME
    if ME.identifier=='MATLAB:xlsread:FileNotFound'
        msgbox(handles.file,'Error: Archivo especificado no encontrado','error');
    end
end

handles.cargamanual = 0;
set(handles.text8,'Visible','Off');
guidata(gcbo,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.mes=get(hObject,'Value');
mes_lista=get(hObject,'String');
handles.mes_string=mes_lista{handles.mes};

load('opciones.mat', 'celldiasferiados');
handles.diasferiados=str2num(celldiasferiados{handles.mes,2});

guidata(gcbo,handles);

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3

% Carga la ruta del opciones.mat
opciones = load('opciones.mat', 'path');
handles.path = opciones.path;

try
provincia_indice=get(hObject,'Value');
provincia_lista=get(hObject,'String');
handles.provincia=provincia_lista{provincia_indice};

handles.mes=get(handles.popupmenu2,'Value');
mes_lista=get(handles.popupmenu2,'String');
handles.mes_string=mes_lista{handles.mes};

handles.ano=get(handles.edit3,'String');
handles.diasferiados=str2num(get(handles.edit4,'String'));

handles.file=strcat(handles.path,'\',handles.provincia,'\',handles.ano,'\',handles.mes_string,'.xls');
[typ, desc]=xlsfinfo(handles.file);
clear typ;
set(handles.listbox2,'Value',size(desc,2));
set(handles.listbox2,'String',desc);
nbarras=size(desc);
set(handles.text7,'String',int2str(nbarras(2)));

catch ME
    if ME.identifier=='MATLAB:xlsread:FileNotFound'
        msgbox(handles.file,'Error: Archivo especificado no encontrado','error');
    end
end

handles.cargamanual = 0;
set(handles.text8,'Visible','Off');
guidata(gcbo,handles);

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4

handles.tipodedias=get(hObject,'Value');
guidata(gcbo,handles);


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.tipodedias=get(hObject,'Value');
guidata(gcbo,handles);


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function cargamanual_Callback(hObject, eventdata, handles)
% hObject    handle to cargamanual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName,FilterIndex] = uigetfile('.xls','Cargar Archivo');
if isscalar(FileName) && FileName == 0
    return;
end
handles.cargamanual = 1;
handles.manualpath = strcat(PathName,FileName);
try
    [typ desc] = xlsfinfo(handles.manualpath);
catch ME
    return
end
clear typ
set(handles.listbox2,'Value',size(desc,2));
set(handles.listbox2,'String',desc);
set(handles.text8,'Visible','on');

guidata(gcbo,handles);

% --------------------------------------------------------------------
function equivalencias_Callback(hObject, eventdata, handles)
% hObject    handle to equivalencias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
equivalencias

% --------------------------------------------------------------------
function exportar_Callback(hObject, eventdata, handles)
% hObject    handle to exportar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

load('opciones.mat', 'celldiasferiados');
handles.diasferiados=str2num(celldiasferiados{handles.mes,2});
diasferiados_string=celldiasferiados{handles.mes,2};
set(hObject,'String',diasferiados_string);

guidata(gcbo,handles);




% --------------------------------------------------------------------
function opciones_Callback(hObject, eventdata, handles)
% hObject    handle to opciones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function resultados_Callback(hObject, eventdata, handles)
% hObject    handle to resultados (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function promedio_Callback(hObject, eventdata, handles)
% hObject    handle to promedio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global matresultados matfilteredP matfilteredQ matP matQ barra npodrioP npodrioQ datosporhoraP datosporhoraQ matdesvP matdesvQ mes orgmatP orgmatQ

try
barras_indice = get(handles.listbox2,'Value');
barras_lista = get(handles.listbox2,'String');
handles.barra = barras_lista{barras_indice}; 
barra = handles.barra;
catch ME
    if ME.identifier == 'MATLAB:cellRefFromNonCell'
        msgbox('No ha seleccionado ninguna subestación','Error','error');
        return
    end
end
clear barras_indice barras_lista

% Codigo extra para actualizar el año en el caso de que se cambie este
% número en el "edit" correspondiente pero no se despliegue ningún
% popupmenu que actualize "handles.file"

handles.ano = get(handles.edit3,'String');

% Guarda en "handles.file" un string con la ruta del archivo Excel a ser
% importado en dependencia si este fue seleccionado de la Base de Datos o
% cargado manualmente.

if handles.cargamanual == 1;
    handles.file = handles.manualpath;
else
    handles.file = strcat(handles.path,'\',handles.provincia,'\',handles.ano,'\',handles.mes_string,'.xls');
end

% Importa los datos del documento Excel seleccionado 

handles.matexcel = xlsread(handles.file,handles.barra,'C5:AA66');

% Crea la matriz de la potencia activa (matP) y reactiva (matQ), en base a
% los días de la semana seleccionados.

[rows, cols] = size(handles.matexcel);
clear cols;
handles.rows = rows/2;
handles.matP = [];
handles.matQ = [];

% saca los días feriados del "edit4" para asegurar que si se entran nuevos
% días, aparte de los feriados, (ciclones, contingencias, etc), estos sean
% tomados en cuenta

handles.diasferiados=str2num(get(handles.edit4,'String'));


switch handles.tipodedias
    case 1
        for counter=1:handles.rows
            if max(weekday(datenum(str2double(handles.ano), handles.mes, counter))==[2:6]) && not(ismember(counter,handles.diasferiados))
                handles.matP(end+1,:)=handles.matexcel(counter*2-1,:);
                handles.matQ(end+1,:)=handles.matexcel(counter*2,:);
            else
                continue
            end
        end
    case 2
        for counter=1:handles.rows
            if max(weekday(datenum(str2double(handles.ano), handles.mes, counter))==[1,7]) && not(ismember(counter,handles.diasferiados))
                handles.matP(end+1,:)=handles.matexcel(counter*2-1,:);
                handles.matQ(end+1,:)=handles.matexcel(counter*2,:);
            else
                continue
            end
        end
end


% Crea dos vectores fila de los datos útiles importados de P y Q para
% posteriormente juntarlos con los datos finales y mostrarlos en
% la ventana de resultados.

clear counter;
datosimportadosP = [];
datosimportadosQ = [];
for counter=1:25
    datosimportadosP(end+1)=muestras(handles.matP,counter);
end

for counter=1:25
    datosimportadosQ(end+1)=muestras(handles.matQ,counter);
end



% Elimina los valores negativos de las matrices "matP" y "matQ" y saca la
% cuenta del número de pudriciones y muestra este valor

npodrioP=0;
npodrioQ=0;

clear counter;
[A,B]=size(handles.matP);
for counter=1:A*B
if handles.matP(counter)<=0
    handles.matP(counter)=NaN;
    npodrioP=npodrioP+1;
end
end
clear A B

clear counter
[A,B]=size(handles.matQ);
for counter=1:A*B
if handles.matQ(counter)<=0
    handles.matQ(counter)=NaN;
    npodrioQ=npodrioQ+1;
end
end
clear A B

% Número total de pudriciones
handles.npodrioP=npodrioP;
handles.npodrioQ=npodrioQ;

% Salva en orgmatP y orgmatQ las matrices importadas y filtradas por valores negativos y ceros.
orgmatP = handles.matP;
orgmatQ = handles.matQ;


% Se saca el promedio de los 31 días para las 24 horas y la pico de ambas
% matrices, "matP" y "matQ"

handles.matmeanP=nanmean(handles.matP);
handles.matmeanQ=nanmean(handles.matQ);

% Calcula la desviación estandar de los 31 días para las 25 horas tanto de
% potencia Activa como Reactiva

handles.matdesvP=nanstd(handles.matP);
handles.matdesvQ=nanstd(handles.matQ);

% Carga el valor para el error máximo permisible y el número mínimo de
% muestras.

load('opciones.mat','errorP');
load('opciones.mat','errorQ');
load('opciones.mat','minsamples');

% Busca para las 25 horas, si alguna en alguna de ellas el valor de
% desviación estandar de la muestra de 31 días (de P y Q) es superior a la cota, en caso positivo, llama al
% m-file "stdfilter(P y Q)" y haciendo este su trabajo hasta que el valor de la
% desviación estandar para dicha hora sea inferior a la cota introducida
% anteriormente.

clear counter;
for counter=1:25
    try
        if handles.matdesvP(counter)/handles.matmeanP(counter) > errorP/100
            matbenchP=handles.matP(:,counter)-handles.matmeanP(counter);
            while handles.matdesvP(counter)/handles.matmeanP(counter) > errorP/100 && muestras(handles.matP,counter) >= minsamples+1
                [valor, fila] = max(abs(matbenchP));
                handles.matP(fila,counter) = NaN;
                matbenchP(fila) = NaN;
                handles.matdesvP = nanstd(handles.matP);
                handles.matmeanP = nanmean(handles.matP);
                clear valor fila
            end
            clear matbenchP;
        end
    catch ME
        errordlg({'Existe un problema en la base de datos';'';'Causa posible: La base de datos está vacía'},'Error');
        return;
    end
end
clear counter;

for counter=1:25
    try
        if handles.matdesvQ(counter)/handles.matmeanQ(counter) > errorQ/100
            matbenchQ = handles.matQ(:,counter)-handles.matmeanQ(counter);
            while handles.matdesvQ(counter)/handles.matmeanQ(counter) > errorQ/100 && muestras(handles.matQ,counter) >= minsamples+1
                [valor, fila] = max(abs(matbenchQ));
                handles.matQ(fila,counter) = NaN;
                matbenchQ(fila) = NaN;
                handles.matdesvQ = nanstd(handles.matQ);
                handles.matmeanQ = nanmean(handles.matQ);
                clear valor fila
            end
            clear matbenchQ;
        end
    catch ME
        errordlg({'Existe un problema en la base de datos';'';'Causa posible: La base de datos está vacía'},'Error');
        return;
    end
end
clear counter;


% Las matrices filtradas y limpias son:

handles.matfilteredP=nanmean(handles.matP);
handles.matfilteredQ=nanmean(handles.matQ);
matresultados=[];
matresultados(1,:)=handles.matfilteredP;
matresultados(2,:)=handles.matfilteredQ;

matfilteredP=handles.matfilteredP;
matfilteredQ=handles.matfilteredQ;
matP=handles.matP;
matQ=handles.matQ;

matdesvP=nanstd(handles.matP);
matdesvQ=nanstd(handles.matQ);

% Crea dos vectores fila de los datos finales, los junta con los datos
% importados de P y Q y los guarda en las variables "datosporhoraP" y
% "datosporhoraQ" para ser mostrados en la ventana de resultados

clear counter;
datosfinalesP=[];
datosfinalesQ=[];
for counter=1:25
    datosfinalesP(end+1)=muestras(handles.matP,counter);
end

for counter=1:25
    datosfinalesQ(end+1)=muestras(handles.matQ,counter);
end

datosporhoraP=[];
datosporhoraQ=[];

datosporhoraP=[datosimportadosP', datosfinalesP'];
datosporhoraQ=[datosimportadosQ', datosfinalesQ'];

clear datosimportadosP datosimportadosQ datosfinalesP datosfinalesQ;

% Muestra la ventana de resultados
mes = handles.mes;
resultados

guidata(gcbo,handles);



% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

provincia_indice=get(hObject,'Value');
provincia_lista=get(hObject,'String');
handles.provincia=provincia_lista{provincia_indice};
guidata(gcbo,handles);




function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double




% --------------------------------------------------------------------
function procesarhora_Callback(hObject, eventdata, handles)
% hObject    handle to procesarhora (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global horaproceso mesproceso mesproceso_string anoproceso tipodedias sumaP sumaQ zeroS totbarrascsv tiempo quitprochora

% Arranca un timer para contar el tiempo que tomó el procesamiento
tic

load('opciones.mat', 'celldiasferiados');
load('opciones.mat','cellequivalencias');
provincias = {'Pinar del Rio' 'Provincia Habana' 'Ciudad Habana' 'Matanzas' 'Cienfuegos' 'Villa Clara' 'Sancti Spiritus' 'Ciego de Avila' 'Camaguey' 'Las Tunas' 'Holguin' 'Granma' 'Santiago de Cuba' 'Guantanamo'};
celdasexcel = {'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' 'AA'};

% "horaproceso" es tipo entero, "mesproceso" es tipo entero, "mesproceso_string" es tipo string, "anoproceso" es
% tipo string
uiwait(procesarhora);
if quitprochora == 1
    return
end
ventana_progreso = waitbar(0,'');

csvfile = {};
counterfilacsv = 1;
diasferiados = str2num(celldiasferiados{mesproceso,2});
fronteras = {};

% Verifica la consistencia de los datos a procesar si está activada la
% opción

load('opciones.mat', 'checkconsistencia');
clear x eleccion excluir_prov

if checkconsistencia==1
    for cntprov=1:14
        waitbar(cntprov/14,ventana_progreso,sprintf('Verificando consistencia de datos...%3.f%%',(cntprov/14*100)));
        file = strcat(handles.path,'\',provincias{cntprov},'\',anoproceso,'\',mesproceso_string,'.xls');
        
        %Intenta localizar el .xls, si no lo encuentra advierte al usuario
        %de seguir o no el proceso.
        try
            [typ, desc] = xlsfinfo(file);
        catch ME
            if ME.identifier == 'MATLAB:xlsread:FileNotFound'
                eleccion = questdlg({strcat(['No se encuentra la Hoja de Calculo de la Provincia: ',provincias{cntprov}]),'',strcat(['Verifique si existe: ',ME.message(5:end-10)]),'','¿Desea continuar el proceso ?'},'Error','Si','No','No');
                if eleccion == 'Si'
                    % Adiciona el número de la provincia a un vector para
                    % luego no tenerla en cuenta.
                    excluir_prov = [];
                    excluir_prov(end+1) = cntprov;
                    continue;
                else
                    close(ventana_progreso)
                    return
                end
            end
        end
        
        if size(desc,2) == size(cellequivalencias{1,cntprov},1)
            x = 1;
            while x <= size(desc,2)
                positivo = 0;
                y = 1;
                while y <= size(desc,2)
                    if strcmp(desc{x},cellequivalencias{1,cntprov}{y,1})
                        positivo = 1;
                    end
                    y = y+1;
                end
                if positivo == 0
                    warndlg({strcat(['Existe un error de consistencia de nombre en la barra: ',desc{x}]);strcat(['Provincia: ',provincias{cntprov}]);'';'Por favor, rectifique para continuar el proceso'},'Error de Consistencia')
                    close(ventana_progreso);
                    clear all
                    return
                end
                x = x+1;
            end
        else
            warndlg({strcat(['Existe un error de consistencia en el número de barras en: ',provincias{cntprov}]);'';'Por favor, rectifique para continuar el proceso'},'Error de Consistencia');
            close(ventana_progreso);
            clear all
            return
        end
    end
clear x y positivo desc cntprov
end


% Realiza el proceso estadístico para las 14 provincias

showbar = 1;
for counter_prov=1:14
    % Actualiza la barra de progreso del waitbar
    if showbar == 1
        waitbar(0,ventana_progreso,'Procesando...');
    end
    showbar = 0;
    
    % Si la provincia se encuentra en el vector "excluir_prov", no
    % realizarle el proceso pues no se encontró su hoja de cálculo
    ext = exist('excluir_prov');
    if ext
        if ismember(counter_prov,excluir_prov)
            continue;
        end
    end
    
    file = strcat(handles.path,'\',provincias{counter_prov},'\',anoproceso,'\',mesproceso_string,'.xls');
    [typ, desc] = xlsfinfo(file);
    % desc es un vector fila con los nombres de las subestaciones
    clear typ;
    nbarras = size(desc);
    nbarras(2);
    for counter_barras = 1:nbarras(2)
        matexcel = xlsread(file,desc{counter_barras},strcat(celdasexcel{horaproceso},'5',':',celdasexcel{horaproceso},'66'));
        
        % Crea la matriz de la potencia activa (matP) y reactiva (matQ), en base a
        % los días de la semana seleccionados.
        
        [rows, cols] = size(matexcel);
        clear cols;
        rows = rows/2;
        matP=[];
        matQ=[];
        clear counter
        switch tipodedias
            case 1
                for counter=1:rows
                    if max(weekday(datenum(str2double(anoproceso), mesproceso, counter))==[2:6]) && not(ismember(counter,diasferiados))
                        matP(end+1,:)=matexcel(counter*2-1,:);
                        matQ(end+1,:)=matexcel(counter*2,:);
                    else
                        continue
                    end
                end
            case 2
                for counter=1:rows
                    if max(weekday(datenum(str2double(anoproceso), mesproceso, counter))==[1,7]) && not(ismember(counter,diasferiados))
                        matP(end+1,:)=matexcel(counter*2-1,:);
                        matQ(end+1,:)=matexcel(counter*2,:);
                    else
                        continue
                    end
                end
        end

        % Elimina los valores negativos de las matrices "matP" y "matQ" y saca la
        % cuenta del número de pudriciones y muestra este valor
        
        npodrioP=0;
        npodrioQ=0;

        clear counter;
        [A,B]=size(matP);
        for counter=1:A*B
            if matP(counter)<=0
                matP(counter)=NaN;
                npodrioP=npodrioP+1;
            end
        end
        clear A B

        clear counter
        [A,B]=size(matQ);
        for counter=1:A*B
            if matQ(counter)<=0
                matQ(counter)=NaN;
                npodrioQ=npodrioQ+1;
            end
        end
        clear A B
        clear counter
        
        % Se saca el promedio de los 31 días para ambas matrices, "matP" y "matQ"
        matmeanP=nanmean(matP);
        matmeanQ=nanmean(matQ);
        
        % Calcula la desviación estandar de los 31 días tanto de potencia Activa como Reactiva
        matdesvP=nanstd(matP);
        matdesvQ=nanstd(matQ);
        
        % Carga el valor para el error máximo permisible y el número mínimo de
        % muestras.
        load('opciones.mat','errorP');
        load('opciones.mat','errorQ');
        load('opciones.mat','minsamples');
        
        % Busca si la desviación estandar de la muestra de 31 días (de P y Q) es
        % superior a la cota, en caso positivo, elimina el dato "extremo" y se recalcula
        % el promedio y la desv.std. hasta que el valor de la desviación estandar para 
        % dicha hora sea inferior a la cota introducida anteriormente.
        
        if matdesvP/matmeanP > errorP/100
            matbenchP=matP(:,1)-matmeanP(1);
            corregidosP=0;
            while matdesvP/matmeanP > errorP/100 && muestras(matP,1) >= minsamples+1
                [valor, fila]=max(abs(matbenchP));
                matP(fila,1)=NaN;
                matbenchP(fila)=NaN;
                corregidosP=corregidosP+1;
                matdesvP=nanstd(matP);
                matmeanP=nanmean(matP);
                clear valor fila
            end
            clear matbenchP;
        end
        
        if matdesvQ/matmeanQ > errorQ/100
            matbenchQ=matQ(:,1)-matmeanQ(1);
            corregidosQ=0;
            while matdesvQ/matmeanQ > errorQ/100 && muestras(matQ,1) >= minsamples+1
                [valor, fila]=max(abs(matbenchQ));
                matQ(fila,1)=NaN;
                matbenchQ(fila)=NaN;
                corregidosQ=corregidosQ+1;
                matdesvQ=nanstd(matQ);
                matmeanQ=nanmean(matQ);
                clear valor fila
            end
            clear matbenchQ;
        end
        
        % Los valores filtrados y limpios son:
        matfilteredP=nanmean(matP);
        matfilteredQ=nanmean(matQ);
        
        
        % 666 - Aqui empieza la traducción de los nombres de las barras de los documentos
        % Excel a los del PSX
        
        nombrebarra = desc{counter_barras};
        clear counter
                
        for counter = 1:size(desc,2)
            if strcmp(cellequivalencias{1,counter_prov}{counter,1},nombrebarra)
                numbarraspsx = size(cellequivalencias{1,counter_prov}{counter,2},1);
                barrafrontera = cellequivalencias{1,counter_prov}{counter,3};
                switch barrafrontera
                    case 0
                        if numbarraspsx > 1
                            clear i
                            for i = 1:numbarraspsx
                                csvfile{counterfilacsv,1} = cellequivalencias{1,counter_prov}{counter,2}{i};
                                csvfile{counterfilacsv,2} = matfilteredP/numbarraspsx;
                                csvfile{counterfilacsv,3} = matfilteredQ/numbarraspsx;
                                counterfilacsv = counterfilacsv+1;
                            end
                        else
                            csvfile{counterfilacsv,1} = cellequivalencias{1,counter_prov}{counter,2}{1};
                            csvfile{counterfilacsv,2} = matfilteredP;
                            csvfile{counterfilacsv,3}= matfilteredQ;
                            counterfilacsv = counterfilacsv+1;
                        end
                    case 1
                        % Si se encuentra un caso frontera, y el arreglo de
                        % celdas "fronteras" está vacio, agrega este primer
                        % valor encontrado a dicho arreglo.
                        if isempty(fronteras)
                            if numbarraspsx > 1
                                cellpsx = cellequivalencias{1,counter_prov}{counter,2};
                                fronteras = {nombrebarra cellpsx matfilteredP/numbarraspsx matfilteredQ/numbarraspsx};
                                clear cellpsx
                            else
                                fronteras = {nombrebarra cellequivalencias{1,counter_prov}{counter,2}(1) matfilteredP matfilteredQ};
                            end
                            % Crea un número identitficador "id" de la barra que
                            % se acaba de incluir en fronteras, para que
                            % posteriormente dicha barra no vuelva a ser
                            % procesada
                            id = strcat(int2str(counter_prov),int2str(counter));
                        end
                        
                        % Verifica si para el caso frontera encontrado ya
                        % existe la otra barra frontera correspondiente
                        % declarada en el arreglo "fronteras. En caso
                        % positivo, se le adiciona el valor encontrado, en
                        % caso negativo, adiciona la barra a "fronteras".
                        
                        positivo = 0;
                        i = 1;
                        while i <= size(fronteras,1)
                            if strcmp(fronteras{i,1},nombrebarra) && not(strcmp(id,strcat(int2str(counter_prov),int2str(counter))))
                                positivo = 1;
                                j = i;
                            end
                            i = i+1;
                        end
                        
                        if positivo == 1
                            % Suma a la barra existente, la demanda de la
                            % nueva barra frontera encontrada
                            fronteras{j,3} = fronteras{j,3} + matfilteredP/numbarraspsx;
                            fronteras{j,4} = fronteras{j,4} + matfilteredQ/numbarraspsx;
                        elseif positivo == 0 && not(strcmp(id,strcat(int2str(counter_prov),int2str(counter))))
                            % Concatena a "fronteras" la nueva barra
                            if numbarraspsx > 1
                                cellpsx = cellequivalencias{1,counter_prov}{counter,2};
                                newrow = {nombrebarra cellpsx matfilteredP/numbarraspsx matfilteredQ/numbarraspsx};
                                fronteras = cat(1,fronteras,newrow);
                                clear cellpsx
                            else
                                newrow = {nombrebarra cellequivalencias{1,counter_prov}{counter,2}(i) matfilteredP matfilteredQ};
                                fronteras = cat(1,fronteras,newrow);
                            end
                        end
                % Este "end" de abajo es el del switch
                end
            end
        end
        clear counter
        
    end
waitbar(counter_prov/14,ventana_progreso,sprintf('Procesando...%3.f%%',(counter_prov/14*100)))
end

% Concatena las barras del arreglo "fronteras" al arreglo "csvfile"
clear i j
for i = 1:size(fronteras,1)
    for j = 1:size(fronteras{i,2},1)
        csvfile=cat(1,csvfile,{fronteras{i,2}{j} fronteras{i,3} fronteras{i,4}});
    end
end
clear i j

close(ventana_progreso);

[subestaciones columnas]=size(csvfile);
clear counter columnas

% Cambia a 0 los valores NaN del arreglo de celdas generado.

ventana_limpiando = waitbar(0,'Corrigiendo valores NaN...');
for counter=1:subestaciones
    if isnan(csvfile{counter,2})
        csvfile{counter,2}=0;
    end
    
    if isnan(csvfile{counter,3})
        csvfile{counter,3}=0;
    end
    waitbar(counter/subestaciones,ventana_limpiando,sprintf('Corrigiendo valores NaN...%3.f%%',((counter/subestaciones)*100)));
end

% Buscar las barras que tengan el mismo nombre y combinarlas en una sola.

clear g i j k counter borrar
borrar = [];
i = 1;

while i ~= size(csvfile,1)
    j = 1;
    while j+i <= size(csvfile,1)
        if strcmp(csvfile{i,1},csvfile{j+i,1})
            borrar(end+1) = j+i;
            csvfile{i,2} = csvfile{i,2} + csvfile{j+i,2};
            csvfile{i,3} = csvfile{i,3} + csvfile{j+i,3};
        end
        j = j+1;
    end
    
    if size(borrar,2) ~= 0
        clear k g counter
        g=0;
        for k=1:size(borrar,2)
            for counter=borrar(k)-g+1:size(csvfile,1) 
                csvfile(counter-1,:)=csvfile(counter,:);
            end
            csvfile(end,:)=[];
            g=g+1;
        end
    end
    borrar=[];
    i=i+1;
end
clear g i j k borrar

% Mostrar estadísticas del proceso en caso de estar activada la opción
load('opciones.mat','statsproc');
if statsproc == 1
    sumaP = 0; sumaQ = 0; zeroS = 0;
    clear counter
    for counter = 1:size(csvfile,1)
        sumaP = sumaP+csvfile{counter,2};
        sumaQ = sumaQ+csvfile{counter,3};
        if csvfile{counter,2} == 0 && csvfile{counter,3} == 0
            zeroS=zeroS+1;
        end
    end
    totbarrascsv=size(csvfile,1);
    tiempo=toc;
    statsprocwindow
end


% Carga de las opciones el separador de campo a ser utilizado en el archivo
% csv
load('opciones.mat','separadorcampo')

% Salva en un archivo con extensión csv, el arreglo de celdas generado que
% contiene toda la información
[FileName,PathName,FilterIndex] = uiputfile('*.lod');
cellstrnum2csv(strcat(PathName,FileName),csvfile,separadorcampo);

close(ventana_limpiando);

clear counter matexcel nbarras counter_barras counter_prov desc file provincias celdasexcel matP matQ diasferiados separadorcampo FileName PathName FilterIndex;


% --------------------------------------------------------------------
function editarferiados_Callback(hObject, eventdata, handles)
% hObject    handle to editarferiados (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
editarferiados;




% --------------------------------------------------------------------
function configuracion_Callback(hObject, eventdata, handles)
% hObject    handle to configuracion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

opciones




% --------------------------------------------------------------------
function acerca_Callback(hObject, eventdata, handles)
% hObject    handle to acerca (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
acercade



% --------------------------------------------------------------------
function promedios_menu_Callback(hObject, eventdata, handles)
% hObject    handle to promedios_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function extraccion_menu_Callback(hObject, eventdata, handles)
% hObject    handle to extraccion_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function diaespecifico_Callback(hObject, eventdata, handles)
% hObject    handle to diaespecifico (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
calendario('OutputDateStyle',2);

% --------------------------------------------------------------------
function totalprovincias_Callback(hObject, eventdata, handles)
% hObject    handle to totalprovincias (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global mesproceso mesproceso_string anoproceso tipodedias matprovFP matprovP matprovQ celdasprov Selection
provincias = {'Pinar del Rio' 'Provincia Habana' 'Ciudad Habana' 'Matanzas' 'Cienfuegos' 'Villa Clara' 'Sancti Spiritus' 'Ciego de Avila' 'Camaguey' 'Las Tunas' 'Holguin' 'Granma' 'Santiago de Cuba' 'Guantanamo'};

% Crea inicialmente las matrices que tendran el total de la demanda de la
% provincia para las 25 horas y el arreglo de celdas que contiene la
% demanda de todas las subestaciones.
matprovP = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
matprovQ = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
celdasprov = {'' 0 0};

% Abre un dialogo de selección de la(s) provincia(s)
[Selection,ok] = listdlg('ListString',{'Pinar del Rio' 'Provincia Habana' 'Ciudad Habana' 'Matanzas' 'Cienfuegos' 'Villa Clara' 'Sancti Spiritus' 'Ciego de Avila' 'Camaguey' 'Las Tunas' 'Holguin' 'Granma' 'Santiago de Cuba' 'Guantanamo'},'OKString','Aceptar','CancelString','Cancelar','Name','Selección','ListSize',[160 200]);

% Reliza los cálculos y muestra los resultados en dependencia del número de
% provincia seleccionadas.
if size(Selection,2) == 1 && ok == 1
    % Solicitita hora, mes, año, tipo de días
    uiwait(procesarprov);
    
    load('opciones.mat', 'celldiasferiados');
    handles.diasferiados = str2num(celldiasferiados{mesproceso,2});
    handles.ano = anoproceso;
    
    % Verifíca si existe el archivo
    file = strcat(handles.path,'\',provincias{Selection},'\',anoproceso,'\',mesproceso_string,'.xls');
    try
    [typ, desc] = xlsfinfo(file);
    catch ME
        if ME.identifier == 'MATLAB:xlsread:FileNotFound'
            errordlg({'No se encuentra el archivo:',ME.message(5:end-10)},'Error');
            return;
        end
    end

    % Proceso estadístico
    ventana_progreso = waitbar(0,'');
    waitbar(0,ventana_progreso,'Procesando...');
    for counter_barras = 1:size(desc,2)
        handles.matexcel = xlsread(file,desc{counter_barras},'C5:AA66');
        
        % Crea la matriz de la potencia activa (matP) y reactiva (matQ), en base a
        % los días de la semana seleccionados.
        [rows, cols] = size(handles.matexcel);
        clear cols;
        handles.rows = rows/2;
        handles.matP = [];
        handles.matQ = [];
        switch tipodedias
            
            case 1
                for counter=1:handles.rows
                    if max(weekday(datenum(str2double(handles.ano), handles.mes, counter))==[2:6]) && not(ismember(counter,handles.diasferiados))
                        handles.matP(end+1,:)=handles.matexcel(counter*2-1,:);
                        handles.matQ(end+1,:)=handles.matexcel(counter*2,:);
                    else
                        continue
                    end
                end
            case 2
                for counter=1:handles.rows
                    if max(weekday(datenum(str2double(handles.ano), handles.mes, counter))==[1,7]) && not(ismember(counter,handles.diasferiados))
                        handles.matP(end+1,:)=handles.matexcel(counter*2-1,:);
                        handles.matQ(end+1,:)=handles.matexcel(counter*2,:);
                    else
                        continue
                    end
                end
        end
        
        % Elimina los valores negativos de las matrices "matP" y "matQ" y saca la
        % cuenta del número de pudriciones y muestra este valor
        npodrioP=0;
        npodrioQ=0;
        
        clear counter;
        [A,B]=size(handles.matP);
        for counter=1:A*B
            if handles.matP(counter)<=0
                handles.matP(counter)=NaN;
                npodrioP=npodrioP+1;
            end
        end
        clear A B
        
        clear counter
        [A,B]=size(handles.matQ);
        for counter=1:A*B
            if handles.matQ(counter)<=0
                handles.matQ(counter)=NaN;
                npodrioQ=npodrioQ+1;
            end
        end
        clear A B
        
        % Número total de pudriciones
        handles.npodrioP=npodrioP;
        handles.npodrioQ=npodrioQ;
        
        % Se saca el promedio de los 31 días para las 24 horas y la pico de ambas
        % matrices, "matP" y "matQ"
        handles.matmeanP=nanmean(handles.matP);
        handles.matmeanQ=nanmean(handles.matQ);

        % Calcula la desviación estandar de los 31 días para las 25 horas tanto de
        % potencia Activa como Reactiva
        handles.matdesvP=nanstd(handles.matP);
        handles.matdesvQ=nanstd(handles.matQ);

        % Carga el valor para el error máximo permisible y el número mínimo de
        % muestras.
        load('opciones.mat','errorP');
        load('opciones.mat','errorQ');
        load('opciones.mat','minsamples');
        
        % Busca para las 25 horas, si alguna en alguna de ellas el valor de
        % desviación estandar de la muestra de 31 días (de P y Q) es superior a la cota, en caso positivo, llama al
        % m-file "stdfilter(P y Q)" y haciendo este su trabajo hasta que el valor de la
        % desviación estandar para dicha hora sea inferior a la cota introducida
        % anteriormente.
        clear counter;
        for counter=1:25
            try
                if handles.matdesvP(counter)/handles.matmeanP(counter) > errorP/100
                    matbenchP=handles.matP(:,counter)-handles.matmeanP(counter);
                    while handles.matdesvP(counter)/handles.matmeanP(counter) > errorP/100 && muestras(handles.matP,counter) >= minsamples+1
                        [valor, fila] = max(abs(matbenchP));
                        handles.matP(fila,counter) = NaN;
                        matbenchP(fila) = NaN;
                        handles.matdesvP = nanstd(handles.matP);
                        handles.matmeanP = nanmean(handles.matP);
                        clear valor fila
                    end
                    clear matbenchP;
                end
            catch ME
                %errordlg({'No existen datos de la barra:',desc{counter_barras}; 'Se el asignará demanda nula'});
                % Se le asigna un cero si no existen absolutamente ningún
                % dato en la hoja de cálculo
                handles.matP = zeros(2,25);
            end
        end
        clear counter;
        
        for counter=1:25
            try
                if handles.matdesvQ(counter)/handles.matmeanQ(counter) > errorQ/100
                    matbenchQ = handles.matQ(:,counter)-handles.matmeanQ(counter);
                    while handles.matdesvQ(counter)/handles.matmeanQ(counter) > errorQ/100 && muestras(handles.matQ,counter) >= minsamples+1
                        [valor, fila] = max(abs(matbenchQ));
                        handles.matQ(fila,counter) = NaN;
                        matbenchQ(fila) = NaN;
                        handles.matdesvQ = nanstd(handles.matQ);
                        handles.matmeanQ = nanmean(handles.matQ);
                        clear valor fila
                    end
                    clear matbenchQ;
                end
            catch ME
                %errordlg({'No existen datos de la barra:',desc{counter_barras}; 'Se el asignará demanda nula'});
                % Se le asigna un cero si no existen absolutamente ningún
                % dato en la hoja de cálculo
                handles.matQ = zeros(2,25);
            end
        end
        clear counter;
        
        % Las matrices filtradas y limpias son:
        handles.matfilteredP = nanmean(handles.matP);
        handles.matfilteredQ = nanmean(handles.matQ);

        % Suma al total la barra recien calculada ignorando los NaN con la función 
        % "nanrowvectorsum" que tuviste que crearle al MATLAB.
        matprovP = nanrowvectorsum(matprovP,handles.matfilteredP);
        matprovQ = nanrowvectorsum(matprovQ,handles.matfilteredQ);
    
        waitbar(counter_barras/size(desc,2),ventana_progreso,sprintf('Procesando...%3.f%%',(counter_barras/size(desc,2)*100)));
    celdasprov{counter_barras,1} = desc{counter_barras};
    celdasprov{counter_barras,2} = handles.matfilteredP;
    celdasprov{counter_barras,3} = handles.matfilteredQ;
    end

    % Calcula el Factor de Potencia para las 25 horas.
    matprovFP = matprovP./sqrt(matprovP.^2 + matprovQ.^2);
    close(ventana_progreso);
    resultadostotprov;
    
elseif size(Selection,2) > 1 && ok == 1
    msgbox('Todavía no está implementado el procesamiento de múltiples provincias.');
else
    return
end


% --------------------------------------------------------------------
function procrangohoras_Callback(hObject, eventdata, handles)
% hObject    handle to procrangohoras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rangohoras



% --------------------------------------------------------------------
function manualusuario_Callback(hObject, eventdata, handles)
% hObject    handle to manualusuario (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
!Manual de Usuario.pdf

