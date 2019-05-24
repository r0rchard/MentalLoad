function[a] = DFA(bruit1,N)
% Int�gration du syst�me
for i=1:N
   bruitInt1(i)=sum(bruit1(1:i)-mean(bruit1)); 
end
% Cr�ation des fen�tres
t_fen = [11;13;17;21;27;35;47;59;77;101]; % Nombre de points par fen�tre

for i=1:size(t_fen)
n_fen(i)=floor(N/t_fen(i)); % Nombre de fen�tres
end

% Tendances
F=zeros(10,N);

for i=1:size(t_fen,1) % Pour chaque taille de fen�tre
    for j=1:n_fen(i) % Pour chaque fen�tre de taille t_fen
        
        absc=1+t_fen(i)*(j-1):1+t_fen(i)*j; % vecteur des points en abscisses
        ordn=bruitInt1(absc); % vecteur des valeurs de l'�chantillon

        %R�gression lin�aire
        coefRegLin=polyfit(absc,ordn,1); % r�gression lin�aire d'ordre 1
        a=coefRegLin(1);
        b=coefRegLin(2);    
        
        regLin(i,absc) = a*absc+b; % droite y = a*x+b; o� x sont les points de absc 
    end
    
    %On soustrait la tendance du profil
    x=n_fen(i)*t_fen(i); %taille de la tendance
    bonneTaille = [regLin(i,1:x) zeros(1,N-x)];
    F(i,:) = (bruitInt1(1,:)-bonneTaille).^2;
    F2(i)=sqrt(sum(F(i,:))/x);
end
% Alpha 
%Passage au log
X = log(t_fen)';
Log = log(F2);
%R�gression Lin�aire
coefRegLin=polyfit(X,Log,1); % r�gression lin�aire d'ordre 1
a=coefRegLin(1);
b=coefRegLin(2);    
alpha = a*X+b;

% Affichage bruit int�gr�
%figure('Name','Bruit'),plot(bruitInt1);
% %% Affichage Tendances
% figure('Name','R�gressions lin�aires');
% subplot(521), plot(regLin(1,:)),title('taille fen�tre : 11');
% subplot(522), plot(regLin(2,:)),title('taille fen�tre : 13');
% subplot(523), plot(regLin(3,:)),title('taille fen�tre : 17');
% subplot(524), plot(regLin(4,:)),title('taille fen�tre : 21');
% subplot(525), plot(regLin(5,:)),title('taille fen�tre : 27');
% subplot(526), plot(regLin(6,:)),title('taille fen�tre : 35');
% subplot(527), plot(regLin(7,:)),title('taille fen�tre : 47');
% subplot(528), plot(regLin(8,:)),title('taille fen�tre : 59');
% subplot(529), plot(regLin(9,:)),title('taille fen�tre : 77');
% subplot(5,2,10), plot(regLin(10,:)),title('taille fen�tre : 101');
% 
% %Affichage de la tendance pour N=101
% figure('Name','Tendance'),plot(bruitInt1),title('Tendance pour N = 101');
% hold on
% plot(regLin(10,:),'red'),
% for i = 1:101:5001
%     plot([i i],[min(bruitInt1) max(bruitInt1)],'black:') ;
% end
% %% Affichage de la racine carr� de la puissance des r�sidus
% figure('Name','R�sidus');
% plot(F(10,:)),title('R�sidus pour N = 101');
% %% Affichage d'Alpha
% figure('Name','F en fontion de N'),plot(t_fen,F2,'.'),title('F(N)');
% figure('Name','log(F) en fontion de log(N)'),plot(X,Log,'.'),title('Log(F(N))');
% hold on
% plot(X,alpha,'r');
end
