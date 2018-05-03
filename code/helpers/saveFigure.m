function saveFigure(figureNumber, figureName, path, type)

currentDir = pwd();
mkdir(path)
cd(path)
set(figure(figureNumber), 'Position', get(0, 'Screensize'))
saveas(figure(figureNumber), [figureName, '.', type]) 
cd(currentDir)

end

