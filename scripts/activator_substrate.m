%Activator-substrate systems. 
%Biological pattern formation: from basic mechanism to complex structures
%A.J Koch & Meinhardt, The American Physucal Society 1994
close all
clear all 
clc
current_dir=pwd;
stat=mkdir('video_patternform/video_activ_subtrate');

siz=200;

x1=1:1:siz;
x2=1:1:siz;

dir=strcat(current_dir,'/video_patternform/video_activ_subtrate/');

a=0.03;
b=0.1;
A=(a+(b-a).*rand(siz,siz));
H=(a+(b-a).*rand(siz,siz));
[ex ey]=size(A);

%values of te constants for the simulations
Da=0.005;
Dh=.2;

rhoa=0.01;
mua=0.01;
sigmaa=0.0;
ka=0.25

rhoh=0.02;
muh=0.02;
sigmah=0.02;



Ap=A;
Hp=H;
t=0;
dt=1;
dx=0.1;
s=1;
smax=2000;

% workingDir = tempname;
% mkdir(workingDir)
% mkdir(workingDir,'images')


%the calculations 
while s<smax
    
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
        
        a=Da*(-4*A(i,j)+a1+a2+a3+a4)/dx+rhoa*(A(i,j)^2*A(i,j))/(1+ka*A(i,j).^2)-mua*A(i,j)+sigmaa;
        h=Dh*(-4*H(i,j)+h1+h2+h3+h4)/dx-rhoh*A(i,j)^2*A(i,j)/(1+ka*A(i,j).^2)+sigmah;
        Ap(i,j)=A(i,j)+a;
        Hp(i,j)=H(i,j)+h;

        end
    end
    
    figure(1)
    clims = [min(min(Ap)) max(max(Ap))];
    imagesc(Ap,clims)
    colormap hsv
    pause(0.0001);
    
    savedir=strcat(dir,'activ_subst',num2str(s),'.png');
    saveas(figure(1),savedir);
    
    s=s+1;
    A=Ap;
    H=Hp;
    
   
end 
%%
    figure(2)
    clims = [min(min(Ap)) max(max(Ap))];
    imagesc(Ap,clims)
    colormap hsv
    figure(3)
    surf(Ap)
    zlabel('concentration')
    colorbar
    
%%
%----------make the video
%%---------first let's read the images. 
smax=7202
images=cell(smax-1,1);
for i=1:smax-1
    dir_read=strcat(dir,'activ_subst',num2str(i),'.png');
    images{i}=imread(dir_read);
end

%----------create the video writer
direcvideo=strcat(dir,'activ_subst_1');
writerObj = VideoWriter(direcvideo);

%select frame per seconds
writerObj.FrameRate = 60;
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
    dir_del=strcat(dir,'activ_subst',num2str(j),'.png');
    delete(dir_del);
end