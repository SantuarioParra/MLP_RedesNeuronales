function [Wnew, BIASnew]=BackPropagation(a, W, bias, auxerror, RNA, FUNACT, alpha, entrenamiento)

%fprintf('\n Se hizo BackPropagation');
Capas=length(RNA)-1;
k=Capas;
S=Sensitividades(a, RNA, FUNACT, auxerror,W);

    while(k>0)
       
       %%%%%%%%%%%%%%%%% MOSTRAR MATRIZ ANTERIOR %%%%%%%%%%%%%%%%%%%%%%%%%%%
%         fprintf('\n -----------------------');
%       fprintf('VALORES ANTERIORES');
%       display(W{k}(:,:));
%       display(bias{k}(:,:));
%       
      
 
        bias{k}=bias{k}-alpha*S{k};
        
         if k-1==0
            W{k}= W{k}-alpha*S{k}*entrenamiento';
%             fprintf('\n ******************');
%         display(entrenamiento');
         else
            W{k}= W{k}-alpha*S{k}*a{k-1}';
%             fprintf('\n ******************');
%         display(a{k-1}(:,:)');
         end
        
       %%%%%%%%%%%%%%%%% MOSTRAR MATRIZ ACTUAL %%%%%%%%%%%%%%%%%%%%%%%%%%%
%       fprintf('NUEVOS VALORES');
%       display(W{k}(:,:));
%       display(bias{k}(:,:));  
          k=k-1;
    end
Wnew=W;
BIASnew=bias;
end