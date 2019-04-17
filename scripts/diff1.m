%%DIfussion
clc
clear all
close all
%Definition of the constants and stuff
X=zeros(100,100);
[ex ey]=size(X);
D=0.7;
dt=0.005;

k1=0.00;
t=0;
xplot=[1:1:ey];
a=1;
b=ey;
s=1;
smax=100;


while s<smax
    s
    i=50;
    j=50;
    while (i<ey)||(j==1)
        
        if i==ey
            x=D*(X(1,i-1)-2*X(1,i)+X(1,i+1))-k1*X(1,i);
            X(1,i)=X(1,i)+x;
            i=i+1;
        else 
            x=D*(X(1,i-1)-2*X(1,i))-k1*X(1,i);
            X(1,i)=X(1,i)+x;
            i=ey-1;
        end
    end
    
     
    s=s+1;
    t=t+dt;
    te(s)=t;
    T(:,:,s)=X;
    
end
%ploeteando
figure()
surf(xplot,te,T)
caxis([min(T(:))-.5*range(T(:)),max(T(:))]);
ylabel('t')
xlabel('x')
zlabel('c(t)')
