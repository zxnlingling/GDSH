function[MAP] = EvaMAPK(kkk,traingnd,testgnd,H,tH)
    B = compactbit(H);
    tB = compactbit(tH);

    hammTrainTest = hammingDist(tB, B)';
    % hash lookup: precision and reall
    % Ret = (hammTrainTest <= hammRadius+0.00001);
    % [Pre, Rec] = evaluate_macro(cateTrainTest, Ret)

    % hamming ranking: MAP
    [~, HammingRank]=sort(hammTrainTest,2);
    MAP = cat_apcal(kkk,traingnd,testgnd,HammingRank');
end