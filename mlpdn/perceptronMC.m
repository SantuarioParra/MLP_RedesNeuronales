fprintf('El famosisimo perceptrón multicapa');
%tamaños de la matriz input y targets
sx1=30;
sy1=1;
%obteniendo el total de los datos
totalDatos=sx1;
%Rango de la señallll
rangoInferior=input('limite inferior del rango\n');
rangoSuperior=input('limite superior del rango\n');
v1=input('vector 1 de la arquitectura\n');
v2=input('vector 2 de la arquitectura\n');
%1->purelin
%2->logsig
%3->tansig
p=zeros(v1(1,1),1);
cC=size(v1);
cC=cC(1,2);
%disp(cC);
switch cC
    case 2
        capa1=zeros(v1(1,1),v1(1,2));
        b1=zeros(v1(1,2),1);
        red=cell(1,1);
        red{1}=capa1;
        %disp(red);
        bias=cell(1,1);
        bias{1}=b1;
    case 3
        capa1=zeros(v1(1,1),v1(1,2));
        b1=zeros(v1(1,2),1);
        capa2=zeros(v1(1,2),v1(1,3));
        b2=zeros(v1(1,3),1);
        red=cell(2,1);
        red{1}=capa1;
        red{2}=capa2;
        %disp(red);
        bias=cell(2,1);
        bias{1}=b1;
        bias{2}=b2;
        %disp(bias);
    case 4
        capa1=zeros(v1(1,1),v1(1,2));
        b1=zeros(v1(1,2),1);
        capa2=zeros(v1(1,2),v1(1,3));
        b2=zeros(v1(1,3),1);
        capa3=zeros(v1(1,3),v1(1,4));
        b3=zeros(v1(1,4),1);
        red=cell(3,1);
        red{1}=capa1;
        red{2}=capa2;
        red{3}=capa3;
        %disp(red);
        bias=cell(3,1);
        bias{1}=b1;
        bias{2}=b2;
        bias{3}=b3;
        %disp(bias);
    otherwise
        fprintf('No soportado');
end
%obtenemos el tamaño de nuetra red
tamRi=size(red);
tamR=tamRi(1,1);
%Valor de error aceptable para considerar aprendizaje exitoso
error_epoch_train=input('Dame el valor aceptable del error(error_epoch_train)');
%valor del factor de aprendizaje
fa=input('valor del factor de aprendizaje\n');
%Número máximo de épocas
epochMax=input('Número máximo de épocas\n');
%Cada cuantas iteraciones se llevará a cabo una época de validación
epoch_val=input('Épocas de validación\n');
%Número máximo de incrementos consecutivos del error_epoch_validation
num_val=input('Número máximo de incrementos consecutivos del error_epoch_validation\n');
%División del dataset en 3 conjuntos
%Elección de configuración de perceptron
TdD=input('1)80\% 10\% 10\% y 2)70\% 15\% 15\%');
tamCE=0;
tamCV=0;
tamCP=0;
switch TdD
    case 1
        
        separador=1;
        idiE=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\iCE.txt','w');
        idiV=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\iCV.txt','w');
        idiP=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\iCP.txt','w');
        idtE=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\tCE.txt','w');
        idtV=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\tCV.txt','w');
        idtP=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\tCP.txt','w');
        intervalo=(rangoSuperior-rangoInferior)/2000;
        p=rangoInferior+intervalo;
        
        while p<rangoSuperior
            gdp=1+sin(((6*pi)/4)*p);
            switch separador
                case 4
                    fprintf(idiV,'%f\r\n',p);
                    fprintf(idtV,'%f\r\n',gdp);
                    tamCV=tamCV+1;
                case 7
                    fprintf(idiP,'%f\r\n',p);
                    fprintf(idtP,'%f\r\n',gdp);
                    tamCP=tamCP+1;
                case 10
                    fprintf(idiE,'%f\r\n',p);
                    fprintf(idtE,'%f\r\n',gdp);
                    separador=0;
                    tamCE=tamCE+1;
                otherwise
                    fprintf(idiE,'%f\r\n',p);
                    fprintf(idtE,'%f\r\n',gdp);
                    tamCE=tamCE+1;
            end
            p=p+intervalo;
            separador=separador+1;
        end
        %
        fclose(idiE);
        fclose(idiV);
        fclose(idiP);
        fclose(idtE);
        fclose(idtV);
        fclose(idtP);
    case 2
        %
        separador=1;
        idiE=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\iCE.txt','w');
        idiV=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\iCV.txt','w');
        idiP=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\iCP.txt','w');
        idtE=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\tCE.txt','w');
        idtV=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\tCV.txt','w');
        idtP=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\tCP.txt','w');
        intervalo=(rangoSuperior-rangoInferior)/200;
        p=rangoInferior+intervalo;
        while p<rangoSuperior
            gdp=1+sin(((6*pi)/4)*p);
            switch separador
                case {3,9,15}
                    fprintf(idiV,'%f\r\n',p);
                    fprintf(idtV,'%f\r\n',gdp);
                    tamCV=tamCV+1;
                case {6,12,18}
                    fprintf(idiP,'%f\r\n',p);
                    fprintf(idtP,'%f\r\n',gdp);
                    tamCP=tamCP+1;
                case 20
                    fprintf(idiE,'%f\r\n',p);
                    fprintf(idtE,'%f\r\n',gdp);
                    separador=0;
                    tamCE=tamCE+1;
                otherwise
                    fprintf(idiE,'%f\t',p);
                    fprintf(idtE,'%f\r\n',gdp);
                    
            end
            
            p=p+intervalo;
            separador=separador+1;
        end
        %
        fclose(idiE);
        fclose(idiV);
        fclose(idiP);
        fclose(idtE);
        fclose(idtV);
        fclose(idtP);
    otherwise
        fprintf('Opción incorrecta');
end

%Se inicializan los valores de los parámetros entre -1 y 1 forma aleatoria
%para los pesos
for vap=1:tamR
%cada uno de las capas de la red
    capAux=red{vap,1};
    tmanio=size(capAux);
    %fprintf('tmanio:');
    %disp(tmanio);
    for i=1:tmanio(1,1)
        for j=1:tmanio(1,2)
            capAux(i,j)=2.*rand()-1;
        end
    end
    red{vap,1}=capAux;
    %disp(red{vap,1});
end
%para los bias
for vap=1:tamR
%cada uno de las capas de la red
    capAux=bias{vap,1};
    tmanio=size(capAux);
    %fprintf('tmanio:');
    %disp(tmanio);
    for i=1:tmanio(1,1)
        for j=1:tmanio(1,2)
            capAux(i,j)=2.*rand()-1;
        end
    end
    bias{vap,1}=capAux;
    %disp(bias{vap,1});
end
%%%%%%%conjunto de entrenamiento
fileIDce = fopen('iCE.txt','r');
formatSpecce='%f';
size1=[tamCE,1];
ce=fscanf(fileIDce,formatSpecce,size1);
%disp(ce);
fclose(fileIDce);
%%%
fileIDte = fopen('tCE.txt','r');
formatSpecce='%f';
size1=[tamCE,1];
te=fscanf(fileIDte,formatSpecce,size1);
%fprintf('te\n');
%disp(te);
fclose(fileIDce);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%conjunto de validacion
fileIDcv = fopen('iCV.txt','r');
formatSpecce='%f';
size1=[tamCV,1];
cv=fscanf(fileIDcv,formatSpecce,size1);
%disp(ce);
fclose(fileIDcv);
%%%
fileIDtv = fopen('tCV.txt','r');
formatSpecce='%f';
size1=[tamCV,1];
tv=fscanf(fileIDce,formatSpecce,size1);
%fprintf('te\n');
%disp(te);
fclose(fileIDce);

%%%% while para el aprendizaje



contadorEpoch=1;
n_v=0;
e_v=0;
errorDeValidacion=1000;
while contadorEpoch<=epochMax && n_v<num_val && errorDeValidacion>error_epoch_train
    modulito=mod(contadorEpoch,epoch_val);
    errorDeValidacion=0;
    if modulito==0
        fprintf('epoca de validacion');
        for iv=1:tamCV
            pdv=cv(iv,1);
            vectorAPropagar=pdv;
            %%%
            for c=1:tamR
                %fprintf('voy a entrar al switch:\n');
      
                switch v2(1,c)
                    case 1
                        %fprintf('este es vector a propagar:\n');
                     %   disp(vectorAPropagar);
                      %  fprintf('este es red:\n');
                      %  disp(red{c,1});
                     %   fprintf('este es bias:\n');
                      %  disp(bias{c,1});
                        vectorAPropagar=purelin(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                        %break
                    case 2       
                     %   fprintf('este es vector a propagar:\n');
                     %   disp(vectorAPropagar);
                     %   fprintf('este es red:\n');
                     %   disp(red{c,1});
                     %   fprintf('este es bias:\n');
                     %   disp(bias{c,1});
                        vectorAPropagar=logsig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                        %break
                    case 3
                     %   fprintf('este es vector a propagar:\n');
                     %   disp(vectorAPropagar);
                      %  fprintf('este es red:\n');
                      %  disp(red{c,1});
                      %  fprintf('este es bias:\n');
                      %  disp(bias{c,1});
                        vectorAPropagar=tansig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                        %break
                end
                
            end
            errorU=tv(tcv,1)-vectorAPropagar;
            %%%
            errorDevalidacion=errorDevalidacion+abs(errorU);
        end 
        errorDevalidacion=errorDevalidacion/tcv;
        if e_v<rphd
                n_v=n_v+1;
        else
                n_v=0;
        end
    else
for ie=1:tamCE
    an=cell(1,tamR);
    p=ce(ie,1);
    vectorAPropagar=p;
    %propagación hacia adelante
    %fprintf('Propagación hacia adelante');
    %disp(tamR);
    %fprintf('wdf');
    %disp(size(v2));
    %fprintf('este es p:\n');
    %disp(p);
    for c=1:tamR
          %fprintf('voy a entrar al switch:\n');

        switch v2(1,c)
            case 1
                %fprintf('este es vector a propagar:\n');
               %disp(vectorAPropagar);
                %fprintf('este es red:\n');
                %disp(red{c,1});
                %fprintf('este es bias:\n');
                %disp(bias{c,1});
                vectorAPropagar=purelin(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                %break
            case 2       
                %fprintf('este es vector a propagar:\n');
                %disp(vectorAPropagar);
                %fprintf('este es red:\n');
                %disp(red{c,1});
                %fprintf('este es bias:\n');
                %disp(bias{c,1});
                vectorAPropagar=logsig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                %break
            case 3
                %fprintf('este es vector a propagar:\n');
                %disp(vectorAPropagar);
                %fprintf('este es red:\n');
                %disp(red{c,1});
                %fprintf('este es bias:\n');
                %disp(bias{c,1});
                vectorAPropagar=tansig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                %break
        end

        an{1,c}=vectorAPropagar;
        %fprintf('este es an:\n');
        %disp(an{1,c});

    end
%fprintf('Este es an:\n');
%disp(an);
%fprintf('tam de an ');
%disp(size(an));
a=vectorAPropagar;
t=te(ie,1);
%aprendizaje
%calcular F[N]s

 fNS=cell(tamR,1);
 contador=1;
 %fprintf('voy a entrar al for de las fns');
 for c=tamR:-1:1
     switch v2(1,c)
         case 1
             FMnM=zeros(v1(1,c+1),v1(1,c+1));
             for i=1:v1(1,c+1)
                 for j=1:v1(1,c+1)
                     if i==j
                         FMnM(i,j)=1;
                     end
                 end    
             end
         case 2
             FMnM=zeros(v1(1,c+1),v1(1,c+1));
             for i=1:v1(1,c+1)
                 for j=1:v1(1,c+1)
                     if i==j
                         %fprintf('dfewedweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                         aux=an{1,c};
                         %disp(aux);
                        FMnM(i,j)=1-aux(1,i).^2;
                     end
                 end    
             end
         case 3
             FMnM=zeros(v1(1,c+1),v1(1,c+1));
             for i=1:v1(1,c+1)
                 for j=1:v1(1,c+1)
                     if i==j
                         %fprintf('dfewedweeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
                         aux=an{1,c};
                         %disp(aux);
                         FMnM(i,j)=aux(1,i)*(1-aux(1,i));
                     end
                 end    
             end
         otherwise
             fprintf('Algo malo esta pasando');
     end
     fNS{c,1}=FMnM;
     %fprintf('fnS es :\n');
     %disp(fNS{c,1});
 end
 %calculando sensitividades
 sensitividades=cell(tamR,1);
 for sen=tamR:-1:1
     if sen==tamR
         %fprintf('pseeeeeeeeeeeeeeeeeeeeee:t\n');
         %disp(t);
         %fprintf('a\n');
         %disp(a);
         %fprintf('fns\n');
         %disp(fNS{sen,1});
         sensitividades{sen,1}=-2*fNS{sen,1}*(t-a);
         %fprintf('ps:\n');
         %disp(sensitividades{sen,1});
     else
         %fprintf('tamaño de fns:\n');
         %disp(size(fNS{sen,1}));
         %disp(fNS{sen,1});
         %fprintf('tamaño de red:\n');
         %disp(size(red{sen+1,1}));
         %disp(red{sen+1,1});
         %fprintf('tamaño de sencitividades:\n');
         %disp(size(sensitividades{sen+1,1}));
         sensitividades{sen,1}=fNS{sen,1}*red{sen+1,1}*sensitividades{sen+1,1};
 
    end
 end
 %ajuste de pesos
 for ap=tamR:-1:1
     if ap==1
         ra=transpose(fa*sensitividades{ap,1}*p);
        tam=size(red{ap,1});
        for i=1:tam
            red{ap,1}(i,1)=red{ap,1}(i,1)-ra(i,1);
        end
        rb=transpose(fa*sensitividades{ap,1});
        tam=size(red{ap,1});
        for i=1:tam
            bias{ap,1}(i,1)=bias{ap,1}(i,1)-rb(1,i);
        end
     else
        ra=transpose(fa*sensitividades{ap,1}*an{1,ap-1});
        %disp(size(ra));
        %disp(size(red{ap,1}));
        tam=size(red{ap,1});
        for i=1:tam
            red{ap,1}(i,1)=red{ap,1}(i,1)-ra(i,1);
        end
        rb=transpose(fa*sensitividades{ap,1});
        tam=size(bias{ap,1});
        
        for i=1:tam
            %fprintf('tamaaaaaaaaaaaaaaaaaaaa:\n');
            %disp(size(rb));
        %disp(size(bias{ap,1}));
            bias{ap,1}(i,1)=bias{ap,1}(i,1)-rb(1,i);
        end
     end
 end     
end
    end
contadorEpoch=contadorEpoch+1;
end
%validación de resultados
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%conjunto de pruebas
fileIDcp = fopen('iCP.txt','r');
formatSpecce='%f';
size1=[tamCP,1];
cp=fscanf(fileIDcp,formatSpecce,size1);
%disp(ce);
fclose(fileIDcp);
%%%
fileIDtp = fopen('tCP.txt','r');
formatSpecce='%f';
size1=[tamCP,1];
tp=fscanf(fileIDtp,formatSpecce,size1);
%fprintf('tp\n');
%disp(te);
fclose(fileIDce);

%propago hacia adelante
    errorDePrueba=0;
    idRes=fopen('C:\Users\aleja\OneDrive\Documentos\ericMatLab\resultados.txt','w');
    for iv=1:tamCP
            pdc=cp(iv,1);
            vectorAPropagar=pdc;
            %%%
            for c=1:tamR
                %fprintf('voy a entrar al switch:\n');
      
                switch v2(1,c)
                    case 1
                        %fprintf('este es vector a propagar:\n');
                        %disp(vectorAPropagar);
                        %fprintf('este es red:\n');
                        %disp(red{c,1});
                        %fprintf('este es bias:\n');
                        %disp(bias{c,1});
                        vectorAPropagar=purelin(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                        %break
                    case 2       
                        %fprintf('este es vector a propagar:\n');
                        %disp(vectorAPropagar);
                        %fprintf('este es red:\n');
                        %disp(red{c,1});
                        %fprintf('este es bias:\n');
                        %disp(bias{c,1});
                        vectorAPropagar=logsig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));%+bias{c,1}
                        %break
                    case 3
                        %fprintf('este es vector a propagar:\n');
                        %disp(vectorAPropagar);
                        %fprintf('este es red:\n');
                        %disp(red{c,1});
                        %fprintf('este es bias:\n');
                        %disp(bias{c,1});
                        vectorAPropagar=tansig(vectorAPropagar*red{c,1}+transpose(bias{c,1}));
                        %break
                end
                
            end
            fprintf(idRes,'%f\r\n',vectorAPropagar);
            errorU=tv(iv,1)-vectorAPropagar;
            %%%
            errorDePrueba=errorDePrueba+abs(errorU);
    end
    %%%%%%
    fclose(idRes);
    fileIDRes = fopen('resultados.txt','r');
    formatSpecce='%f';
    size1=[tamCP,1];
    resultados=fscanf(fileIDRes,formatSpecce,size1);
    %fprintf('te\n');
    %disp(te);
    fclose(fileIDRes);
    %%%%%plotear los resultadoS
    %disp(size(cp));
    %disp(size(tp));
     hold on;
    %disp(size(cp));
    disp(resultados);
    plot(cp,tp,'+');
    plot(cp,resultados,'o');
