function newstring=charchange(string,old_char,new_char)
% cambia en un string, un carácter por otro.
%
% Uso: charchange(string,old_char,new_char)
%
% --> "string" es la variable tipo string que contiene el caracter que se desea cambiar
% --> "old_char" es un string que contiene el caracter que se va a
% sustituir
% --> "new_char" es un string que contiene el caracter que va a
% sustituir al anterior
%
% Ej: charchange(varstr,'.',',')
%
% Hecho por el Yerba para el vago y númerico MatLab.

[row col]=size(string);
clear row;
for i=1:col
    if string(i)==old_char
        string(i)=new_char;
    end
end
newstring=string;