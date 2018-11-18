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
    
%     fprintf('MATRIZ A %i',i);  
%     display(a{i}(:,:));
%     
%     fprintf('MATRIZ F %i',i);  
%     display(F{i}(:,:));
   
    if i==Capas
        S{i}=(-2)*auxerror*F{i};
    else   
        S{i}=F{i}*W{i+1}'*S{i+1};
    end
%      fprintf('MATRIZ S %i', i);  
%      display(S{i}(:,:));
    i=i-1;
end


S=S;
end