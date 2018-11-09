%Fabian Camilo Herrera Ramirez%
%Codigo: 20141020035
%%Algoritmo genetico con la mutacion echa en binario
close all;
clear all;
numDesX= randi([1 255],1,100);
numDesY= randi([1 255],1,100);

%total genes
tG= 100*16;
mutaciones= tG*0.1;

syms x y
fOb(x, y)= 400*sqrt((x-5)^2 +(y-10)^2) +300*sqrt((x-10)^2 +(y-5)^2)+400*sqrt((x)^2 +(y-12)^2)+600*sqrt((x-12)^2 +(y)^2);
for iter=1: 20000
    
xBin=de2bi(numDesX);

yBin=de2bi(numDesY);
    
    %numeros ya acotasdos
    numAcX=fAcota(xBin);
    numAcY=fAcota(yBin );

    %%evaluacion de funcion objetivo
    valZ=[];
    
    for i=1:100
        valZ(i)=400*sqrt((numAcX(i)-5)^2 +(numAcY(i)-10)^2) +300*sqrt((numAcX(i)-10)^2 +(numAcY(i)-5)^2)+400*sqrt((numAcX(i))^2 +(numAcY(i)-12)^2)+600*sqrt((numAcX(i)-12)^2 +(numAcY(i))^2);
    end
    
    desviacion=std(valZ,1)
    if desviacion<=1200
    break;
    end
    
 
    
    % fitness
    fitness=[];
    for i=1:100
        fitness(i)=1/(1+valZ(i));
    end
    
    sumaF=sum(fitness);
    %probabilidad de cada elemtno der la pobn
    proE=[];
    proE= fitness/sumaF;
    
    %probSumas
    sumaProE=[];
    acum=0;
    for i=1:100
        acum=proE(i)+acum;
        sumaProE(i)=acum;
    end
    
    %aleatorios entre 0 y 1
    R=genAL();

    %%sigue hacer la nueva poblacion antes del cruce
    nuevaX= nuevaPX(xBin, R, sumaProE);
    
    nuevaY= nuevaPY(yBin, R, sumaProE);
    %probabilidad de crice
    pc= 0.25;
    %probabilidad de mutacion
    pm=0.1;
    %%paso 4 nueva generacion de aleatoriios
    r= genAL();
    
    padres=seleccionPadres(r, pc);
    
    cantP=length(padres);
    

    %%generar aleatorio para los cruces
    alCruces= randi([1 15],1,cantP);
    
    pobC=cruzar(padres, cantP, nuevaX, nuevaY, alCruces);
    
    %%nueva poblacion despues cruce
    
    bNuevaY2= reemplazarPorHijosY(padres, cantP, nuevaY, pobC);
    bNuevaX2= reemplazarPorHijosX(padres, cantP, nuevaX, pobC);
    
    %%alestorios entre
    alG=randi([1 1600],1,mutaciones);
    
    
    %%aleatorios entre 0 y 1
    alR=randi([0 1],1,mutaciones);
    
    binMatriz=horzcat(bNuevaX2,bNuevaY2);
    
    binMatriz=reemplazar(binMatriz,alG, alR );

    
    
    numDesX=bi2de(binMatriz(:,1:8));
    numDesY=bi2de(binMatriz(:,9:16));
 
end
[Y,I] = min(valZ);
 x=min(numAcX(I))
 y=min(numAcY(I))
 
400*sqrt((x-5)^2 +(y-10)^2) +300*sqrt((x-10)^2 +(y-5)^2)+400*sqrt((x)^2 +(y-12)^2)+600*sqrt((x-12)^2 +(y)^2)

%%%%%%%%%INICIO DE FUNCIONES MATLAB%%%%%%%%%%%%%%

function arr=nuevaPX(arrX, arrNA, arrSP)
copiaArrX=arrX;
    for i=1: 6
        param= arrNA(i);
        
        for j=1: 6
             
             num=arrSP(j);
             
            if num>=param
                arrX(i)=copiaArrX(j);
                break;
            end
        end
    end
    
   arr=arrX;
 
end
function arr=nuevaPY(arrY, arrNA, arrSP)
copiaArrY=arrY;    
for i=1: 100
        param= arrNA(i);
        for j=1: 100
            if arrSP(j)>=param
                arrY(i)=copiaArrY(j);
                break;
            end
        end
    end
    
   arr= arrY;
 
end

%%reemplazar mutaciones%%
function res= reemplazar(mat, alGen, alRemp)
mat=mat';
cont=1;
% for i=1:100
%     for j=1:16
%         if cont==alGen
%             
%             if matriz(i,j)==0
%             matriz(i,j)=1;
%             else
%                 matriz(i,j)=0;
%             end
%             break;
%         end
%         cont=cont+1;
%     
%     end
% 
%%end
for k=1:length(alGen)
mat(alGen(k))=alRemp(k);
end
res=mat';
end


%%reemplazar para nueva poblacion despues de cruce
function res = reemplazarPorHijosX(padres, cantP, b, pC)
if mod(cantP,2)==0
    cantP=cantP-1;
end
for i = 1: cantP
   
b(padres(i),:)=pC(i, 1:8);
end
res=b;
end

function res = reemplazarPorHijosY(padres, cantP, bPob, pC)
poblacion=bPob;
tempP=cantP;
if mod(tempP,2)==0
    tempP=tempP-1;
end
for i = 1: tempP
poblacion(padres(i),:)=pC(i, 9:16);
end
res=poblacion;
end


%%hacer cruce
 function res = cruzar(padres, cantP,  binX, binY, aleatorio)

 if mod(cantP,2)==0
        
     for i=1 : cantP-1
        p1= horzcat(binX(padres(i),:), binY(padres(i),:));
        p2= horzcat(binX(padres(i+1),:), binY(padres(i+1),:));
        cont=16;
    
        for j=1: aleatorio(i)
        p2(cont)=p1(cont);
        cont=cont-1;
        
        end
                
             res(i,:)= p2;
             
     end
 else
   
for i=1 : cantP
        
        if i==cantP
        p1= horzcat(binX(padres(i),:), binY(padres(i),:))    ;
            p2= horzcat(binX(padres(1),:), binY(padres(1),:));
        else
            p1= horzcat(binX(padres(i),:), binY(padres(i),:));
            p2= horzcat(binX(padres(i+1),:), binY(padres(i+1),:));
        end
           cont=16;
 
        for j=1: aleatorio(i)
            
        p2(cont)=p1(cont);
        cont=cont -1;
        end
        
        res(i,:)= p2;
   
     end
    
end

 end
 
%paso por la funcin rara que acota menor a 12
function numDesX=fAcota(matriz)
%     acum=0;
%     for i=1:100
%         for j=1:8
%           acum=acum+ 2^(j-1)*matriz(i,j)*12/255 ;
%         end
%         numDesX(i)=acum;
%         acum=0;
%     end
    acum=0;
    numDes=[];
    for i=1:100
        for j=1:8
          acum=acum+ 2^(8-j)*matriz(i,j) ;
        end
        numDesX(i)=acum*12/255;
        acum=0;
    end
end

%%seleccionde padres
function p=seleccionPadres(random, pc)
p=[];
acum=1;
    for i=1: 100
        if random(i)<pc
        p(acum)=i;
        acum=acum+1;
        end
    end
end


%%generar alñeatorio
function r= genAL()
%aleatorios entre 0 y 1
for i=1:100
r(i)=rand;
end

end
