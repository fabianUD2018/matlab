%Fabian Camilo Herrera Ramirez%
%Codigo: 20141020035
%%Algoritmo genetico con la mutacion echa en decimal
clear all;
close all;
numDesX= randi([1 255],1,100);
numDesY= randi([1 255],1,100);
%%pob= randi([0 255],100,2);
syms x y
fOb(x, y)= 400*sqrt((x-5)^2 +(y-10)^2) +300*sqrt((x-10)^2 +(y-5)^2)+400*sqrt((x)^2 +(y-12)^2)+600*sqrt((x-12)^2 +(y)^2);
for iteracion=1: 20000
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
    if desviacion<=900
    break;
    end
    
fitness=[];
for i=1:100
fitness(i)=1/(1+valZ(i));
end
%suma fitness
sumaF=0;
for i=1:100
sumaF=fitness(i)+sumaF;

end


%probabilidad de cada elemtno der la pobn
proE=[];
for i=1:100
proE(i)=fitness(i)/sumaF;
end
sumaProE=[];
sumaProE(1)=proE(1);
for i=2:100
sumaProE(i)=proE(i)+sumaProE(i-1);
end

%aleatorios entre 0 y 1
R=genAL();

%%sigue hacer la nueva poblacion antes del cruce
nuevaX= nuevaPX(numDesX, R, sumaProE);
nuevaY= nuevaPY(numDesY, R, sumaProE);
%probabilidad de crice
pc= 0.25;
%probabilidad de mutacion
pm=0.1;
%%paso 4 nueva generacion de aleatoriios
r= genAL();

padres=seleccionPadres(r, pc);
cantP=length(padres);
 bNuevaX= binario(nuevaX);
 bNuevaY= binario(nuevaY);
%%generar aleatorio para los cruces
alCruces= randi([1 15],1,cantP);

pobC=cruzar(padres, cantP, bNuevaX, bNuevaY, alCruces);
 
%%nueva poblacion despues cruce

bNuevaY2= reemplazarPorHijosY(padres, cantP, bNuevaY, pobC);
 bNuevaX2= reemplazarPorHijosX(padres, cantP, bNuevaX, pobC);

%total genes
tG= 100*2;
mutaciones= tG*0.1;
%%alestorios entre 1 y 200 numero genes
alG=randi([1 200],1,mutaciones);

%%aleatorios entre 0 y 255 para reemplazar los genes
alR=randi([1 255],1,mutaciones);

decNuevaX2=bi2de(bNuevaX2);
decNuevaY2=bi2de(bNuevaY2);
matrizDec= horzcat(decNuevaX2,decNuevaY2);

for i=1: mutaciones
matrizDec=reemplazar(matrizDec,alG(i), alR (i));
end

matrizDec=matrizDec';

numDesX= matrizDec(1,:);
numDesY= matrizDec(2,:);
end
[Y,I] = min(valZ);
 x=min(numAcX(I))
 y=min(numAcY(I))
 
400*sqrt((x-5)^2 +(y-10)^2) +300*sqrt((x-10)^2 +(y-5)^2)+400*sqrt((x)^2 +(y-12)^2)+600*sqrt((x-12)^2 +(y)^2)


%%%%%%%%%INICIO DE FUNCIONES MATLA000B%%%%%%%%%%%%%%


function arr=nuevaPX(arrX, arrNA, arrSP)
copiaArrX=arrX;
    for i=1: 100
        param= arrNA(i);
        
        for j=1: 100
             
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
function res= reemplazar(matriz, alGen, alRemp)
cont=1;
for i=1:200
    for j=1:2
        if cont==alGen
            matriz(i, j)= alRemp;
            res=matriz;   

        end
        cont=cont+1;
    
    end

end

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

tempP=cantP;
if mod(tempP,2)==0
    tempP=tempP-1;
end
for i = 1: tempP
bPob(padres(i),:)=pC(i, 9:16);
end
res=bPob;
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
          acum=acum+ 2^(8-j)*matriz(i,j);
        end
        numDesX(i)=acum*12/255;
        acum=0;
    end
end

%%seleccionde padres
function p=seleccionPadres(random, pc)
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

%convertir a binarios
function res= binario(arr)
res=de2bi(arr);
end

%%evaluar z
function res=evaluarZ(arrX,arrY)
syms x y
    fOb(x, y)= 400*sqrt((x-5)^2 +(y-10)^2) +300*sqrt((x-10)^2 +(y-5)^2)+400*sqrt((x)^2 +(y-12)^2)+600*sqrt((x-12)^2 +(y)^2);
    for i=1:100
        res(i)= fOb(arrX(i), arrY(i));
    end
end