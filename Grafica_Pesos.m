function Grafica_Pesos(matriz, matriz_error, noW)
    fprintf('\n\n Número de Ws: %i', noW);
   % display(matriz_error);
    
    figure
    subplot(2,1,1)
    plot(matriz)
    
    if noW == 3
    legend('W1','W2', 'W3')
    elseif noW == 4
    legend('W1','W2', 'W3', 'W4')
    elseif noW == 5
    legend('W1','W2', 'W3', 'W4', 'W5');
    elseif noW == 6
    legend('W1','W2', 'W3', 'W4', 'W5','W6');
    end
    title('Comportamiento de W')
    xlabel('Número de veces que se aplicó el aprendizaje')
    ylabel('Valor en cada regla de aprendizaje')
    
    subplot(2,1,2)
    plot(matriz_error,'r')
    legend('error_tot');   
    title('Comportamiento del error en todas las iteraciones')
    xlabel('Número de veces que se calculo el error')
    ylabel('Valor en cada iteración')

end