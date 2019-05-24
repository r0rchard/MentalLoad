% Représentations temporelles et temps-fréquence des EEG
N=1001;
load('H:\2A\Signal\Projet 2\TP\dataEEG.mat');
resultats1 = zeros(2,5);
resultats2 = zeros(2,5);
for i_s = 1:5
    for i_p = 1:2
        temp = cell2mat(dataEEG(i_p,1,i_s));
        resultats1(i_p,i_s) = DFAbase(temp,N);
        temp = cell2mat(dataEEG(i_p,2,i_s));
        resultats2(i_p,i_s) = DFAbase(temp,N);
    end
end
[e1_1,e1_2]=Calibrage(resultats1,1);
[e2_1,e2_2]=Calibrage(resultats2,2);


