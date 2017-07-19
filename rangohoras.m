% Procesa para un rango de horas el promedio de todas las subestaciones.

global mesproceso mesproceso_string anoproceso tipodedias sumaP sumaQ zeroS totbarrascsv tiempo
clear quitprochora
% Arranca un timer para contar el tiempo que tomó el procesamiento
tic

% Carga opciones y crea algunas variables necesarias
load('opciones.mat', 'celldiasferiados');
load('opciones.mat','cellequivalencias');
provincias = {'Pinar del Rio' 'Provincia Habana' 'Ciudad Habana' 'Matanzas' 'Cienfuegos' 'Villa Clara' 'Sancti Spiritus' 'Ciego de Avila' 'Camaguey' 'Las Tunas' 'Holguin' 'Granma' 'Santiago de Cuba' 'Guantanamo'};
celdasexcel = {'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' 'AA'};
promrangoP = 0;
promrangoQ = 0;
rangocount = 0;

% "horaproceso" es tipo entero, "mesproceso" es tipo entero, "mesproceso_string" es tipo string, "anoproceso" es
% tipo string
uiwait(procesarprov);
%if quitprochora == 1
%    return
%end

rango = inputdlg({'Hora Inicial','Hora Final'},'Rango');
% Comprueba que la hora inicial sea menor que la final.
if str2double(rango{1}) > str2double(rango{2})
    helpdlg('La hora final es menor que la inicial, por favor, rectifique.','Error de Horas');
    return;
end
rango = [str2double(rango{1}):1:str2double(rango{2})];

ventana_progreso = waitbar(0,'');

csvfile = {};
counterfilacsv = 1;
diasferiados = str2num(celldiasferiados{mesproceso,2});
fronteras = {};

% Verifica la consistencia de los datos a procesar si está activada la
% opción
load('opciones.mat', 'checkconsistencia');
clear x eleccion excluir_prov

if checkconsistencia == 1
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
    
    for counter_barras = 1:size(desc,2)
    for counterhoraproceso = 1:size(rango,2)
        % Importa los datos
        matexcel = xlsread(file,desc{counter_barras},strcat(celdasexcel{rango(counterhoraproceso)},'5',':',celdasexcel{rango(counterhoraproceso)},'66'));
        
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
        
        % Suma el promedio de la hora anterior con el nuevo calculado
        promrangoP = promrangoP + matfilteredP;
        promrangoQ = promrangoQ + matfilteredQ;
        rangocount = rangocount+1;
        
        % No traduce el nombre hasta que no se hallan sumado todos los
        % promedio.
        while rangocount == size(rango,2)
        
        % Halla el promedio del rango de horas
        promrangoP = promrangoP/size(rango,2);
        promrangoQ = promrangoQ/size(rango,2);
        
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
                                csvfile{counterfilacsv,2} = promrangoP/numbarraspsx;
                                csvfile{counterfilacsv,3} = promrangoQ/numbarraspsx;
                                counterfilacsv = counterfilacsv+1;
                            end
                        else
                            csvfile{counterfilacsv,1} = cellequivalencias{1,counter_prov}{counter,2}{1};
                            csvfile{counterfilacsv,2} = promrangoP;
                            csvfile{counterfilacsv,3} = promrangoQ;
                            counterfilacsv = counterfilacsv+1;
                        end
                    case 1
                        % Si se encuentra un caso frontera, y el arreglo de
                        % celdas "fronteras" está vacio, agrega este primer
                        % valor encontrado a dicho arreglo.
                        if isempty(fronteras)
                            if numbarraspsx > 1
                                cellpsx = cellequivalencias{1,counter_prov}{counter,2};
                                fronteras = {nombrebarra cellpsx promrangoP/numbarraspsx promrangoQ/numbarraspsx};
                                clear cellpsx
                            else
                                fronteras = {nombrebarra cellequivalencias{1,counter_prov}{counter,2}(1) promrangoP promrangoQ};
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
                            fronteras{j,3} = fronteras{j,3} + promrangoP/numbarraspsx;
                            fronteras{j,4} = fronteras{j,4} + promrangoQ/numbarraspsx;
                        elseif positivo == 0 && not(strcmp(id,strcat(int2str(counter_prov),int2str(counter))))
                            % Concatena a "fronteras" la nueva barra
                            if numbarraspsx > 1
                                cellpsx = cellequivalencias{1,counter_prov}{counter,2};
                                newrow = {nombrebarra cellpsx promrangoP/numbarraspsx promrangoQ/numbarraspsx};
                                fronteras = cat(1,fronteras,newrow);
                                clear cellpsx
                            else
                                newrow = {nombrebarra cellequivalencias{1,counter_prov}{counter,2}(i) promrangoP promrangoQ};
                                fronteras = cat(1,fronteras,newrow);
                            end
                        end
                % Este "end" de abajo es el del switch
                end
            end
        end
        clear counter
        promrangoP = 0;
        promrangoQ = 0;
        rangocount = 0;
        end
        
    end
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