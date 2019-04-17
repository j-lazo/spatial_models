%Activator Substrate systems
clear all 
close all
clc
%initial conditions
% mu = [0 0];
% Sigma = [.3 .3; .3 1];
x1 = -5:.1:5-.1; x2 = -5:.1:5-.1;
%[X1,X2] = meshgrid(x1,x2);


%F = mvnpdf([X1(:) X2(:)],mu,Sigma);
%F = reshape(F,length(x2),length(x1));
% [ex ey]=size(F);
%F=zeros(50,50);
siz=50;

x1=1:1:siz;
x2=1:1:siz;


a=0.03;
b=0.1;
A=(a + (b-a).*rand(siz,siz));
H=(a + (b-a).*rand(siz,siz));
[ex ey]=size(A);


Da=0.005;
Dh=.2;

rhoa=0.01;
mua=0.01;
sigmaa=0.0;
ka=0.0;

rhoh=0.02;
muh=0.02;
sigmah=0.0;
Ap=A;
Hp=H;
t=0;
dt=0.005;
dx=0.05;
s=1;
smax=800;
%D=dt/dx^2;
while s<smax
    for i=1:1:ex        
        for j=1:1:ey 
           A(i,j)=Ap(i,j);
           H(i,j)=Hp(i,j);
           if i==1
               a1=A(ex,j);
               h1=H(ex,j);
               a2=A(i+1,j);
               h2=H(i+1,j);
               
           else if i==ex
                   
                   a1=A(i-1,j);
                   h1=H(i-1,j);
                   a2=A(1,j);
                   h2=H(1,j);
               else
                           a1=A(i-1,j);
                           a2=A(i+1,j);
                           h1=H(i-1,j);
                           h2=H(i+1,j);
               end
           end
           if j==1
                 a3=A(i,ey);
                 h3=H(i,ey);
                 a4=A(i,j+1);
                 h4=H(i,j+1);
           else if j==ey
                 a4=A(i,1);
                 h4=H(i,1);
                 a3=A(i,j-1);
                 h3=H(i,j-1);
               else
                   a3=A(i,j-1);
                   a4=A(i,j+1);
                   h3=H(i,j-1);
                   h4=H(i,j+1);
               end
           end
           
           a=Da*(-4*A(i,j)+a1+a2+a3+a4)-rhoa*(A(i,j)/((1+ka*A(i,j)^2)*H(i,j)))-mua*A(i,j)+sigmaa;
           h=Dh*(h1-4*H(i,j)+h2+h3+h4)+rhoh*A(i,j)^2-muh*H(i,j)+sigmah;
           Ap(i,j)=A(i,j)+a;
           Hp(i,j)=A(i,j)+h;
        end
    end
    

    s=s+1;
    t=t+dt;
    te(s)=t;
    for t=1:1
    end
    
    figure(1)

    %subplot(1,2,1)
    clims = [0 400];
    %subplot(1,2,2)
    imagesc(H,clims)

    
end

