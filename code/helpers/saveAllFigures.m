function saveAllFigures(resultFolderPath, type, Params, ifSave)

if ifSave
    
    path = [resultFolderPath, 'sizeK_', num2str(Params.sizeK), '_sigma_', num2str(Params.sigma)];
    
    saveFigure(1, 'target_digits', path, type)
    saveFigure(101, 'trained_network', path, type)
    saveFigure(102, 'process', path, type)
    saveFigure(201, 'counts', path, type)
    saveFigure(202, 'centroids', path, type)
    
end

end

