function [ mask, mask_idx ] = getMaskStrCellContainsStr( CellOfStrs, StrPattern )
%GETMASKSTRCELLCONTAINSSTR [ mask, mask_idx ] = getMaskStrCellContainsStr( CellOfStrs, StrPattern )
%      Devuelve una máscara indicando los elementos que cumplen el patrón del vector de Strings

    N = length(CellOfStrs);
    mask = zeros(N, 1);
    for i = 1 : N
        if ~isempty(strfind(CellOfStrs{i}, StrPattern))
            mask(i) = 1;
        end
    end
    mask_idx = find(mask==1);
	
end

