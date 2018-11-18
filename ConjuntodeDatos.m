function [Mvalidacion, Maprendizaje, Mprueba]=ConjuntodeDatos(mux,fil, data)
matrizAUX=data;
[filas, columnas]=size(data);
k=1;
i=1;
x=fil/10;
aux=x;

  if mux==1 
        conjA=fil*0.7;
        conjAUX=fil*0.3;
        %fprintf('\n 70) D1: %f  D2: %f ', conjA, conjAUX);
        
            if(conjA>uint64(conjA)+0.5)
                conjA=uint64(conjA)+1;
            else
                conjA=uint64(conjA);
            end
        
            if(conjAUX>uint64(conjAUX)+0.5)
                conjAUX=uint64(conjAUX)+1;
            else
                conjAUX=uint64(conjAUX);
            end
       conjB=conjAUX/2;
       conjC=conjB;
       fprintf('Aprendizaje: %i  Validación: %i Prueba: %i', conjA, conjB, conjC);
       
        while i<11
            m(:,i)=Random(k,x-1,(conjA/10));
            k=x;
            x=aux+x;
            i=i+1;
        end

[u, v]= size(m);
 i=1;
 j=1; 
 k=1;
 l=1;
       for l=1:v
            for j=1:u
                  Maprendizaje(i,:)=data(m(j,l),:);
                  data(m(j,l),:)=11111; 
                  i=i+1;
            end
       end    
         for p=1:filas           
              if data(p,:)~=11111
               matrix(k,:)=data(p,:);
               k=k+1;
              end
         end 
   
f=1;
g=1;

[fil, col]= size(matrix);

          for p=1:fil          
              if rem(p,2)==0
                Mvalidacion(f,:)=matrix(p,:); 
                f=f+1;
              else
                Mprueba(g,:)=matrix(p,:);
                g=g+1;
              end
          end 
         
  
  else 
        conjA=fil*(0.8);
        conjAUX=fil*0.2; 
       
        %fprintf('\n 80) D1: %f  D2: %f ', conjA, conjAUX);    
            if conjA>(uint64(conjA)+0.5)
                conjA=uint64(conjA)+1;
                display(conjA);
            else
                conjA=uint64(conjA);
                
            end
        
            if conjAUX>(uint64(conjAUX)+0.5)
                conjAUX=uint64(conjAUX)+1;
            else
                conjAUX=uint64(conjAUX);
            end

        conjB=conjAUX/2;
        conjC=conjB;
    
        fprintf('Aprendizaje: %i  Validación: %i Prueba: %i', conjA, conjB, conjC);
       
        while i<11
            m(:,i)=Random(k,x-1,(conjA/10));
            k=x;
            x=aux+x;
            i=i+1;
        end

[u, v]= size(m);
 i=1;
 j=1; 
 k=1;
 l=1;
       for l=1:v
            for j=1:u
                  Maprendizaje(i,:)=data(m(j,l),:);
                  data(m(j,l),:)=11111; 
                  i=i+1;
            end
       end    
         for p=1:filas           
              if data(p,:)~=11111
               matrix(k,:)=data(p,:);
               k=k+1;
              end
         end 
   
f=1;
g=1;

[fil, col]= size(matrix);

          for p=1:fil          
              if rem(p,2)==0
                Mvalidacion(f,:)=matrix(p,:); 
                f=f+1;
              else
                Mprueba(g,:)=matrix(p,:);
                g=g+1;
              end
         end 
    
  end 

end