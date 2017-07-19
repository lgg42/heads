function varargout = resultadostotprov(varargin)
% RESULTADOSTOTPROV M-file for resultadostotprov.fig
%      RESULTADOSTOTPROV, by itself, creates a new RESULTADOSTOTPROV or raises the existing
%      singleton*.
%
%      H = RESULTADOSTOTPROV returns the handle to a new RESULTADOSTOTPROV or the handle to
%      the existing singleton*.
%
%      RESULTADOSTOTPROV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTADOSTOTPROV.M with the given input arguments.
%
%      RESULTADOSTOTPROV('Property','Value',...) creates a new RESULTADOSTOTPROV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resultadostotprov_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resultadostotprov_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resultadostotprov

% Last Modified by GUIDE v2.5 10-Apr-2010 00:34:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resultadostotprov_OpeningFcn, ...
                   'gui_OutputFcn',  @resultadostotprov_OutputFcn, ...
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


% --- Executes just before resultadostotprov is made visible.
function resultadostotprov_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resultadostotprov (see VARARGIN)
global celdasprov matprovP matprovQ mesproceso Selection
provincias = {'Pinar del Rio' 'Provincia Habana' 'Ciudad Habana' 'Matanzas' 'Cienfuegos' 'Villa Clara' 'Sancti Spiritus' 'Ciego de Avila' 'Camaguey' 'Las Tunas' 'Holguin' 'Granma' 'Santiago de Cuba' 'Guantanamo'};
% Choose default command line output for resultadostotprov
handles.output = hObject;

% Cambia el nombre de la ventana
set(gcf,'Name',strcat(['Total Por Provincia: ',provincias{Selection}]));

% Carga inicialmente en la tabla los valores de la demanda de las
% subestaciones de las provincias para la hora 1.
set(handles.uitable1,'RowName',[]);
set(handles.uitable1,'ColumnName',{'Sub.','P(MW)','Q(Mvar)'});
data = {};
colP = {}; colQ = {};
for i = 1:size(celdasprov,1)
    colP = cat(1,colP,celdasprov{i,2}(1));
    colQ = cat(1,colQ,celdasprov{i,3}(1));
end
clear i
data = cat(2,data,celdasprov(:,1));
data = cat(2,data,colP);
data = cat(2,data,colQ);
set(handles.uitable1,'Data',data);
set(handles.text6,'String',strcat([num2str(nansum(cell2mat(colP),1)),' MW']));
set(handles.text7,'String',strcat([num2str(nansum(cell2mat(colQ),1)),' Mvar']));

% Dibuja las curvas de P, Q
horas = [1:1:25];
activa = [];
reactiva = [];

if ismember(mesproceso,[3 4 5 6 7 8 9 10])
    % Es Verano, el pico va entre las horas 19 y 20
    activa = cat(2,matprovP(1:19),matprovP(25));
    activa = cat(2,activa,matprovP(20:24));
    reactiva = cat(2,matprovQ(1:19),matprovQ(25));
    reactiva = cat(2,reactiva,matprovQ(20:24));
    plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
    set(gca,'XTick',[0:1:25]);
    set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
    zoom on
else
    % Es Invierno, el pico va entre las horas 18 y 19
    activa = cat(2,matprovP(1:18),matprovP(25));
    activa = cat(2,activa,matprovP(19:24));
    reactiva = cat(2,matprovQ(1:18),matprovQ(25));
    reactiva = cat(2,reactiva,matprovQ(19:24));
    plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
    set(gca,'XTick',[0:1:25]);
    set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
    zoom on
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resultadostotprov wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = resultadostotprov_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global celdasprov
set(handles.uitable1,'RowName',[]);
set(handles.uitable1,'ColumnName',{'Sub.','P(MW)','Q(Mvar)'});
data = {};
colP = {}; colQ = {};
for i = 1:size(celdasprov,1)
    colP = cat(1,colP,celdasprov{i,2}(get(hObject,'Value')));
    colQ = cat(1,colQ,celdasprov{i,3}(get(hObject,'Value')));
end
clear i
data = cat(2,data,celdasprov(:,1));
data = cat(2,data,colP);
data = cat(2,data,colQ);
set(handles.uitable1,'Data',data);
set(handles.text6,'String',strcat([num2str(nansum(cell2mat(colP),1)),' MW']));
set(handles.text7,'String',strcat([num2str(nansum(cell2mat(colQ),1)),' Mvar']));

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


% --- Executes when selected object is changed in uipanel4.
function uipanel4_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel4 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global matprovP matprovQ matprovFP mesproceso 

switch get(hObject,'Tag')
    case 'radiobutton2'
        % Dibuja la curva del FP
        set(handles.uipanel2,'Title','Curva del Factor de Potencia Promedio:');
        horas = [1:1:25];
        fp = [];
        if ismember(mesproceso,[3 4 5 6 7 8 9 10])
            % Es Verano, el pico va entre las horas 19 y 20
            fp = cat(2,matprovFP(1:19),matprovFP(25));
            fp = cat(2,fp,matprovFP(20:24));
            plot(horas, fp,'k.-');xlabel('Hora');legend('FP','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
            zoom on
        else
            % Es Invierno, el pico va entre las horas 18 y 19
            fp = cat(2,matprovFP(1:18),matprovFP(25));
            fp = cat(2,fp,matprovFP(19:24));
            plot(horas, fp,'k.-');xlabel('Hora');legend('FP','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
            zoom on
        end
    case 'radiobutton1'
        set(handles.uipanel2,'Title','Curva de Carga Promedio:');
        % Dibuja las curvas de P, Q
        horas = [1:1:25];
        activa = [];
        reactiva = [];
        if ismember(mesproceso,[3 4 5 6 7 8 9 10])
            % Es Verano, el pico va entre las horas 19 y 20
            activa = cat(2,matprovP(1:19),matprovP(25));
            activa = cat(2,activa,matprovP(20:24));
            reactiva = cat(2,matprovQ(1:19),matprovQ(25));
            reactiva = cat(2,reactiva,matprovQ(20:24));
            plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        else
            % Es Invierno, el pico va entre las horas 18 y 19
            activa = cat(2,matprovP(1:18),matprovP(25));
            activa = cat(2,activa,matprovP(19:24));
            reactiva = cat(2,matprovQ(1:18),matprovQ(25));
            reactiva = cat(2,reactiva,matprovQ(19:24));
            plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        end
end


