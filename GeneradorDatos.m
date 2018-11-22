%% Generador de funciones
 % Autor: Alejandro Hernández Gómez
 % Carrera: Ingenieria en Sistemas Computacionales
 % Escuela: Escuela Superior de Computo ESCOM - Insituto Politecnico Nacional IPN
 % Asignatura: Neural Networks
 % Grupo: 3CM2
 % Version de MATLAB: R2017a

function GeneradorDatos()
    clc
    name = input('Ingrese el nombre del archivo: ');
    datmin = input('Ingrese el limite inferior del rango: ');
    datmax = input('Ingrese el limite superior del rango: ');
    datos = input('Ingrese el numero de datos a obtener: ');
    p = linspace(datmin,datmax,datos); %p - rango de evaluación
    i = [2];
    [fy, fx] = size(i);

    for it = i
        if(fx > 1)
            file_name = ['FunSeries/',name,'_',int2str(it),'.txt'];
        else
           
            file_name = ['Funciones/',name,'.txt'];
        end
        file = fopen(file_name,'w');
        targetL = [];
        for n = 1 : datos
            prototype = p(n);
            target = g(it,p(n));
            targetL = [targetL, target];
            fprintf(file,'%f',prototype);
            fprintf(file,' %f',target);
            if it<datos-1
                fprintf(file,'\n');
            end
        end
        fclose(file);
        fprintf("\n>> Archivo %s generado correctamente", file_name);
        fprintf("\n>> Graficando funcion resultante\n\n");
        figure
        plot(p,targetL);
    end
    opc = input('¿Desea crear un nuevo archivo? 1.Si 2.No: ');
    if(opc == 1)
        GeneradorDatos();
    else
        opc = input('¿Desea entrenar la red ahora? 1.Si 2.No: ');
        if(opc == 1)
            main();
        end
    end
end

%% Funcion a generar
function [out] = g(n,x)
    out = 5+sin(7*x*x*x*x + 2*x*x*x + x*x); % 1+sen(5Xpi/4)
end