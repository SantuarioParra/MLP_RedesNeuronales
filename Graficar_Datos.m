function Graficar_Datos(GraficaE, Eprueba, iteracion, Pval, a_total, target)
   [fil, col]=size(GraficaE);
   [f, c]=size(a_total);
  
 
    
   
   i=Pval;
   k=1;
   if iteracion >= Pval
        x=linspace(1, iteracion-1, iteracion-1);
        y=linspace(1, iteracion-1, 1);
       while(i<=col)
           ErrorVal(1,k)=GraficaE(1,i);
           i=i+Pval;
           k=k+1;
       end
       
       

    
   else
       ErrorVal=0;
    x=linspace(1, iteracion, iteracion);
    y=linspace(1, iteracion, 1);
   end
      display(ErrorVal);
      
    [fx, cx]=size(x);
    z=linspace(-2,2,c);
    fprintf('GraficaE fila %i col %i', fil, col);
    fprintf('X fila %i col %i', fx, cx);
       figure
     subplot(2,1,1)
     plot(x,GraficaE, 'o:k', y,Eprueba, 'o:b','markersize',8);     
     title('Errores')
     legend('Error ent y val', 'Error prueba');   
     xlabel('Número de iteraciones')
     ylabel('Valor del error')   
     subplot(2,1,2)
     plot(z,target, 'o k',z,a_total,'o r');
     legend('Señal Real', 'Señal obtenida');   
     title('Resultados')


   
 
end