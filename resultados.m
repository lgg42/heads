function varargout = resultados(varargin)
% RESULTADOS M-file for resultados.fig
%      RESULTADOS, by itself, creates a new RESULTADOS or raises the existing
%      singleton*.
%
%      H = RESULTADOS returns the handle to a new RESULTADOS or the handle to
%      the existing singleton*.
%
%      RESULTADOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULTADOS.M with the given input arguments.
%
%      RESULTADOS('Property','Value',...) creates a new RESULTADOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resultados_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resultados_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resultados

% Last Modified by GUIDE v2.5 24-Mar-2010 22:02:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resultados_OpeningFcn, ...
                   'gui_OutputFcn',  @resultados_OutputFcn, ...
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


% --- Executes just before resultados is made visible.
function resultados_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resultados (see VARARGIN)

% Choose default command line output for resultados
global matresultados matfilteredP matfilteredQ matP barra npodrioP npodrioQ datosporhoraP matdesvP mes
handles.output = hObject;

% Muestra la cantidad de datos de P y Q con errores de cálculo y los
% valores importados y finales por hora
set(handles.text3,'String',int2str(npodrioP));
set(handles.text4,'String',int2str(npodrioQ));

% Muestra los datos por hora importados y finales de P (inicialmente) 

set(handles.uitable3,'ColumnWidth',{70 60});
set(handles.uitable3,'ColumnName',{'Importados', 'Finales'});
set(handles.uitable3,'Data',datosporhoraP);



% Cambia el nombre de la ventana
set(handles.figure1,'Name',strcat(['Resultados para la Subestación: ',barra]));

% Llena la tabla con los promedios de P y Q para las 25 horas
set(handles.uitable2,'ColumnWidth',{45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45 45});
set(handles.uitable2,'Data',matresultados);

% Gráfica la curva de carga promedio insertando el valor de la hora 25
% (pico) entre las horas 19 y 29 o 18 y 19 en dependencia de ser verano o
% invierno.
axes(handles.axes2);
horas = [1:1:25];
activa = [];
reactiva = [];

if ismember(mes,[3 4 5 6 7 8 9 10])
    % Es Verano, el pico va entre las horas 19 y 20
    activa = cat(2,matfilteredP(1:19),matfilteredP(25));
    activa = cat(2,activa,matfilteredP(20:24));
    reactiva = cat(2,matfilteredQ(1:19),matfilteredQ(25));
    reactiva = cat(2,reactiva,matfilteredQ(20:24));
    plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
    set(gca,'XTick',[0:1:25]);
    set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
    %zoom on
else
    % Es Invierno, el pico va entre las horas 18 y 19
    activa = cat(2,matfilteredP(1:18),matfilteredP(25));
    activa = cat(2,activa,matfilteredP(19:24));
    reactiva = cat(2,matfilteredQ(1:18),matfilteredQ(25));
    reactiva = cat(2,reactiva,matfilteredQ(19:24));
    plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
    set(gca,'XTick',[0:1:25]);
    set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
    %zoom on
end

% Gráfica la dispersión de P para la hora 1 (por defecto al crearse la
% ventana) y muestra la desviación estandar para el evento anterior.
axes(handles.axes3);
[valores horas]=size(matP);
clear horas;
axes(handles.axes3);
xrange=[1:1:valores];
fill([xrange(1) xrange(end) xrange(end) xrange(1)],[matfilteredP(1,1)-matdesvP(1) matfilteredP(1,1)-matdesvP(1) matfilteredP(1,1)+matdesvP(1) matfilteredP(1,1)+matdesvP(1)],[0.9 0.9 1]);hold on;
scatter(xrange,matP(:,1),'filled','bs');xlabel('Muestra No.');ylabel('MW','fontsize',7);grid;set(gca,'Layer','top');hold on;
set(handles.axes3,'xlim',[1 valores]);
line([xrange(1) xrange(end)],[matfilteredP(1,1) matfilteredP(1,1)],'LineWidth',2,'LineStyle','-','Color',[1 0 0]);hold off;
clear xrange

set(handles.text5,'String',num2str(matdesvP(1)));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resultados wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = resultados_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global matP matQ matdesvP matdesvQ matfilteredP matfilteredQ

horamenu = get(hObject,'Value');
potgrupo = get(get(handles.uipanel8,'SelectedObject'),'Tag');

% Actualiza el gráfico de la dispersión de datos
switch potgrupo
    case 'radiobutton3'
        [valores horas]=size(matP);
        clear horas;
        set(handles.text5,'String',num2str(matdesvP(horamenu)));
        axes(handles.axes3);
        xrange=[1:1:valores];
        fill([xrange(1) xrange(end) xrange(end) xrange(1)],[matfilteredP(1,horamenu)-matdesvP(horamenu) matfilteredP(1,horamenu)-matdesvP(horamenu) matfilteredP(1,horamenu)+matdesvP(horamenu) matfilteredP(1,horamenu)+matdesvP(horamenu)],[0.9 0.9 1]);hold on;
        scatter(xrange,matP(:,horamenu),'filled','bs');xlabel('Muestra No.');ylabel('MW','fontsize',7);grid;set(gca,'Layer','top');hold on;
        set(handles.axes3,'xlim',[1 valores]);
        line([xrange(1) xrange(end)],[matfilteredP(1,horamenu) matfilteredP(1,horamenu)],'LineWidth',2,'LineStyle','-','Color',[1 0 0]);hold off;
        
    case 'radiobutton5'
        [valores horas]=size(matQ);
        clear horas;
        set(handles.text5,'String',num2str(matdesvQ(horamenu)));
        axes(handles.axes3);
        xrange=[1:1:valores];
        fill([xrange(1) xrange(end) xrange(end) xrange(1)],[matfilteredQ(1,horamenu)-matdesvQ(horamenu) matfilteredQ(1,horamenu)-matdesvQ(horamenu) matfilteredQ(1,horamenu)+matdesvQ(horamenu) matfilteredQ(1,horamenu)+matdesvQ(horamenu)],[0.9 0.9 1]);hold on;
        scatter(xrange,matQ(:,horamenu),'filled','bs');xlabel('Muestra No.');ylabel('Mvar','fontsize',7);grid;set(gca,'Layer','top');hold on;
        set(handles.axes3,'xlim',[1 valores]);
        line([xrange(1) xrange(end)],[matfilteredQ(1,horamenu) matfilteredQ(1,horamenu)],'LineWidth',2,'LineStyle','-','Color',[1 0 0]);hold off;
end
clear xrange






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



% --- Executes when selected object is changed in uipanel8.
function uipanel8_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel8 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global matP matQ matdesvP matdesvQ matfilteredP matfilteredQ
switch get(hObject,'Tag')   % Get Tag of selected object
    case 'radiobutton3'
        [valores horas]=size(matP);
        clear horas;
        horamenu=get(handles.popupmenu1,'Value');
        set(handles.text5,'String',num2str(matdesvP(horamenu)));
        axes(handles.axes3);
        xrange=[1:1:valores];
        fill([xrange(1) xrange(end) xrange(end) xrange(1)],[matfilteredP(1,horamenu)-matdesvP(horamenu) matfilteredP(1,horamenu)-matdesvP(horamenu) matfilteredP(1,horamenu)+matdesvP(horamenu) matfilteredP(1,horamenu)+matdesvP(horamenu)],[0.9 0.9 1]);hold on;
        scatter(xrange,matP(:,horamenu),'filled','bs');xlabel('Muestra No.');ylabel('MW','fontsize',7);grid;set(gca,'Layer','top');hold on;
        set(handles.axes3,'xlim',[1 valores]);
        line([xrange(1) xrange(end)],[matfilteredP(1,horamenu) matfilteredP(1,horamenu)],'LineWidth',2,'LineStyle','-','Color',[1 0 0]);hold off;
        
    case 'radiobutton5'
        [valores horas]=size(matQ);
        clear horas;
        horamenu=get(handles.popupmenu1,'Value');
        set(handles.text5,'String',num2str(matdesvQ(horamenu)));
        axes(handles.axes3);
        xrange=[1:1:valores];
        fill([xrange(1) xrange(end) xrange(end) xrange(1)],[matfilteredQ(1,horamenu)-matdesvQ(horamenu) matfilteredQ(1,horamenu)-matdesvQ(horamenu) matfilteredQ(1,horamenu)+matdesvQ(horamenu) matfilteredQ(1,horamenu)+matdesvQ(horamenu)],[0.9 0.9 1]);hold on;
        scatter(xrange,matQ(:,horamenu),'filled','bs');xlabel('Muestra No.');ylabel('Mvar','fontsize',7);grid;set(gca,'Layer','top');hold on;
        set(handles.axes3,'xlim',[1 valores]);
        line([xrange(1) xrange(end)],[matfilteredQ(1,horamenu) matfilteredQ(1,horamenu)],'LineWidth',2,'LineStyle','-','Color',[1 0 0]);hold off;
end


% --- Executes when selected object is changed in uipanel10.
function uipanel10_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel10 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global datosporhoraP datosporhoraQ
switch get(hObject,'Tag')   % Get Tag of selected object
    case 'radiobutton6'
        set(handles.uitable3,'Data',datosporhoraP);
    case 'radiobutton7'
        set(handles.uitable3,'Data',datosporhoraQ);
end




% --- Executes when selected object is changed in uipanel12.
function uipanel12_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel12 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global matfilteredP matfilteredQ mes

horas=[1:1:25];
switch get(hObject,'Tag')   % Get Tag of selected object
    case 'radiobutton8'
        axes(handles.axes2);
        set(handles.uipanel2,'Title','Curva de Carga Promedio:');
        horas=[1:1:25];
        activa = [];
        reactiva = [];
        if ismember(mes,[3 4 5 6 7 8 9 10])
            % Es Verano, el pico va entre las horas 19 y 20
            activa = cat(2,matfilteredP(1:19),matfilteredP(25));
            activa = cat(2,activa,matfilteredP(20:24));
            reactiva = cat(2,matfilteredQ(1:19),matfilteredQ(25));
            reactiva = cat(2,reactiva,matfilteredQ(20:24));
            plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        else
            % Es Invierno, el pico va entre las horas 18 y 19
            activa = cat(2,matfilteredP(1:18),matfilteredP(25));
            activa = cat(2,activa,matfilteredP(19:24));
            reactiva = cat(2,matfilteredQ(1:18),matfilteredQ(25));
            reactiva = cat(2,reactiva,matfilteredQ(19:24));
            plot(horas, activa,'r.-',horas,reactiva,'b.-');xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        end
    case 'radiobutton9'
        axes(handles.axes2);
        set(handles.uipanel2,'Title','Curva de Carga Promedio:');
        horas=[1:1:25];
        activa = [];
        reactiva = [];
        if ismember(mes,[3 4 5 6 7 8 9 10])
            % Es Verano, el pico va entre las horas 19 y 20
            activa = cat(2,matfilteredP(1:19),matfilteredP(25));
            activa = cat(2,activa,matfilteredP(20:24));
            reactiva = cat(2,matfilteredQ(1:19),matfilteredQ(25));
            reactiva = cat(2,reactiva,matfilteredQ(20:24));
            stairs(horas, activa,'r.-');hold on;stairs(horas,reactiva,'b.-');hold off;xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        else
            % Es Invierno, el pico va entre las horas 18 y 19
            activa = cat(2,matfilteredP(1:18),matfilteredP(25));
            activa = cat(2,activa,matfilteredP(19:24));
            reactiva = cat(2,matfilteredQ(1:18),matfilteredQ(25));
            reactiva = cat(2,reactiva,matfilteredQ(19:24));
            stairs(horas, activa,'r.-');hold on;stairs(horas,reactiva,'b.-');hold off;xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        end
        %stairs(horas, matfilteredP,'r-');hold on;stairs(horas,matfilteredQ,'b-');hold off;xlabel('Hora');legend('P(MW)','Location','NorthWest','Q(Mvar)','Location','NorthWest');grid;
    case 'radiobutton10'
        % Dibuja la curva del FP
        axes(handles.axes2);
        set(handles.uipanel2,'Title','Curva del Factor de Potencia Promedio:');
        matFP = matfilteredP./sqrt(matfilteredP.^2 + matfilteredQ.^2);
        horas = [1:1:25];
        fp = [];
        if ismember(mes,[3 4 5 6 7 8 9 10])
            % Es Verano, el pico va entre las horas 19 y 20
            fp = cat(2,matFP(1:19),matFP(25));
            fp = cat(2,fp,matFP(20:24));
            plot(horas, fp,'k.-');xlabel('Hora');legend('FP','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        else
            % Es Invierno, el pico va entre las horas 18 y 19
            fp = cat(2,matFP(1:18),matFP(25));
            fp = cat(2,fp,matFP(19:24));
            plot(horas, fp,'k.-');xlabel('Hora');legend('FP','Location','NorthWest');grid;
            set(gca,'XTick',[0:1:25]);
            set(gca,'XTickLabel',{'0';'';'';'';'';'5';'';'';'';'';'10';'';'';'';'';'15';'';'';'';'';'';'20';'';'';'';'24'});
        end
end




% --------------------------------------------------------------------
function histfreq_Callback(hObject, eventdata, handles)
% hObject    handle to histfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orgmatP orgmatQ

potgrupo = get(get(handles.uipanel8,'SelectedObject'),'Tag');
switch potgrupo
    case 'radiobutton3'
        figure('Name','Histograma de Frecuencias','NumberTitle','off');hist(orgmatP(:,get(handles.popupmenu1,'Value')));
    case 'radiobutton5'
        figure('Name','Histograma de Frecuencias','NumberTitle','off');hist(orgmatQ(:,get(handles.popupmenu1,'Value')));
end

% --------------------------------------------------------------------
function histdensity_Callback(hObject, eventdata, handles)
% hObject    handle to histdensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global orgmatP orgmatQ

potgrupo = get(get(handles.uipanel8,'SelectedObject'),'Tag');
switch potgrupo
    case 'radiobutton3'
        dfittool(orgmatP(:,get(handles.popupmenu1,'Value')));
    case 'radiobutton5'
        dfittool(orgmatQ(:,get(handles.popupmenu1,'Value')));
end

