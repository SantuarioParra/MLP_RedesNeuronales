fprintf('Para la funcón de clase\n');
rangoInferior=input('limite inferior del rango\n');
rangoSuperior=input('limite superior del rango\n');
cs=input('cantidad de los saltos\n');

idcE=fopen('datasetClase.txt','w');
intervalo=(rangoSuperior-rangoInferior)/cs;
disp(intervalo)
p=rangoInferior+intervalo;
separador=1;
i=1;
while i<=cs
            gdp=1+sin(((6*pi)/4)*p);
            fprintf(idcE,'%f\t',p);
            fprintf(idcE,'%f\r\n',gdp);   
            p=p+intervalo;
            i=i+1;
end
fclose(idcE);
