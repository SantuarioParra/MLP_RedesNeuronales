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
         [a, a_out]=Propagacion(W, bias, entrenamiento, RNA, FUNACT); %Propagación hacia adelante
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
