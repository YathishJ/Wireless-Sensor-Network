function R=calc_R(numNodes,fieldX,fieldY)
        p=sqrt((fieldX^2)+(fieldY^2));
        R=p*sqrt(log10(numNodes)/numNodes);
end