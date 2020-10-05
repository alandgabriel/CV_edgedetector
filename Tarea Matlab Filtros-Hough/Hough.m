ReadPic=imread('Guitar.jpg');
I = imrotate(ReadPic,-90);
EscalGris = rgb2gray(I);%edge solo funciona con figuras en escala de grises
BW = edge(EscalGris, 'Roberts');
[H,T,R] = hough(BW);
imshow(BW)
%Muestra la gráfica de la transformada de Hough
% imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
% xlabel ('\theta'), ylabel ('\rho');
% axis on, axis normal, hold on;
%Detecta los houghpeaks 
P = houghpeaks(H,5,'threshold',ceil(0.3*max (H(:))));
x = T(P(:,2)); 
y = R(P(:,1));
%Grafica los houghpeaks
% plot (x,y,'s','color','white');
%Encuentra lineas y las grafíca
% lines = houghlines(BW,T,R,P,'FillGap',5,'MinLength',7);
lines = houghlines(BW,T,R,P);
figure, imshow (EscalGris), hold on

max_len = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
    plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
    %Grafica los inicios y finales de las lineas
%     plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    %Determina los puntos finales de la línea más larga
    len = norm(lines(k).point1 - lines(k).point2);
    if (len > max_len)
        max_len = len;
        xy_log = xy;
    end
end
%Remarca la línea más larga
plot(xy_log(:,1),xy_log(:,2),'LineWidth',2,'Color','blue');

%Links de referencias:
%https://porprofesionalmic.files.wordpress.com/2015/09/investigacion-documental-transformada-hough.pdf
%https://www.mathworks.com/help/images/ref/edge.html#d122e65963
%https://www.mathworks.com/help/images/ref/hough.html#buwew0l-1-H
%https://www.mathworks.com/help/images/ref/houghlines.html
%https://www.mathworks.com/help/images/ref/houghpeaks.html