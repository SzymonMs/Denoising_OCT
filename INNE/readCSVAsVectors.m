function columnVectors = readCSVAsVectors(csvFile)
    % readCSVAsVectors - Wczytuje plik CSV i zwraca poszczególne kolumny jako wektory.
    %
    % SYNTAX:
    %   columnVectors = readCSVAsVectors(csvFile)
    %
    % INPUT:
    %   csvFile - Nazwa pliku CSV do wczytania
    %
    % OUTPUT:
    %   columnVectors - Struktura zawierająca poszczególne kolumny jako wektory
    %
    % PRZYKŁAD:
    %   data = readCSVAsVectors('combined.csv');

    % Wczytanie danych z pliku CSV
    dataTable = readtable(csvFile);
    
    % Inicjalizacja struktury do przechowywania kolumn
    columnVectors = struct();
    
    % Iteracja przez kolumny tabeli i zapisanie ich jako wektory w strukturze
    for i = 1:width(dataTable)
        columnName = dataTable.Properties.VariableNames{i};
        columnVectors.(columnName) = dataTable.(columnName);
    end
end