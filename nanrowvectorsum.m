function resultado = nanrowvectorsum(x,y)
% Función que suma en la dimensión 1 (filas), dos vectores ignorando los
% valores NaN.
resultado = [];
for i = 1:size(x,2)
    if not(isnan(x(i))) && not(isnan(y(i)))
        resultado(end+1) = x(i) + y(i);
    elseif isnan(x(i))
        resultado(end+1) = y(i);
    else
        resultado(end+1) = x(i);
    end
end