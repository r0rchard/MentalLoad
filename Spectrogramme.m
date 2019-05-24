clear all
close all
clc
% G�n�ration d'un bruit blanc Gaussien
f_ech = 1000;    % Fr�quence d'�chantillonnage
n_ech = 5001;    % Nombre de points dans tout l'�chantillon

sigma = 4;   % Variance du bruit
moy = 5;     % Moyenne
bruit1 = moy + sqrt(sigma)*randn(1,n_ech); % Bruit avec moyenne
bruit2 = randn(1,n_ech);                   % Bruit avec moyenne nulle et de variance 1

%spectogramme
t_fen = 256; % taille fenetre
t_overlap = 50; % pourcentage de recouvrement
t_nfft = 256; % taile de l'�chantillonage pour la fft : puissance de 2 de taille sup�rieur ou �gale � la taille de la fen�tre
S = spectrogram(bruit1,t_fen,t_overlap,t_nfft,f_ech); % S est une matrice -> image pour voir

% affichage
figure(1)
t = (1:n_ech)/f_ech; %temps
subplot(211),plot(t(1:5000),bruit1(1:5000)),title('Domaine temporel')
subplot(212),spectrogram(bruit1,t_fen,t_overlap,t_nfft,f_ech, 'yaxis'),title('Spectrogramme')
% rajouter yaxis pour avoir les fr�quences en ordonn�es et le temps en
% abscisse


