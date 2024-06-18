function combineCSVFiles(inputDir, outputFile)
    % combineCSVFiles - �?ączy wszystkie pliki CSV z podkatalogów w jeden plik CSV.
    %
    % SYNTAX:
    %   combineCSVFiles(inputDir, outputFile)
    %
    % INPUT:
    %   inputDir   - Ścieżka do katalogu głównego, w którym należy szukać plików CSV
    %   outputFile - Nazwa wyjściowego pliku CSV
    %
    % PRZYK�?AD:
    %   combineCSVFiles('C:\dane', 'combined.csv')

    % Wyszukiwanie wszystkich plików CSV w katalogu głównym i podkatalogach
    filePattern = fullfile(inputDir, '**', '*.csv');
    files = dir(filePattern);
    
    % Sprawdzenie, czy znaleziono jakiekolwiek pliki CSV
    if isempty(files)
        disp('Nie znaleziono żadnych plików CSV.');
        return;
    end
    
    % Inicjalizacja tabeli do przechowywania danych
    combinedData = [];
    
    % Przetwarzanie każdego pliku CSV
    for i = 1:length(files)
        % Pobranie pełnej ścieżki do pliku CSV
        filePath = fullfile(files(i).folder, files(i).name);
        % Wczytanie danych z pliku CSV
        data = readtable(filePath);
        
        % �?ączenie danych
        if isempty(combinedData)
            combinedData = data;
        else
            combinedData = [combinedData; data];
        end
    end
    
    % Zapisanie połączonych danych do wyjściowego pliku CSV
    writetable(combinedData, outputFile);
    
    disp(['Dane zostały zapisane do pliku: ' outputFile]);
end