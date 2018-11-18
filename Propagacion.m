function [a, A]=Propagacion(W, bias, entrenamiento, RNA, FUNACT)
[fila, columna]=size(RNA);
Capas=length(RNA)-1;
i=1;
cadena='función';

for k=1: Capas
   a(k)={rand(RNA(k+1), 1)};
end
% 
% c=1;
%     while(c<fila) 
%     display(W{c}(:,:));
%     fprintf('\n bias');
%     display(bias{c}(:,:));
%    c=c+1;
%     end
    
while(i<fila)
    
   % display(W{i}(:,:));
   % display(bias{i}(:,:));

    N_aux=W{i}(:,:)*entrenamiento+bias{i}(:,:);
  %  fprintf('\n   CAPA %i ', i);
  % display(N_aux);
    A_out=FuncionActivacion(N_aux,FUNACT(i));
%    display(A_out);
        if FUNACT(i)==1
            cadena='purelin (n)';
        elseif FUNACT(i)==2
            cadena='logsig(n)';
        elseif FUNACT(i)==3
            cadena='tansig(n)';
        end
    
%    fprintf('\n Aplicando función de activación... %s', cadena);
%  display(A_out);
     entrenamiento=A_out;
     a{i}=A_out;
    i=i+1;
end
 

%display(a);
%display(bias);
A=A_out;
end