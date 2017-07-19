%Calcula las muestras existentes por hora en una matriz de demanda P o Q

function nmuestras=muestras(matriz,columna)
[A,B]=size(matriz);
clear B
nmuestras=0;
for i=1:A
    if isnan(matriz(i,columna))
        continue;
    else
        nmuestras=nmuestras+1;
    end
end
clear A