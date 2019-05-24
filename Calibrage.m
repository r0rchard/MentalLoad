function [oups1,oups2] = Calibrage(resultats1,x)
    X=1:5;

    moy1 = mean(resultats1(1,:));
    moy2 = mean(resultats1(2,:));
    diff1 = zeros(1,5);
    diff2 = zeros(1,5);
    oups1 = zeros(1,5);
    oups2 = zeros(1,5);
    figure('Name',num2str(x)),plot(X,resultats1(1,:),'b+'),title(num2str(x))
    hold on, plot(X,resultats1(2,:),'ro'),hold on
    plot([1 5],[moy1 moy1],'black:'),plot([1 5],[moy2 moy2],'black:') 

    for i = X
        diff1(i) = resultats1(1,i)-moy1;
        diff2(i) = resultats1(2,i)-moy2;
        hold on, plot([i i],[resultats1(1,i) moy1],'b:') ;
        hold on, plot([i i],[resultats1(2,i) moy2],'r:') ;
        if abs(diff1(i))> abs(resultats1(1,i)-moy2)
            oups1(i)=1;
        end
        if abs(diff2(i))> abs(resultats1(2,i)-moy1)
            oups2(i)=1;
        end
    end
    
end

