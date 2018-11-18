function main()
clc
fid = fopen('Resultados.txt', 'wt');

%apertura de archivos por explorador
[archivo,ruta]=uigetfile('*.txt','Seleccionar el data set ');
if archivo==0
 return;
else
 dat_archivo=strcat(ruta,archivo);
 txt=dat_archivo;
end


data=load(txt);
fprintf('>> Archivo cargado: %s \n', txt);

[fil, colum]=size(data);
%mux = round(rand);
mux=input('Separación de los datos: \n   1. 70%, 15%, 15% \n   2. 80%, 10%, 10% \n');
%mux=1;
clc
[Mvalidacion, Maprendizaje, Mprueba]=ConjuntodeDatos(mux,fil,data);

  display(Maprendizaje); 
  display(Mvalidacion); 
  display(Mprueba);


target= Maprendizaje(:,end);
entrenam=elimina_columna(Maprendizaje,colum);
[fil2, colum2]=size(entrenam);

 

fprintf('\n:::::::::::::::::::::::::::::::::: ARQUITECTURA DEL MLP ::::::::::::::::::::::::::::::');
fprintf(fid, ':::::::::::::::::::::::::::::::::: PERCEPTRON MULTICAPA ::::::::::::::::::::::::::::::');

N=input('\n ¿Cuántos valores tiene el vector de la arquitectura?: ');
RNA=ones(N, 1);
FUNACT=ones(N-1,1);
    for i=1:N
        if i==1
            RNA(i)=colum2;
            fprintf('\n\tNúmero de entradas de la RNA: %i \n', RNA(i));
        else
        fprintf('\tNeuronas en la capa %i: ', i-1);
        RNA(i)=input('');
        end
    end 
    
fprintf('\nFUNCIONES DE ACTIVACIÓN:\n 1 -> purelin(n) \t 2 -> logsig(n) \t 3 -> tansig(n) \n\n');
    for i=1:N-1
        fprintf('\tFunción de activación %i: ', i);
        FUNACT(i)=input('');
    end


eit =input('\n Valor mínimo del error de iteración (Eit): ');
alpha =input(' Factor de aprendizaje (alpha): ');
itMAX =input(' Número de iteraciones máximas: ');

set(0,'RecursionLimit',9999999999)

Pval =input(' Periodo de validación (Pval): ');
MAXval =input(' Valor máximo de validación (MAXval): ');

fprintf(fid, '\n\n Arquitectura del MLP:                ');
fprintf(fid, '['); fprintf(fid, '\t%i', RNA(:,:)); fprintf(fid, ' ]');
fprintf(fid, '\n Funciones de activación:  ');
fprintf(fid, '['); fprintf(fid, '\t%i', FUNACT(:,:)); fprintf(fid, '    ]');
fprintf(fid, '\n Donde: \t');
fprintf(fid, ' 1 -> purelin(n) \t 2 -> logsig(n) \t 3 -> tansig(n) \n');
fprintf(fid,'\n Valor mínimo del error de iteración (Eit): %f',eit);
fprintf(fid,'\n Factor de aprendizaje (alpha): %f',alpha);
fprintf(fid,'\n Iteraciones de aprendizaje: %i',itMAX);
fprintf(fid,'\n Periodo de validación (Pval): %i',Pval);
fprintf(fid,'\n Valor máximo de validación (MAXval): %i',MAXval);

Capas=length(RNA)-1;

for k=1: Capas
   W(k)={rand(RNA(k+1), RNA(k))}; 
   bias(k)={rand(RNA(k+1), 1)};
end

fprintf('\n\n========================================== ITERACIONES MÁXIMAS %i =========================================',itMAX);
fprintf(fid, '\n\n========================================== ITERACIONES MÁXIMAS %i =========================================',itMAX);
   

perceptron(0, fid, target, entrenam, W, bias, 0, eit, alpha, itMAX, 1, RNA, FUNACT, Pval, 1, MAXval, Mvalidacion, Mprueba, 1, 0);
end