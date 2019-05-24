clear all
close all
clc

f_ech = 1000;    % Fréquence d'échantillonnage
N = 5001;    % Nombre de points dans tout l'échantillon


AlphaDFA = zeros(1,50);
AlphaDMA = zeros(1,50);
for k = 1:50
    bruit = CreationSignal(N);
    alphaF = DFA(bruit,N);
    alphaM = analyseDMA(bruit,N);
    AlphaDFA(k) = alphaF;
    AlphaDMA(k) = alphaM;
end

MoyAlphaDFA = mean(AlphaDFA)
VarAlphaDFA = var(AlphaDFA)

MoyAlphaDMA = mean(AlphaDMA)
VarAlphaDMA = var(AlphaDMA)