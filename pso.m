%%Fabian Camilo Herrera Ramirez 20141020035
%%Luis Enrique Mendez Lopez 20141020032
clc;
clear all;
close all;
format long

nIter=200%% numero de iteraciones
%%

 c1=1;
 c2=1;
 r1=0.5;%%inicialmente es 0.5 pero en realidad es un aleatorio
 r2=0.5;
 %%
 %el tamaño dela poblacion es 700
 fOb=zeros(700,1);%%inicializacion de la funcion objetivo
 velAnti=zeros(700,3);%%inicializacion de la velocidad inicial igual a 0
 x=randi([0 33], 700, 1);%%valores aleatorios de  x inicial
 y=randi([0 43], 700, 1);%%valores aleatorios de  y inicial
 z=randi([0 50], 700, 1);%%valores aleatorios de  z inicial

 

 %% es una matriz de 700*3
 %%concateno x, y, en una sola matriz
 poblacion=horzcat(x,y,z);
 %%
 %inicio de las iteraciones
 
  for iteracion=1: nIter
%hallarF calcula el valor de la funcion objetivo dada la poblacion y el
%numero de la iteracion
 fOb=hallarF(poblacion, iteracion);

 %hallamos el pbest de cada particula
 %%Es un vector de 1*700
for j=1 : 700
pbest(j, :)=poblacion(j,:);
end
%hallamos el gbest
[x, t]=max(fOb);



%calculo del theta 
 theta=0.9-((0.9-0.4)/nIter)*iteracion;
 %hallamos aleatoriamente r1 y r2
 r1=rand;
 r2=rand;
 %%
 %hallamola velocidad nueva paracada particula
 for parti=1: 700
 
   
    vNueva(parti, 1)=theta*velAnti(parti, 1)+ c1*r1*(pbest(parti, 1)-poblacion(parti, 1))+c2*r2*(poblacion(t, 1)-poblacion(parti, 1));
    vNueva(parti, 2)=theta*velAnti(parti, 2)+ c1*r1*(pbest(parti, 2)-poblacion(parti, 2))+c2*r2*(poblacion(t, 2)-poblacion(parti, 2));
    vNueva(parti, 3)=theta*velAnti(parti, 3)+ c1*r1*(pbest(parti, 3)-poblacion(parti, 3))+c2*r2*(poblacion(t, 3)-poblacion(parti, 3));

 end

 
%%
%hallamos la nueva poblacion 
  for parti=1: 700
    poblacionN(parti, 1)=poblacion(parti, 1)+vNueva(parti, 1);
    poblacionN(parti, 2)=poblacion(parti, 2)+vNueva(parti, 2);
    poblacionN(parti, 3)=poblacion(parti, 3)+vNueva(parti, 3);

  end
  %%
  %hallamos el valor de F con esa nueva poblacion
  nuevoF=hallarF(poblacionN, iteracion);



  %%
  %revisamos que valores de f son mejores que el valor anterior de f y lo
  %reemplazamos
  
  for cont=1: 700
      if nuevoF(cont)>fOb(cont) %nuevoF es la funcion con la nueva poblacion         
          if poblacionN(cont, 1)>=0
              if poblacionN(cont, 2)>=0
                  if poblacionN(cont, 3)>=0
                      poblacion(cont,:)=poblacionN(cont, :);
                  end
              end
          end
      end
  end
  %%a
%%
%graficamos todas las variables de losprimeros 20 elementos de la poblacion
%por que si graficaramos los 700 POR QUE el computador no lo aguanta
  subplot(4, 1, 1)
  plot(iteracion, poblacion(1:20,1), "r.")
hold on
title("valores de x")
subplot(4, 1, 2)
  plot(iteracion, poblacion(1:20,2), "b.")
hold on
title("valores de y")
subplot(4, 1, 3)
  plot(iteracion, poblacion(1:20,3), "g.")
hold on
title("valores de z")
subplot(4, 1, 4)
for i =1: 700
 fObSR(i)=10*poblacion(i, 1)+9*poblacion(i, 2)+8*poblacion(i,3);
 
  end
  plot(iteracion,fObSR(1:20) , "r.")
hold on
title("valores de la funcion objetivo")

iteracion
%%
%actualizamos la velocidad anterior
 velAnti=vNueva;
 
  end
 %%
%MOSTRAMOS LOS VALORES DE X Y Z
 poblacion(1:20,:)
  
  for i =1: 700
 fOb(i)=10*poblacion(i, 1)+9*poblacion(i, 2)+8*poblacion(i,3);
 
  end
  %MOSTRAMOS LOS VALORES DE LA FUNCION OBJETIVO
 fOb(1:20)
 
 %%
 %termino 1 =phigi
%termino 2 =qj
%termino 3 =rqui
 function res=calcularS(termino1, termino2, termino3)
 res=termino1*termino2^(termino3);
 end
 
 %%
 %con esta funcion se halla el valor de la funcion objetivo castigada
 function valFO= hallarF(poblacion, iteracion)
 for k=1: 700
 res1(k)=4*poblacion(k,1)+3*poblacion(k,2)+2*poblacion(k,3)-130;%%si es posiivo viola la restriccion
  res2(k)=3*poblacion(k,1)+2*poblacion(k,2)+2*poblacion(k,3)-100;%%si es posiivo viola la restriccion

 end

 q=[];
 
 phigi=[];
 for k=1:700
 q(1,k)=max(0,res1(k));
  phigi(1,k)=150*(1-1/(exp(q(1, k))))+10;

if q(1,k)<=1
    rqi(1,k)=1;
else
    rqi(1,k)=2;
end

 end
 
 
 for k=1:700
 q(2,k)=max(0,res2(k));
  phigi(2,k)=150*(1-1/(exp(q(2, k))))+10;
if q(2,k)<=1
    rqi(2,k)=1;
else
    rqi(2,k)=2;
end

 end
 for h=1:700
 sumatoria(h)=calcularS(q(1,h), phigi(1,h), rqi(1, h) )+calcularS(q(2,h), phigi(2,h), rqi(2, h) );
 
 end
 for i =1: 700
 fOb(i)=10*poblacion(i, 1)+9*poblacion(i, 2)+8*poblacion(i, 3);
 
 end

 %calculode F(x)
 for iter=1: 700
 f(iter)=fOb(iter)- (0.5*iteracion)^(2)*sumatoria (iter);
 end
 valFO=f;
 
 end
 