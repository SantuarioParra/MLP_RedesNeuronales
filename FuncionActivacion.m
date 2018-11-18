function A_out=FuncionActivacion(N_out, FunAct)
[fila, columna]=size(N_out);
N_aux=N_out;

switch FunAct
    case 1   %PURELIN
        A_out=N_out;
       
    case 2   %LOGSIG
        for i=1:fila
            N_aux(i)=1/(1+exp(-N_out(i)));
        end 
        A_out=N_aux;
    case 3   %TANSIG
        for i=1:fila
            N_aux(i)=(exp(N_out(i))-exp(-N_out(i)))/(exp(N_out(i))+exp(-N_out(i)));
        end
        A_out=N_aux;
end

end