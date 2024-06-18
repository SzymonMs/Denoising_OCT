function combineTxtFiles(rootDirectory, outputFile)
    % Otwórz plik wyjściowy do zapisu
    outputFileID = fopen(outputFile, 'w');
    
    % Uzyskaj listę wszystkich plików txt w katalogu głównym i jego podkatalogach
    fileList = dir(fullfile(rootDirectory, '**', '*.txt'));
    
    for i = 1:length(fileList)
        % Pełna ścieżka do pliku
        inputFilePath = fullfile(fileList(i).folder, fileList(i).name);
        
        % Otwórz plik wejściowy do odczytu
        inputFileID = fopen(inputFilePath, 'r');
        
        if inputFileID == -1
            warning('Nie można otworzyć pliku: %s', inputFilePath);
            continue;
        end
        
        % Czytaj plik linia po linii
        while ~feof(inputFileID)
            line = fgetl(inputFileID);
            if any(isstrprop(line, 'digit'))
                fprintf(outputFileID, '%s\n', line);
            end
        end
        
        % Zamknij plik wejściowy
        fclose(inputFileID);
    end
    
    % Zamknij plik wyjściowy
    fclose(outputFileID);
end
