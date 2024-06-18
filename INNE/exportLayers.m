clear all
%% 1. load data file - TODO: wybranie pliku....

file = 'Copernicus Seria 2 VMT/DABROWSKI_ADAM_2014_09_12_09_49_29_L_Centralna_3D_8,00 mm_ 684x240';
fileName = strcat(file,'.mat');

filesCount = 0;
path = '.';
[filename, folderPath , filterindex] = uigetfile(['*.mat' ],'Choose files to extract data','MultiSelect', 'on');
if (~iscell(filename))
    filePath{1} = [folderPath, filename];
    filesCount = filesCount + 1; 
else
    for i = 1:numel(filename)
        filePath{i} = [folderPath ,filename{i}];
        filesCount = filesCount + 1;
    end
end
    
for f=1:numel(filePath)
    fileName = filePath{f};
    load(fileName);
    file = strrep(fileName, '.mat', '_auto.txt');
    fprintf('Processing file: %s\n', fileName);

    % run calculatePathAbs.m

    %% 2. create variables
    bscansNumber = size(imageLayer,2);
    vectorLength = 193; % 400; % size(imageLayer(1).tractionDepth,2);

    pcv = zeros(bscansNumber, vectorLength);
	ilm = zeros(bscansNumber, vectorLength);
    nflgcl = zeros(bscansNumber, vectorLength);
    iplinl = zeros(bscansNumber, vectorLength);
    inlopl = zeros(bscansNumber, vectorLength);
    oplonl = zeros(bscansNumber, vectorLength);
	isos = zeros(bscansNumber, vectorLength);
	rpe = zeros(bscansNumber, vectorLength);
    for i=1:bscansNumber
        if isfield(imageLayer,'retinalLayers')
            layers = imageLayer(i).retinalLayers;
            lc = ceil((imageLayer(i).leftCut-1)/2)+1;
            rc = floor((imageLayer(i).rightCut)/2);
            %lc = 58;rc = 14;
            
            if ~isempty(layers)
                layerT = layers(strcmpi('traction',{layers(:).name}));
                if ~isempty(layerT)
                    pathAbs = layerT.pathAbs;
                    if ~isempty(pathAbs)
                        %pcv(i,lc:(end-rc)) = pathAbs; %8/2
                        pcv(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %8/2
                    end
                end

                pathAbs = layers(strcmpi('ILM',{layers(:).name})).pathAbs;
                if ~isempty(pathAbs)
                    if (size(ilm,2) == size(pathAbs,2))
                        ilm(i,:) = pathAbs;
                    else
                        ilm(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %2
                    end
                end
                
                pathAbs = layers(strcmpi('NFLGCL',{layers(:).name})).pathAbs;
                if ~isempty(pathAbs)
                    nflgcl(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %5
                end
                
                pathAbs = layers(strcmpi('IPLINL',{layers(:).name})).pathAbs;
                if ~isempty(pathAbs)
                    iplinl(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %6
                end
                
                pathAbs = layers(strcmpi('INLOPL',{layers(:).name})).pathAbs;
                if ~isempty(pathAbs)
                    inlopl(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %4
                end
                
                pathAbs = layers(strcmpi('OPLONL',{layers(:).name})).pathAbs;
                if ~isempty(pathAbs)
                    oplonl(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %7
                end
                
                pathAbs = layers(strcmpi('ISOS',{layers(:).name})).pathAbs;
        		if ~isempty(pathAbs)
                    isos(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %1
                end
                
                pathAbs = layers(strcmpi('RPE',{layers(:).name})).pathAbs;
                if ~isempty(pathAbs)
                    rpe(i,lc:(lc+size(pathAbs,2)-1)) = pathAbs; %3
                end
            end
        end
    end
	pcv = int16(pcv);
    ilm = int16(ilm);
    nflgcl = int16(nflgcl);
    iplinl = int16(iplinl);
    inlopl = int16(inlopl);
    oplonl = int16(oplonl);
	isos = int16(isos);
	rpe = int16(rpe);

    leftCut = imageLayer(1).leftCut;
    rightCut = imageLayer(1).rightCut;
    scale = 0.5;

    %% 3. scale and fill data

    %% 4. save file
    %fid = fopen(strcat(file,'_auto_all.txt'),'w');
    fid = fopen(file, 'w');
    fprintf(fid, 'leftCut=%d\n', leftCut);
    fprintf(fid, 'rightCut=%d\n', rightCut);
    leftCut = 0;%uint16(leftCut/2);
    rightCut = uint16(rightCut/2);

    for i=1:bscansNumber
        display(strcat('Skan: ',num2str(i),' z ',num2str(bscansNumber)));
        
        % PCV --------------
        x = leftCut;
        fprintf(fid, 'PCV_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, pcv(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, pcv(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');

        % ILM --------------
        x = leftCut;
        fprintf(fid, 'ILM_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, ilm(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, ilm(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');
        
        % GCL --------------
        x = leftCut;
        fprintf(fid, 'GCL_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, nflgcl(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, nflgcl(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');

        % IPL --------------
        
        % INL --------------
        x = leftCut;
        fprintf(fid, 'INL_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, iplinl(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, iplinl(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');

        % OPL --------------
        x = leftCut;
        fprintf(fid, 'OPL_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, inlopl(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, inlopl(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');

        % ONL --------------
        x = leftCut;
        fprintf(fid, 'ONL_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, oplonl(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, oplonl(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');
        
        % ELM --------------
        
        % MEZ --------------
        
        % IOS --------------
        x = leftCut;
        fprintf(fid, 'IOS_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, isos(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, isos(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');
        
        % RPE --------------
        
        % CHR --------------
        x = leftCut;
        fprintf(fid, 'CHR_%d=', i-1);
        for j=1:vectorLength
            fprintf(fid, '%d,%d;', x, rpe(i,j)*2);
            fprintf(fid, '%d,%d;', x+1, rpe(i,j)*2);
            x = x+2;
        end
        fprintf(fid, '\n');
    end
    fclose(fid);

end