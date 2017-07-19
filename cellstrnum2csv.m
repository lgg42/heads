function cellstrnum2csv(filename, cellarray, delimiter)
% Función para convertir un arreglo de celdas contenidos de strings y/o
% enteros a un archivo csv usando cualquier simbolo como delimitador.

% Uso: cellstrnum2csv(filename, cellarray, delimiter)

% --> "filename" es un string con el nombre del archivo a exportar
% --> "cellarray" es el arreglo de celdas
% --> "delimiter" es un string con el símbolo delimitador

% Ej: cellstrnum2csv('datos.csv', resultados, ';')

% Hecho por el Yerba para el vago y númerico MatLab.

fid = fopen(filename, 'wt');
[filas columnas]=size(cellarray);
clear counter;
load('opciones.mat', 'separadordecimal');
if separadordecimal=='.'
    for counter_row=1:filas
        string=char();
        for counter_col=1:columnas
            string=strcat(string,num2str(cellarray{counter_row,counter_col}),delimiter);
        end
        fprintf(fid, strcat(string,'\n'));
    end
else
    for counter_row=1:filas
        string=char();
        for counter_col=1:columnas
            string=strcat(string,charchange(num2str(cellarray{counter_row,counter_col}),'.',separadordecimal),delimiter);
        end
        fprintf(fid, strcat(string,'\n'));
    end
end
clear separadordecimal
fclose(fid);