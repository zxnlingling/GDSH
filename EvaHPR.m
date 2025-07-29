function[PR] = EvaHPR(traingnd,testgnd,H,tH,hammRadius)
    B = compactbit(H);
    tB = compactbit(tH);
    cateTrainTest=single(traingnd*testgnd'>0);
    hammTrainTest = hammingDist(tB, B);
    % hash lookup: precision and reall
    Ret = (hammTrainTest <= hammRadius+0.00001);
    % PR=zeros(2,1);
    [P,R] = evaluate_macro(cateTrainTest, Ret);
    PR=P;
    % PR(1,1)=P;
    % PR(2,1)=R;
end