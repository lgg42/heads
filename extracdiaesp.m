global salida h sumaP sumaQ zeroS totbarrascsv tiempo
% Convierte a un vector de fechas el número de fecha serie que devuelve el
% calendario
[ano, mes, dia] = datevec(str2double(salida));

% Arranca un timer para contar el tiempo que tomó el procesamiento
tic

% Carga y crea algunas variables necesarias
load('opciones.mat','cellequivalencias');
load('opciones.mat','path');
provincias = {'Pinar del Rio' 'Provincia Habana' 'Ciudad Habana' 'Matanzas' 'Cienfuegos' 'Villa Clara' 'Sancti Spiritus' 'Ciego de Avila' 'Camaguey' 'Las Tunas' 'Holguin' 'Granma' 'Santiago de Cuba' 'Guantanamo'};
celdasexcel = {'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J' 'K' 'L' 'M' 'N' 'O' 'P' 'Q' 'R' 'S' 'T' 'U' 'V' 'W' 'X' 'Y' 'Z' 'AA'};
meses = {'Enero' 'Febrero' 'Marzo' 'Abril' 'Mayo' 'Junio' 'Julio' 'Agosto' 'Septiembre' 'Octubre' 'Noviembre' 'Diciembre'};
mesproceso_string = meses{mes};
anoproceso = int2str(ano);
ventana_progreso = waitbar(0,'');

csvfile = {};
counterfilacsv = 1;
fronteras = {};


% Verifica la consistencia de los datos a procesar si está activada la
% opción
load('opciones.mat', 'checkconsistencia');
clear x eleccion excluir_prov

if checkconsistencia==1
    for cntprov=1:14
        waitbar(cntprov/14,ventana_progreso,sprintf('Verificando consistencia de datos...%3.f%%',(cntprov/14*100)));
        file = strcat(path,'\',provincias{cntprov},'\',anoproceso,'\',mesproceso_string,'.xls');
        
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

% Pide al usuario la Hora a extraer.
hora = inputdlg({''},'Hora',1);
hora = str2double(hora{1});

% Realiza la extracción para las 14 provincias.
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

    % Crea en "file" la cadena de texto con la ruta del .xls a importar
    file = strcat(path,'\',provincias{counter_prov},'\',anoproceso,'\',mesproceso_string,'.xls');
    [typ, desc] = xlsfinfo(file);
    clear typ
   
    % Realiza la extracción de todas las barras de la provincia.
    for counter_barras = 1:size(desc,2)
        % Carga los datos de P y Q del día y hora correspondiente.
        demanda = xlsread(file,desc{counter_barras},strcat(strcat(celdasexcel{hora},int2str(dia*2+3)),':',strcat(celdasexcel{hora},int2str(dia*2+4))));
        
        % Verifica si están podrios y pregunta al usuario que hacer en caso
        % positivo.
        % P y Q podrio.
        try
        if demanda(1) < 0 && demanda(2) < 0
            decision = questdlg({strcat(['Se encontró un error de balance energético de Potencia Activa y Reactiva en: ',desc{counter_barras}]),strcat(['Valor: ',num2str(demanda(1)),' MW',' & ',num2str(demanda(2)),' Mvar']),'','¿Que desea hacer?'},'Error de Balance','Entrar Datos','Excluir Barra','Entrar Datos');
            if strcmp(decision,'Entrar Datos')
                Snueva = inputdlg({'Potencia Activa (MW)','Potencia Reactiva (Mvar)'},'',1);
                demanda(1) = str2double(Snueva{1});demanda(2) = str2double(Snueva{2});
            else
                continue
            end
        % P podrio.
        elseif demanda(1) < 0
            decision = questdlg({strcat(['Se encontró un error de balance energético de Potencia Activa en: ',desc{counter_barras}]),strcat(['Valor: ',num2str(demanda(1)),' MW']),'','¿Que desea hacer?'},'Error de Balance','Entrar Datos','Excluir Barra','Entrar Datos');
            if strcmp(decision,'Entrar Datos')
                Pnueva = inputdlg({'Potencia Activa (MW)'},'',1);
                demanda(1) = str2double(Pnueva{1});
            else
                continue
            end
        % Q podrio.
        elseif demanda(2) < 0
            decision = questdlg({strcat(['Se encontró un error de balance energético de Potencia Reactiva en: ',desc{counter_barras}]),strcat(['Valor: ',num2str(demanda(2)),' Mvar']),'','¿Que desea hacer?'},'Error de Balance','Entrar Datos','Excluir Barra','Entrar Datos');
            if strcmp(decision,'Entrar Datos')
                Qnueva = inputdlg({'Potencia Reactiva (Mvar)'},'',1);
                demanda(2) = str2double(Qnueva{1});
            else
                continue
            end
        end
        catch ME
            if ME.identifier == 'MATLAB:badsubscript'
                demanda(1) = 0; demanda(2) = 0;
            end
        end
        
        
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
                                    csvfile{counterfilacsv,2} = demanda(1)/numbarraspsx;
                                    csvfile{counterfilacsv,3} = demanda(2)/numbarraspsx;
                                    counterfilacsv = counterfilacsv+1;
                                end
                            else
                                csvfile{counterfilacsv,1} = cellequivalencias{1,counter_prov}{counter,2}{1};
                                csvfile{counterfilacsv,2} = demanda(1);
                                csvfile{counterfilacsv,3}= demanda(2);
                                counterfilacsv = counterfilacsv+1;
                            end
                        case 1
                            % Si se encuentra un caso frontera, y el arreglo de
                            % celdas "fronteras" está vacio, agrega este primer
                            % valor encontrado a dicho arreglo.
                            if isempty(fronteras)
                                if numbarraspsx > 1
                                    cellpsx = cellequivalencias{1,counter_prov}{counter,2};
                                    fronteras = {nombrebarra cellpsx demanda(1)/numbarraspsx demanda(2)/numbarraspsx};
                                    clear cellpsx
                                else
                                    fronteras = {nombrebarra cellequivalencias{1,counter_prov}{counter,2}(1) demanda(1) demanda(2)};
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
                                fronteras{j,3} = fronteras{j,3} + demanda(1)/numbarraspsx;
                                fronteras{j,4} = fronteras{j,4} + demanda(2)/numbarraspsx;
                            elseif positivo == 0 && not(strcmp(id,strcat(int2str(counter_prov),int2str(counter))))
                                % Concatena a "fronteras" la nueva barra
                                if numbarraspsx > 1
                                    cellpsx = cellequivalencias{1,counter_prov}{counter,2};
                                    newrow = {nombrebarra cellpsx demanda(1)/numbarraspsx demanda(2)/numbarraspsx};
                                    fronteras = cat(1,fronteras,newrow);
                                    clear cellpsx
                                else
                                    newrow = {nombrebarra cellequivalencias{1,counter_prov}{counter,2}(i) demanda(1) demanda(2)};
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

% Cierra el waitbar
close(ventana_progreso);

% Busca las barras (PSX) que tengan el mismo nombre y combinarlas en una sola.
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

