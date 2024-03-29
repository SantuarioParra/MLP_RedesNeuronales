%% Perceptr�n Multicapa MLP
 % Autores: Santuario Parra Luis Fernando 
 % Carrera: Ingenieria en Sistemas Computacionales
 % Escuela: Escuela Superior de Computo ESCOM - Insituto Politecnico Nacional IPN
 % Asignatura: Neural Networks
 % Grupo: 3CM2
 % Version de MATLAB: R2017a
 
function main()
    %% Limpia consola
    clear,clc,close all

    %% Asignaci�n del archivo de resultados y carga del archivo de prototipos y targets
    fid = fopen('Resultados.txt', 'wt');
    disp('Usaras un unico archivo de entradas y targets o usaras un archivo para entradas y targets:');
    opcion=input('1.Un archivo / 2.Dos Archivos : ');
    if opcion==1
     [archivo,ruta]=uigetfile('*.txt','Seleccione el archivo de entradas y targets');
        if archivo==0
         return;
        else
         txt=strcat(ruta,archivo);
        end
    data=load(txt);
    else
    [archivo,ruta]=uigetfile('*.txt','Seleccione el archivo de Entradas');
        if archivo==0
         return;
        else
         txt=strcat(ruta,archivo);
        end  
     [archivo2,ruta2]=uigetfile('*.txt','Seleccione el archivo de targets');
        if archivo2==0
         return;
        else
         txt2=strcat(ruta2,archivo2);
        end
    valores=load(txt);
    targets=load(txt2);
    data = horzcat(valores,targets);
    end

    fprintf('>> El archivo "%s" se carg� correctamente \n\n', txt);
    [fil, colum]=size(data);
    
    fprintf(fid, 'Archivo ingresado: %s', txt);

    %% Asignaci�n de los conjuntos de datos
    mux=input('Tomando en cuenta que [aprendiaje validacion pruebas] \n 1.[75% 15% 15%] \n 2.[80% 10% 10%] \nElija la opcion de distribuci�n deseada: ');
    [Mvalidacion, Maprendizaje, Mprueba]=ConjuntoDat(mux,fil,data);

    target= Maprendizaje(:,end);
    entrenam=elimina_columna(Maprendizaje,colum);
    [~, colum2]=size(entrenam);
    
    %% Asignaci�n de la arquitectura (vector 1)
    arquitectura=input('Ingrese el vector de la arquitectura: ','s' );
    arquitectura=erase(arquitectura,["[","]"]);
    auxn=erase(arquitectura,[" ","[","]"]);
    N=strlength(auxn);
    auxRNA=str2num(arquitectura);
    RNA=ones(N, 1);
    FUNACT=ones(N-1,1);
    
    for i=1:N
        if i==1
            RNA(i)=colum2;
            fprintf('\tN�mero de entradas de la RNA: %i \n', RNA(i));
        else
        fprintf('\tNeuronas en la capa %i: ', i-1);
        RNA(i)=auxRNA(i);
        disp(RNA(i));
        end
    end 
    RNA2 = RNA;
    RNA2(1) = 1;
    disp(['>> Vector de arquitectura elegido: [' num2str(RNA2(:).') ']']) ;
    fprintf("");
    
    %% Asignaci�n de la arquitectura (vector 2)
    fprintf('\nTomando en cuenta que:\n 1. purelin(n) \n 2. logsig(n) \n 3. tansig(n)\n');
    funciones=input('Ingrese el vector de funciones de activaci�n: ','s' );
    funciones=erase(funciones,["[","]"]);
    auxf=str2num(funciones);
    for i=1:N-1
        fprintf('\tFunci�n de activaci�n %i: ', i);
        FUNACT(i)=auxf(i);
        disp(FUNACT(i));
    end
    disp(['>> Vector de arquitectura 2 elegido: [' num2str(FUNACT(:).') ']']) ;
    fprintf("\n");
    
    %% Escribe en el archivo Resultado.txt la arquitectura del MLP
    fprintf(fid, '\n\n Arquitectura del MLP: ');
    fprintf(fid, '['); fprintf(fid, ' %i', RNA2(:,:)); fprintf(fid, ' ] ['); fprintf(fid, ' %i', FUNACT(:,:)); fprintf(fid, ' ]');
    
    
    %% Asignaci�n de los parametros del MLP
    fprintf("Porfavor ingrese los parametros del MLP:\n");
    eit = input('  Ingrese el valor m�nimo del error de iteraci�n (eit): ');
    alpha = input('  Ingrese el factor de aprendizaje (alpha): ');
    epochMAX = input('  Ingrese el n�mero maximo de epocas(epochMax): ');
    epochVal =input('  Ingrese la frecuencia en la que se validar� (epochVal): ');
    numVal =input('  Ingrese el maximo de aumentos en validaci�n (numVal): ');
    
    Wcell = cell(epochMAX,N-1);
    set(0,'RecursionLimit',9999999999)

    %% Escribe en el archivo Resultado.txt los parametros utilizados
    fprintf(fid,'\n Eit: %f',eit);
    fprintf(fid,'\n alpha: %f',alpha);
    fprintf(fid,'\n itmax: %i',epochMAX);
    fprintf(fid,'\n pval: %i',epochVal);
    fprintf(fid,'\n maxval: %i',numVal);

    %% Inicializa con valores aleatorios los pesos y bias
    Capas=length(RNA)-1;
    for k=1: Capas
       W(k)={rand(RNA(k+1), RNA(k))} 
       bias(k)={rand(RNA(k+1), 1)}
    end   
    
    %% Inicializa el entrenamiento
    tic %inicializa el cronometro
    fprintf("\n>> Iniciando el entrenamiento, porfavor espere...\n");
    perceptron(Wcell,0, fid, target, entrenam, W, bias, 0, eit, alpha, epochMAX, 1, RNA, FUNACT, epochVal, 1, numVal, Mvalidacion, Mprueba, 1, 0);
end

%% Conjunto de datos
function [Mvalidacion, Maprendizaje, Mprueba]=ConjuntoDat(mux,fil, data)

    if(mux==1)
        mac = .7;
        mvc = .15;
        mpc = .15;
    else
        mac = .8;
        mvc = .1;
        mpc = .1;
    end
    fprintf('>> Conjunto de datos elegido [%i %i %i]\n', mac*100, mvc*100, mpc*100);

    matrizAUX=data;
    [filas, columnas]=size(data);
    Mvalidacion = [];
    Maprendizaje = [];
    Mprueba = [];
    aux = 1;

    for i = 1:filas
        aux = aux +1;
        if(i < filas*(mac+mvc)+1)
            if(aux == (mvc*100))
                aux = 1;
                Mvalidacion = [Mvalidacion; data(i,:)];
            else
                Maprendizaje = [Maprendizaje; data(i,:)];
            end
        else
            Mprueba = [Mprueba; data(i,:)];
        end
    end
end

%% Eliminar columna
function out = elimina_columna(matriz,columna)
    matriz(:,columna)=[];   
    out=matriz;
end 

%% Funciones de activaci�n
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

%% Graficar pesos
function Grafica_Pesos(matriz,iteracion)
    [~,col]=size(matriz);
    figure('position',[0,0,800,800])
    for j=1:col
        subplot(col,1,j)
        auxW=matriz{1,j};
        [filasA,colA]=size(auxW); 
        auxPlot=zeros(iteracion,colA);
        cont=1;
        for k=1:colA*filasA
            for i=1:iteracion
                auxW=matriz{i,j};   
                if k>colA     
                     auxPlot(i,k)=auxW(cont,rem(k,colA)+1);
                else
                    auxPlot(i,k)=auxW(cont,k);
                end
                if rem(k,colA)==0&&i>iteracion-1
                    cont=cont+1;
                end
            end
        end 
        plot(auxPlot);
        title('Comportamiento de W');
        if cont-1 == 3
            legend('W1','W2', 'W3')
        elseif cont-1==1
            legend('W1')
        elseif cont-1==2
            legend('W1','W2')
        elseif cont-1 == 4
            legend('W1','W2', 'W3', 'W4')
        elseif cont-1 == 5
            legend('W1','W2', 'W3', 'W4', 'W5');
        elseif cont-1 == 6
            legend('W1','W2', 'W3', 'W4', 'W5','W6');
        elseif cont-1 == 7
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7');
        elseif cont-1 == 8
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7','W8');
        elseif cont-1 == 9
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7','W8','W9');
        elseif cont-1 == 10
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7','W8','W9','W10');
        elseif cont-1 == 11
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7','W8','W9','W10','W11');
        elseif cont-1 == 12
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7','W8','W9','W10','W11','W12');
        elseif cont-1 == 13
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7','W8','W9','W10','W11','W12','W13');
        elseif cont-1 == 14
            legend('W1','W2', 'W3', 'W4', 'W5','W6','W7','W8','W9','W10','W11','W12','W13','W14');
        end
    end
end 

%% Graficar datos
function Graficar_Datos(GraficaE, Eprueba, iteracion, Pval, a_total, target,opc)
    [~, col]=size(GraficaE);
    [~, c]=size(a_total);
    i=Pval;
    k=1;
    if iteracion >= Pval
        if opc==1
            x=linspace(1, iteracion-1, iteracion-1);
            y=linspace(1, iteracion-1, 1);
        elseif opc==2
           x=linspace(1, iteracion, iteracion);
            y=linspace(1, iteracion, 1);
        end
        while(i<=col)
           ErrorVal(1,k)=GraficaE(1,i);
           i=i+Pval;
           k=k+1;
        end    
    else
        ErrorVal=0;
        x = linspace(1, iteracion, iteracion);
        y = linspace(1, iteracion, 1);
    end
      
    [fx, cx]=size(x);
    z=linspace(-2,2,c);
    fprintf('\n>> Graficando datos, porfavor espere..');
    
    figure
    
    subplot(2,1,1)
    plot(x,GraficaE, 's:k', y,Eprueba, 'x:b');     
    title('Errores')
    legend('Error ent y val', 'Error prueba');   
    xlabel('N�mero de iteraciones')
    ylabel('Valor del error')  
    
    subplot(2,1,2)
    plot(z,target, 'o k',z,a_total,'+ r');
    legend('Se�al Real', 'Se�al obtenida');   
    title('Resultados')
     
    figure
    
    plot(z,target, 'b',z,a_total,'r');

end

%% Generar vectores random
function [m] = Random(imin,imax,K)
    % Retorna um arreglo de K valores entre imin e imax

    if (imax-imin < K)
        fprintf(' Error:excede el rango\n');
        m = NaN;
        return
    end

    n = 0; % contador de # aleatorios
    m = imin-1;
    imin
    imax
    while (n < K)
    a = randi([round(imin),round(imax)],1);
        if ((a == m) == 0)
            m = [m, a];
            n = n+1;
        end
    end
    m = m(:,2:end);
end 

%% Algoritmo del perceptr�n
function perceptron(Wcell,Wplot, fid, target, matriz, W, bias, GraficaE, eit, alpha, itMAX, iteracion, RNA, FUNACT, Pval, Periodo, MAXval, Mvalidacion, Mprueba, contador, aFinal) 
    [fil2, colum2]=size(matriz);

    Capas=length(RNA)-1;
    for i=1:Capas
        Wcell{iteracion,i}=W{1,i}; 
        save('celdas.mat','Wcell');
    end

    if contador == MAXval
        fprintf('\n>> CRITERIO DE PARO: N�mero m�ximo de incrementos consecutivos alcanzado');
        fprintf(fid,'\n\n>> CRITERIO DE PARO: N�mero m�ximo de incrementos consecutivos alcanzado en la iteraci�n %i', iteracion-1);
         
        timerVal = tic;
        fprintf("\n>>Tiempo de ejecuci�n: %f",timerVal);
        fprintf(fid,"\n>>Tiempo de ejecuci�n: %f",timerVal);
        
        fprintf(fid,'\n');

        for p=1:Capas

            fprintf(fid,'\n Vector de pesos W%i\n',p);
            [v,u]=size(W{p});
            for i=1:v
                for j=1:u
                    fprintf(fid,' %f \t',W{p}(i,j));
                end
                fprintf(fid,'\n');
            end

            fprintf(fid,'\n Vector de bias %i\n',p);
            [v,u]=size(bias{p});
            for i=1:v
                for j=1:u
                    fprintf(fid,' %f \t',bias{p}(i,j));
                end
                fprintf(fid,'\n');
            end
        end

        fclose(fid);

        Eprueba=Prueba(W, bias, RNA, Mprueba, FUNACT);
        Graficar_Datos(GraficaE, Eprueba, iteracion,Pval, aFinal, target,1);
        Grafica_Pesos(Wcell,iteracion);
        opcion=input('\n\n');
        if opcion == 1
            clc
            return
        else
            main();
        end
    end

    if iteracion == itMAX+1
       fprintf('\n>> CRITERIO DE PARO: Iteraciones m�ximas alcanzadas');
        fprintf(fid,'\n>> CRITERIO DE PARO: Iteraciones m�ximas alcanzadas');
        
        timerVal = tic;
        fprintf("\n>>Tiempo de ejecuci�n: %f",timerVal);
        fprintf(fid,"\n>>Tiempo de ejecuci�n: %f",timerVal);
        
        fprintf(fid,'\n');
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
        Graficar_Datos(GraficaE, Eprueba, iteracion,Pval, aFinal, target,1);
        Grafica_Pesos(Wcell,iteracion);
        opcion=input('\n\n');
        if opcion == 1
            clc
            return
        else
            main();
        end
    end
 
    if Periodo == Pval
        Eval=Validacion(W, bias, RNA, Mvalidacion, FUNACT);
        GraficaE(iteracion)=Eval;
        if iteracion>Pval
            if Eval>GraficaE(iteracion-Pval)
                contador=contador+1;
            else
                contador=1;
            end

        end
        perceptron(Wcell,Wplot, fid, target, matriz, W, bias, GraficaE, eit, alpha, itMAX, iteracion+1, RNA, FUNACT, Pval, 1, MAXval, Mvalidacion, Mprueba, contador, aFinal);
    end

    error=zeros(fil2, 1);
    i=1; 
    auxerror=0;


    Waux=W;
    while(i<fil2+1)
        entrenamiento=matriz(i,:)';
        [a, a_out]=Propagacion(W, bias, entrenamiento, RNA, FUNACT); %Propagaci�n hacia adelante

        auxerror=(target(i)-a_out);   
        error(i)=auxerror.^2;
        aFinal(i)=a_out;

        [Wnew, BIASnew]=BackPropagation(a, W, bias, auxerror, RNA, FUNACT, alpha, entrenamiento);
        W=Wnew;
        bias=BIASnew;   
        
        i=i+1;
        auxerror=0;
    end 

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
        fprintf(fid, '\n\n\t error total= %f <= error iteraci�n = %f ----> SI', sum_error, eit);
        fprintf('\n\n\t --> CRITERIO DE PARO: Error de iteraci�n alcanzado');
        fprintf(fid, '\n\n\t --> CRITERIO DE PARO: Error de iteraci�n alcanzado en la iteraci�n %i', iteracion-1);
         
        timerVal = tic;
        fprintf("\n>>Tiempo de ejecuci�n: %f",timerVal);
        fprintf(fid,"\n>>Tiempo de ejecuci�n: %f",timerVal);
        
        fprintf(fid,'\n');
        fclose(fid);

        Eprueba=Prueba(W, bias, RNA, Mprueba, FUNACT);
        Graficar_Datos(GraficaE, Eprueba, iteracion,Pval, aFinal, target,2);
        Grafica_Pesos(Wcell,iteracion);
        opcion=input('\n\n');
        if opcion == 1
            clc
            return
        else
            main();
        end

    else
         perceptron(Wcell,Wplot, fid, target, matriz, W, bias, GraficaE, eit, alpha, itMAX, iteracion+1, RNA, FUNACT, Pval, Periodo+1, MAXval, Mvalidacion, Mprueba, contador, aFinal);
    end
   
 
end

%% Sensitividad
function S = Sensitividades(a, RNA, FUNACT, auxerror, W)
    Capas=length(RNA)-1;
    for k=1: Capas
       S(k)={zeros(RNA(k+1), RNA(k+1))};
       F(k)={zeros(RNA(k+1), RNA(k+1))};
    end

    i=Capas;
    while(i>0)
        [x, y]=size(F{i});
        for j=1:x
            for k=1:y
                if k==j %% diagonal de la matriz F
                    if FUNACT(i)==1  %derivada de purelin
                        F{i}(j,k)=1;  
                	elseif FUNACT(i)==2 %derivada de logsig
                        F{i}(j,k)=a{i}(j,1)*(1-a{i}(j,1));
                    elseif FUNACT(i)==3 %derivada de tansig
                        F{i}(j,k)=1-(a{i}(j,1))^2;
                    end
                end
            end
        end

        if i==Capas
            S{i}=(-2)*auxerror*F{i};
        else   
            S{i}=F{i}*W{i+1}'*S{i+1};
        end
        i=i-1;
    end
    S=S;
end

%% Validaci�n
function sum_error=Validacion(W, bias, RNA, Mvalidacion, FUNACT)
    [fix, cox]=size(RNA);
    [f0, c0]=size(Mvalidacion);
    target= Mvalidacion(:,end);
    matriz=elimina_columna(Mvalidacion,c0);

    error=zeros(f0, 1);
    i=1;
    auxerror=0; 
    while(i<f0+1)
        entrenamiento=matriz(i,:)';
         [a, a_out]=Propagacion(W, bias, entrenamiento, RNA, FUNACT); %Propagaci�n hacia adelante
         auxerror=(target(i)-a_out);   
         error(i)=auxerror.^2;
        auxerror=0;
        i=i+1;
    end
    sum_error=0;
    for i=1: f0
        sum_error=sum_error+error(i);
    end
    sum_error=(sum_error)/f0;
end

%% Prueba
function sum_error=Prueba(W, bias, RNA, Mprueba, FUNACT)
    [fix, cox]=size(RNA);
    [f0, c0]=size(Mprueba);
    target= Mprueba(:,end);
    matriz=elimina_columna(Mprueba,c0);
    error=zeros(f0, 1);
    i=1;
    auxerror=0; 
    while(i<f0+1)
        entrenamiento=matriz(i,:)';
        [a, a_out]=Propagacion(W, bias, entrenamiento, RNA, FUNACT); %Propagaci�n hacia adelante
        auxerror=(target(i)-a_out);   
        error(i)=auxerror.^2;
        auxerror=0;
        i=i+1;
    end
    sum_error=0;
    for i=1: f0
        sum_error=sum_error+error(i);
    end
    sum_error=(sum_error)/f0;
end
 
%% Algoritmo de propagacion hacia adelante
function [a, A]=Propagacion(W, bias, entrenamiento, RNA, FUNACT)
    [fila, columna]=size(RNA);
    Capas=length(RNA)-1;
    i=1;
    cadena='funci�n';

    for k=1: Capas
       a(k)={rand(RNA(k+1), 1)};
    end

    while(i<fila)
        N_aux=W{i}(:,:)*entrenamiento+bias{i}(:,:);
        A_out=FuncionActivacion(N_aux,FUNACT(i));
        
        if FUNACT(i)==1
            cadena='purelin (n)';
        elseif FUNACT(i)==2
            cadena='logsig(n)';
        elseif FUNACT(i)==3
            cadena='tansig(n)';
        end

        entrenamiento=A_out;
        a{i}=A_out;
        i=i+1;
    end
    A=A_out;

end

%% Algoritmo BackPropagation
function [Wnew, BIASnew]=BackPropagation(a, W, bias, auxerror, RNA, FUNACT, alpha, entrenamiento)
    Capas=length(RNA)-1;
    k=Capas;
    S=Sensitividades(a, RNA, FUNACT, auxerror,W);
    while(k>0)
        bias{k}=bias{k}-alpha*S{k};
        if k-1==0
            W{k}= W{k}-alpha*S{k}*entrenamiento';
        else
            W{k}= W{k}-alpha*S{k}*a{k-1}';
        end
        k=k-1;
    end
    Wnew=W;
    BIASnew=bias;
end