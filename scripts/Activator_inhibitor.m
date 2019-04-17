%%Activitor-inhibitor systems
%Biological pattern formation, based on 
%Biological pattern formation: from basic mechanism to complex structures
%A.J Koch & Meinhardt, The American Physucal Society 1994
close all
clear all 
clc
siz=200;

x1=1:1:siz;
x2=1:1:siz;
name='/video_patternform/video_acitv_inhib/';
dir=strcat(cd,name);
%%%-------initial conditions 
a=0.03;
b=0.1;
A=(a+(b-a).*rand(siz,siz));
H=(a+(b-a).*rand(siz,siz));
[ex ey]=size(A);

%values of te constants for the simulations
Da=0.005;
Dh=0.2;

rhoa=0.01;
mua=0.01;
sigmaa=0.1;
ka=0.00;

rhoh=0.02;
muh=0.02;
sigmah=0.0;

Ap=A;
Hp=H;
t=0;
dt=1;
dx=1;
s=1;
smax=2000;

% workingDir = tempname;
% mkdir(workingDir)
% mkdir(workingDir,'images')


%the calculations 

while s<smax
    s
    for i=1:1:ex
        for j=1:1:ey
            %first analize in case of any border condition
            
            if i==1
                a1=A(ex,j);
                h1=H(ex,j);
                a2=A(i+1,j);
                h2=H(i+1,j);
            elseif i==ex
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
            
            if j==1
                a3=A(i,ey);
                h3=H(i,ey);
                a4=A(i,j+1);
                h4=H(i,j+1);

            elseif j==ey
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
            
        %the equations
        
        delta_a=(-4*A(i,j)+a1+a2+a3+a4)/dx^2;
        delta_h=(-4*H(i,j)+h1+h2+h3+h4)/dx^2;
        
        dadt=Da*delta_a+rhoa*(A(i,j)^2/((1+ka*A(i,j)^2)*H(i,j)))-mua*A(i,j)+sigmaa;
        dhdt=Dh*delta_h+rhoh*A(i,j)^2-muh*H(i,j)+sigmah;
        
        Ap(i,j)=A(i,j)+dadt;
        Hp(i,j)=H(i,j)+dhdt;
        end
        
    end
    
    
    figure(1)
    clims = [min(min(Ap)) max(max(Ap))];
    imagesc(Ap,clims)    
    colormap hsv
    
    pause(0.01)

    save=strcat(dir,'activ_inhib',num2str(s),'.png');
    saveas(figure(1),save);
    
    s=s+1;
    A=Ap;
    H=Hp;
    
   
end 
%%    
figure(2)
imagesc(Ap)
colormap hsv

figure(3)
surf(Ap)
zlabel('concentration')
colorbar
    
%%
%%------------make the video
%%---------first let's read the images. 
images=cell(smax-1,1);
for i=1:smax-1
    dir_read=strcat(dir,'activ_inhib',num2str(i),'.png');
    images{i}=imread(dir_read);
end


%%-----create the video writer
direcvideo=strcat(dir,'DifussionVideo_3');
writerObj = VideoWriter(direcvideo);

%select frame per seconds
writerObj.FrameRate = 90;
%select seconds per Image, only if you want to change the time each image
%is showed
%secsPerImage = [5 10 15];

%open the video writer
open(writerObj);


 % write the frames to the video
 for u=1:length(images)
     % convert the image to a frame
     frame = im2frame(images{u}); 
     writeVideo(writerObj, frame);
     
 end

% close the writer object
close(writerObj);
%end

%delete the images
for j=1:smax-1
    dir_del=strcat(dir,'activ_inhib',num2str(j),'.png');
    delete(dir_del);
end
% %% 
