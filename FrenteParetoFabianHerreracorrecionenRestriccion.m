%Fabian Camilo Herrera Ramirez%
%Codigo: 20141020035
%%Algoritmo para hacer el frente de pareto
close all;
clear all;
frente=[];

hold on

grid on
grid minor
xlabel("funcion 2")
ylabel("funcion 1")
xlim([1 400]) 

valZF1=zeros(1,100);
fitness=zeros(1,100);
res1=zeros(1,100);
res2=zeros(1,100);
proE=zeros(1,100);
sumaProE=zeros(1,100);
numDesX= randi([1 255],1,100);
numDesY= randi([1 255],1,100);
numDesZ= randi([1 255],1,100);


 
 

%total genes999
tG= 100*24;
%%mutaciones= tG*0.1;
mutaciones =24;
for iter=1: 5000
    iter
xBin=de2bi(numDesX);
yBin=de2bi(numDesY);    
zBin=de2bi(numDesZ);


%numeros ya acotasdos
 numAcX=fAcota(xBin, 100/4);
 numAcY=fAcota(yBin , 100/3);
 numAcZ=fAcota(zBin ,100/2);

    %%evaluacion de funcion objetivo
    %%valZF1=[];
    
    for i=1:100
        valZF1(i)=10*numAcX(i)+9*numAcY(i)+8*numAcZ(i);
    end
    %%restricciones
    
for i=1:100
    res1(i)= 4*numAcX(i)+3*numAcY(i)+2*numAcZ(i)-130;
    if res1(i) >0
        res1(i)=0;
    end
    res2(i)= 3*numAcX(i)+2*numAcY(i)+2*numAcZ(i)-100;
    if res2(i)>0
        res2(i)=0;
    end
end
    % fitness
    %%fitness=[];
    for i=1:100
        fitness(i)=10*numAcX(i)+9*numAcY(i)+8*numAcZ(i)- 130*(res1(i))^2-100*(res2(i))^2;
        if fitness(i)<0
            fitness(i)=0;
        end
    end
    
    sumaF=sum(fitness);
    %probabilidad de cada elemtno der la pobn
    %proE=[];
    proE= fitness/sumaF;
    
    %probSumas
    %sumaProE=[];
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
    nuevaZ= nuevaPZ(zBin, R, sumaProE);
    %probabilidad de crice
    pc= 0.25;
    %probabilidad de mutacion
    pm=0.1;
    %%paso 4 nueva generacion de aleatoriios
    r= genAL();
    
    padres=seleccionPadres(r, pc);
    
    cantP=length(padres);
    

    %%generar aleatorio para los cruces
    alCruces= randi([1 24],1,cantP);
    
    pobC=cruzar(padres, cantP, nuevaX, nuevaY, nuevaZ, alCruces);
    
    %%nueva poblacion despues cruce
    
    bNuevaY2= reemplazarPorHijosY(padres, cantP, nuevaY, pobC);
    bNuevaX2= reemplazarPorHijosX(padres, cantP, nuevaX, pobC);
    bNuevaZ2= reemplazarPorHijosZ(padres, cantP, nuevaZ, pobC);
    %% la nueva poblacion se muta despues de juntar ambas 
%     %%alestorios entre
%     alG=randi([1 2400],1,mutaciones);
%     
%     
%     %%aleatorios entre 0 y 1
%     alR=randi([0 1],1,mutaciones);
%     
  binMatriz=horzcat(bNuevaX2,bNuevaY2, bNuevaZ2);

  for fila=1: 50
    union(fila,:)= binMatriz(fila, :);
  end
%     
%     %%se hace la mutacion
%     
%     binMatriz=mutar(binMatriz,alG, alR );

    
    
%     numDesX=bi2de(binMatriz(:,1:8));
%     numDesY=bi2de(binMatriz(:,9:16));
%     numDesZ=bi2de(binMatriz(:,17:24));
    %% parte para la funcion de minimizacion

    %%evaluacion de funcion objetivo
    valZF2=[];
    
    for i=1:100
        valZF2(i)=10*numAcX(i)+6*numAcY(i)+3*numAcZ(i);
    end
    %%restricciones
    
for i=1:100
    res1F2(i)= 4*numAcX(i)+3*numAcY(i)+2*numAcZ(i)-130;
    if res1F2(i) <0
        res1F2(i)=0;
    end
    res2F2(i)= 3*numAcX(i)+2*numAcY(i)+2*numAcZ(i)-100;
    if res2F2(i)<0
        res2F2(i)=0;
    end
end
    % fitness
    fitnessF2=[];
    for i=1:100
        fitnessF2(i)=1/(1+10*numAcX(i)+6*numAcY(i)+3*numAcZ(i)- 10*(res1(i))^2-10*(res2(i))^2);
        if fitnessF2(i)<0
            fitnessF2(i)=0;
        end
    end
    
    sumaFF2=sum(fitnessF2);
    %probabilidad de cada elemtno der la pobn
    proEF2=[];
    proEF2= fitnessF2/sumaFF2;
    
    %probSumas
    sumaProEF2=[];
    acumF2=0;
    for i=1:100
        acumF2=proEF2(i)+acumF2;
        sumaProEF2(i)=acumF2;
    end
    
    %aleatorios entre 0 y 1
    RF2=genAL();

    %%sigue hacer la nueva poblacion antes del cruce
    nuevaXF2= nuevaPX(xBin, RF2, sumaProEF2);
    
    nuevaYF2= nuevaPY(yBin, RF2, sumaProEF2);
    nuevaZF2= nuevaPZ(zBin, RF2, sumaProEF2);
    %probabilidad de crice
    pc= 0.25;
    %probabilidad de mutacion
    pm=0.1;
    %%paso 4 nueva generacion de aleatoriios
    r= genAL();
    
    padresF2=seleccionPadres(r, pc);
    
    cantPF2=length(padresF2);
    

    %%generar aleatorio para los cruces
    alCruces= randi([1 24],1,cantPF2);
    
    pobCF2=cruzar(padresF2, cantPF2, nuevaXF2, nuevaYF2, nuevaZF2, alCruces);
    
    %%nueva poblacion despues cruce
    
    bNuevaY2F2= reemplazarPorHijosY(padresF2, cantPF2, nuevaYF2, pobCF2);
    bNuevaX2F2= reemplazarPorHijosX(padresF2, cantPF2, nuevaXF2, pobCF2);
    bNuevaZ2F2= reemplazarPorHijosZ(padresF2, cantPF2, nuevaZF2, pobCF2);
    %%las mutaciones van despues de juntar las dos poblaciones
    %%alestorios entre
    alGF2=randi([1 2400],1,mutaciones);
    
    
    %%aleatorios entre 0 y 1
    alRF2=randi([0 1],1,mutaciones);
%     
    binMatrizF2=horzcat(bNuevaX2F2,bNuevaY2F2, bNuevaZ2F2);
%     
%     binMatrizF2=mutar(binMatrizF2,alGF2, alRF2 );

  for fila=51: 100
    union(fila,:)= binMatrizF2(fila, :);
  end
    
      binMatrizF2=mutar(union,alGF2, alRF2 );
      
    numDesX=bi2de(binMatrizF2(:,1:8));
    numDesY=bi2de(binMatrizF2(:,9:16));
    numDesZ=bi2de(binMatrizF2(:,17:24));
    %%igualo las dos poblaciones

     
     
%     res=pareto(par);
optimo=opti(numAcX, numAcY, numAcZ, valZF1, valZF2);
optimo=vertcat(optimo, frente);
plot(  optimo(:,2),optimo(:,1), 'g.');
 
res= pareto(optimo);

 for i =1: length(res)
    frente(i,:)= optimo(res(i),:);

 end 
 frente= unique(frente(:,1:5),'rows');
 %%si quiere ver cada iteracion del frente de pareto
 %%plot(  frente(:,2),frente(:,1), 'b.-' ,'MarkerSize', 10, 'LineWidth',1);
 

    
end
%  plot( frente(:,2), frente(:,1),'o');
 plot(  frente(:,2),frente(:,1), 'r.-', 'MarkerSize', 10, 'LineWidth',2);
 
 
[max,I] = max(frente(:, 1));
min=frente(I,2)
  x=frente(I,3)
  y=frente(I, 4)
  z=frente(I, 5)





% [Y,I] = min(valZF2);
%  x=numAcX(I)
%  y=numAcY(I)
%  z=numAcZ(I)
%  
valZF2222=10*x+6*y+3*z
% 3*x+2*y+2*z

%% optimos
function res=opti(x, y, z,valZF1, valZF2)
cont=1;
for i =1:100
    res1=4*x(i)+3*y(i)+2*z(i);
    res2=3*x(i)+2*y(i)+2*z(i);
  if res1<130 && res2<100
  rst(cont)=i;
  cont=cont+1;
  end

end
optimos=[];
for i =1:cont-1
  
    optimos(i,:)=[valZF1(rst(i))  valZF2(rst(i)) x(rst(i)) y(rst(i)) z(rst(i))];
%     opX(i)=numAcX(rst(i));
%     opY(i)=numAcY(rst(i));
%     opZ(i)=numAcZ(rst(i));
end
res=optimos;
end


%% Funcion de pareto 
function res=pareto(m)
res=[];
pert=[];

    for i=1: length(m)
        b=1;
    temp= m(i,:);
        for h=1: length(m)
            if m(h,1) >temp(1)
                if  m(h,2) <temp(2) 
              
                    res(length(res)+1)=i;
                    b=0;
                    break;
                end
            
            end
        end
        if b==1
            pert(length(pert)+1)=i;
        end

    end
    res=pert;
end


%% 

%%%%%%%%%INICIO DE FUNCIONES MATLAB%%%%%%%%%%%%%%
function arr=nuevaPZ(arrZ, arrNA, arrSP)
copiaArrZ=arrZ;    
for i=1: 100
        param= arrNA(i);
        for j=1: 100
            if arrSP(j)>=param
                arrZ(i)=copiaArrZ(j);
                break;
            end
        end
    end
    
   arr= arrZ;
 
end


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
function res= mutar(mat, alGen, alRemp)
mat=mat';
cont=1;
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
function res = reemplazarPorHijosY(padres, cantP, b, pC)
if mod(cantP,2)==0
    cantP=cantP-1;
end
for i = 1: cantP
   
b(padres(i),:)=pC(i, 9:16);
end
res=b;
end

function res = reemplazarPorHijosZ(padres, cantP, b, pC)
% poblacion=bPob;
% tempP=cantP;
% if mod(tempP,2)==0
%     tempP=tempP-1;
% end
% for i = 1: tempP
% poblacion(padres(i),:)=pC(i, 17:24);
% end
% res=poblacion;
if mod(cantP,2)==0
    cantP=cantP-1;
end
for i = 1: cantP
   
b(padres(i),:)=pC(i, 17:24);
end
res=b;
end


%%hacer cruce
 function res = cruzar(padres, cantP,  binX, binY, binZ, aleatorio)

 if mod(cantP,2)==0
        
     for i=1 : cantP-1
        p1= horzcat(binX(padres(i),:), binY(padres(i),:),binZ(padres(i),:) );
        p2= horzcat(binX(padres(i+1),:), binY(padres(i+1),:), binZ(padres(i+1),:));
        cont=24;
    
        for j=1: aleatorio(i)
        p2(cont)=p1(cont);
        cont=cont-1;
        
        end
                
             res(i,:)= p2;
             
     end
 else
   
for i=1 : cantP
        
        if i==cantP
        p1= horzcat(binX(padres(i),:), binY(padres(i),:), binZ(padres(i),:))    ;
            p2= horzcat(binX(padres(1),:), binY(padres(1),:), binZ(padres(1),:));
        else
            p1= horzcat(binX(padres(i),:), binY(padres(i),:), binZ(padres(i),:));
            p2= horzcat(binX(padres(i+1),:), binY(padres(i+1),:), binZ(padres(i+1),:));
        end
           cont=24;
 
        for j=1: aleatorio(i)
            
        p2(cont)=p1(cont);
        cont=cont -1;
        end
        
        res(i,:)= p2;
   
     end
    
end

 end
 
%paso por la funcin rara que acota menor a 12
function numDesX=fAcota(matriz, rango)
    acum=0;
    for i=1:100
        for j=1:8
          acum=acum+ 2^(j-1)*matriz(i,j)*rango/255 ;
        end
        numDesX(i)=acum;
        acum=0;
    end
%     acum=0;
%     numDes=[];
%     for i=1:100
%         for j=1:8
%           acum=acum+ 2^(8-j)*matriz(i,j);
%         end
%         numDesX(i)=acum*rango/255;
%         acum=0;
%     end
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
