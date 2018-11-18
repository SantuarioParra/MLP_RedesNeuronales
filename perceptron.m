function perceptron(Wplot, fid, target, matriz, W, bias, GraficaE, eit, alpha, itMAX, iteracion, RNA, FUNACT, Pval, Periodo, MAXval, Mvalidacion, Mprueba, contador, aFinal)
[fil2, colum2]=size(matriz);
Capas=length(RNA)-1;
if contador == MAXval
    fprintf('\n\n\t --> CRITERIO DE PARO: Número máximo de incrementos consecutivos alcanzado');
%   Grafica_Pesos(W, GraficaE, colum2);
%%%%GraficaE, contiene todos los errores
    %plot(GraficaE,'o--k', 'markersize',5,'markeredgecolor','r','markerfacecolor','w');
    fprintf(fid,'\n\n\t --> CRITERIO DE PARO: Número máximo de incrementos consecutivos alcanzado en la iteración %i', iteracion-1);
    
    for p=1:Capas
        fprintf(fid,'\n W%i\n',p);
            [v,u]=size(W{p});
            for i=1:v
                for j=1:u
                    fprintf(fid,' %f \t',W{p}(i,j));
                end
                fprintf(fid,'\n');
            end
            
            fprintf(fid,'\n\n');
    end
    
    fclose(fid);
    
    Eprueba=Prueba(W, bias, RNA, Mprueba, FUNACT);
    display(Eprueba);
    Graficar_Datos(GraficaE, Eprueba, iteracion,Pval, aFinal, target);
   
    opcion=input('\n\n ¿Volver a intentar? 1. Si 2.No: ');
        if opcion == 1
            main();
        else
            clc
            return
        end    
end

if iteracion == itMAX+1
   fprintf('\n\n\t --> CRITERIO DE PARO: Iteraciones máximas alcanzadas');
    fprintf(fid,'\n\n\t --> CRITERIO DE PARO: Iteraciones máximas alcanzadas');
    display(W);
    
    for p=1:Capas
        fprintf(fid,'\n W%i\n',p);
            [v,u]=size(W{p});
            for i=1:v
                for j=1:u
                    fprintf(fid,' %f \t',W{p}(i,j));
                end
                fprintf(fid,'\n');
            end
            
            fprintf(fid,'\n\n');
    end
    
    fclose(fid);
% % % %     [fa, ca]=size(Wplot);
% % % %     fprintf('filas %i columnas %i', fa, ca);
% % % %     x=linspace(0, iteracion-1, fa);
% % % %     plot(x,Wplot, 'o: ','markersize',5);
 
 
    Eprueba=Prueba(W, bias, RNA, Mprueba, FUNACT);
    display(Eprueba);
    Graficar_Datos(GraficaE, Eprueba, iteracion,Pval, aFinal, target);
    opcion=input('\n\n ¿Volver a intentar? 1. Si 2.No: ');
        if opcion == 1
            main();
        else
            clc
            return
        end    
end
 
if Periodo == Pval
    fprintf('\n---------------------------------------------- Iteracion Validación %i ----------------------------------------------\n', iteracion);
   % fprintf(fid, '\n---------------------------------------------- Iteracion Validación%i  ----------------------------------------------\n', iteracion);  
    Eval=Validacion(W, bias, RNA, Mvalidacion, FUNACT);
    GraficaE(iteracion)=Eval;

    if iteracion>Pval
        if Eval>GraficaE(iteracion-Pval)
            contador=contador+1;
        else
            contador=1;
        end
    
    end
    
    display(contador);
    
    
    fprintf('Error total de validación= %i ', GraficaE(iteracion));
    perceptron(Wplot, fid, target, matriz, W, bias, GraficaE, eit, alpha, itMAX, iteracion+1, RNA, FUNACT, Pval, 1, MAXval, Mvalidacion, Mprueba, contador, aFinal);
end


    fprintf('\n---------------------------------------------- Iteracion Aprendizaje %i ----------------------------------------------\n', iteracion);
    %fprintf(fid, '\n---------------------------------------------- Iteracion Aprendizaje %i  ----------------------------------------------\n', iteracion);  



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PROCESO DE APRENDIZAJE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%
error=zeros(fil2, 1);
i=1; 
auxerror=0;


Waux=W;
while(i<fil2+1)
  entrenamiento=matriz(i,:)';
  [a, a_out]=Propagacion(W, bias, entrenamiento, RNA, FUNACT); %Propagación hacia adelante
    
  auxerror=(target(i)-a_out);   
  error(i)=auxerror.^2;
  aFinal(i)=a_out;
  %%%%%%%%%%%%%%%% APLICAR REGLA DE APRENDIZAJE %%%%%%%%%%%%%%%%%%%%%
    [Wnew, BIASnew]=BackPropagation(a, W, bias, auxerror, RNA, FUNACT, alpha, entrenamiento);
    W=Wnew;
    bias=BIASnew;   
    
    i=i+1;
    auxerror=0;
end 

%Wplot(iteracion)=;
%Wplot(iteracion)=cell(W);
if iteracion==1
    Wplot=Waux{2};
else
T=vertcat(Wplot,Wnew{2});
Wplot=T;
end


 sum_error=0;
 for i=1: fil2
  sum_error=sum_error+error(i);
 end
 sum_error=(sum_error)/fil2;
 
 GraficaE(iteracion)=sum_error;
 
 


 if sum_error <= eit
     fprintf('\n\n\t error total= %f <= error iteración = %f ----> SI', sum_error, eit);
     fprintf(fid, '\n\n\t error total= %f <= error iteración = %f ----> SI', sum_error, eit);
     fprintf('\n\n\t --> CRITERIO DE PARO: Error de iteración alcanzado');
     fprintf(fid, '\n\n\t --> CRITERIO DE PARO: Error de iteración alcanzado en la iteración %i', iteracion-1);
     fclose(fid);
     
    Eprueba=Prueba(W, bias, RNA, Mprueba, FUNACT);
    display(Eprueba);
    Graficar_Datos(GraficaE, Eprueba, iteracion,Pval, aFinal, target);
   
      opcion=input('\n\n ¿Volver a intentar? 1. Si 2.No: ');
        if opcion == 1
            main();
        else
            clc
            return
        end  
        
        
 else
     fprintf('\n\n\t error total= %f <= error iteración = %f ----> NO', sum_error, eit);
     perceptron(Wplot, fid, target, matriz, W, bias, GraficaE, eit, alpha, itMAX, iteracion+1, RNA, FUNACT, Pval, Periodo+1, MAXval, Mvalidacion, Mprueba, contador, aFinal);
 end
 
end