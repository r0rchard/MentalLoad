function[S] = CreationSignal(N)
% Génération des bruits
sigma = 4;   % Variance du bruit
moy = 5;     % Moyenne
bruit1 = moy + sqrt(sigma)*randn(1,N); % Bruit avec moyenne
bruit2 = randn(1,N);                   % Bruit avec moyenne nulle et de variance 1
S=bruit1;
%figure('Name','Bruit'),plot(S);
end