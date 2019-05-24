function[alpha] = analyseDMA(bruit1,N)

    % Cr�ation des fen�tres
    t_fen = [11;13;17;21;27;35;47;59;77;101]; % Nombre de points par fen�tre

    % Int�gration du syst�me
    for i=1:N
       bruitInt1(i)=sum(bruit1(1:i)-mean(bruit1));
    end

    for i=1:size(t_fen)
        n_fen(i)=floor(N/t_fen(i)); % Nombre de fen�tres
    end

    for i=1:size(t_fen,1) % Pour chaque taille de fen�tre
        %Cr�ation Filtre
        %zeros
        b = zeros(1,t_fen(i)+1);
        b(1) =1;
        b(t_fen(i)+1) =-1;
        %p�les
        a =t_fen(i)*[1,-1];
        %Filtrage du signal
        bruit_filtre=filter(b,a,bruitInt1);
        
        %Affichage
%       figure,zplane(b,a);
       figure,freqz(b,a,2^10);
       ax = findall(gcf, 'Type', 'axes'),
       set(ax, 'XScale', 'log');
       xlabel('log(f)');
%       figure, plot(bruitInt1,'blue');
%       hold on;
%       plot(bruit_filtre,'red');
        
        %Recalage
        rec = (t_fen(i)-1)/2;
        tendance = bruit_filtre(rec:N);%On enl�ve les premi�res valeurs
        bruit = bruitInt1(1:N+1-rec); %Pour que les deux signaux aient le m�me nbr de valeurs
        %Affichage
%         figure, plot(bruit,'blue');
%         hold on;
%         plot(tendance,'red');


        %On soustrait la tendance du profil

    x=N+1-rec; %taille de la tendance, elle change
    %F(i,:) = (bruitInt1(1,:)-bonneTaille).^2;
    %F2(i)=sqrt(sum(F(i,:))/x);
    F(i)=sqrt(sum((bruit-tendance).^2)/x);
    end
    %Alpha 
    %Passage au log
    X = log(t_fen)';
    Log = log(F);
    %R�gression Lin�aire
    coefRegLin=polyfit(X,Log,1); %r�gression lin�aire d'ordre 1
    alpha =coefRegLin(1);
    beta =coefRegLin(2);    
    regression = alpha*X+beta;

    % Affichage bruit int�gr�
    % figure('Name','Bruit'),plot(bruit_filtre);
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
    %plot(X,regression,'r');
end
