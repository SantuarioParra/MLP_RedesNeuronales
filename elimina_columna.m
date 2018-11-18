function out = elimina_columna(matriz,columna)
if size(matriz,2)
   % fprintf('La matriz es muy corta');
end
matriz(:,columna)=[];   
out=matriz;
end
