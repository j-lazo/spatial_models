%%Difussion/ Passive transport. 
%function Diffusion()
clc
clear all 
close all
%initial conditions
% mu=[0 0];
% Sigma=[.3 .3; .3 1];
% x1=-.5:.1:5-.1;
% x2=-5:.1:5-.1;
% [X1 X2]=meshgrid(x1,x2);
% F=mvnpdf([X1(:) X2(:)],mu,Sigma);
% F=reshape(F,length(x2),length(x1));
% [ex ey]=size(F);
% W=F;

dt=0.005;
dx=0.1;
D=dt/dx^2;

W=ones(100,100)*100;
[w l]=size(W);
W(w/2-5:w/2+5,l/2-5:l/2+5)=5;
%W(50,50)=30;
%%initial conditions
N = 20;
x=linspace(-N, N);
y=x;
[X,Y]=meshgrid(x,y);
z=(10/sqrt(2*pi).*exp(-(X.^2/2)-(Y.^2/2)));
W=z;
%%
t=0;
tmax=30; 
Wn=W;
name=''
dir=strcat(cd,'/video_diffusion/video_difussion');


while t<tmax
    W=Wn;
    for i=2:w-1
        for j=2:l-1
            xn=D*(W(i-1,j)+W(i+1,j)+W(i,j-1)+W(i,j+1)-4*W(i,j));
            Wn(i,j)=W(i,j)+xn; # this is wrong, you cannot update like this man!
        end
    end
    t=t+1
    
    figure(1)
    subplot(1,2,1)
    title('Difussion simulation')
    surf(Wn)
    shading interp
    zlabel('Concentration')
    txt = ['The value is ',num2str(t)];
    %axis([0 100 0 100 -1 30])
    subplot (1,2,2)
    imagesc(Wn);
    colorbar; 
    pos = get(gcf, 'Position'); %// gives x left, y bottom, width, height
    equis = pos(3);
    ye = pos(4);
    htext=text(200,200,sprintf('t=',num2str(t)),'FontSize',16);
    %pause(0.001) 
    %save images
    save=strcat(dir,num2str(t),'.png');
    saveas(figure(1),save);
    
end


%%make the video
%first let's read the images. 
images=cell(tmax,1);
for i=1:tmax
    dir_read=strcat(dir,num2str(i),'.png');
    images{i}=imread(dir_read);
end

%create the video writer
direcvideo=strcat(dir,'DifussionVideo.m4v');
writerObj = VideoWriter(direcvideo);

%select frame per seconds
writerObj.FrameRate = 5;
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
