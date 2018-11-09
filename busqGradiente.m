%Metodo de busqueda de gradiente
%Fabian Camilo Herrera Ramirez 20141020035
syms x x1 x2;

funcOr(x1, x2)=2*x1*x2+2*x2-x1^2-2*x2^2;
dx1(x1, x2)= diff(2*x1*x2+2*x2-x1^2-2*x2^2, x1);
dx2(x1,x2)=diff(2*x1*x2+2*x2-x1^2-2*x2^2, x2);

sIni=[0,0];
ep=0.01;
syms t;

grad=[dx1(sIni(1), sIni(2) ),dx2(sIni(1), sIni(2) )];

 while(isAlways(abs(grad(1))>ep) | isAlways(abs(grad(2)) > ep))

    t1= sIni(1)+t*(grad(1));
    t2= sIni(2)+t*(grad(2));
    fDeT(t)=funcOr(t1,t2);
    der(t)= diff(fDeT, t);
    tS=solve(der, t);
    sIni(1)=sIni(1)+tS*grad(1)
    sIni(2)=sIni(2)+tS*grad(2)
    grad=[dx1(sIni(1), sIni(2) ),dx2(sIni(1), sIni(2) )];
 end
 funcOr(sIni(1), sIni(2))