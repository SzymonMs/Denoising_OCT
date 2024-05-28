myDir = 'layers_segmentations';
filePattern = fullfile(myDir);
ext         =  {'*.json',};
myFiles   =  [];
for i = 1 : length(ext)
    myFiles = cat(1,myFiles, dir(fullfile(myDir,ext{i})));
end
numberOfFiles = length(myFiles);
for k = 1:length(myFiles)
      baseFileName = myFiles(k).name;
      fullFileName = fullfile(myDir, baseFileName);
      fname = fullFileName; 
      fid = fopen(fname); 
      raw = fread(fid,inf); 
      str = char(raw'); 
      fclose(fid); 
      struct = jsondecode(str);
      for i = 1:141
        data = {};
        data.PCV = struct.PCV(i,:);
        data.ILM = struct.ILM(i,:);
        data.RNFL_GCL = struct.RNFL_GCL(i,:);
        data.IPL_INL = struct.IPL_INL(i,:);
        data.INL_OPL = struct.INL_OPL(i,:);
        data.OPL_HFL = struct.OPL_HFL(i,:);
        data.BMEIS = struct.BMEIS(i,:);
        data.IS_OSJ = struct.IS_OSJ(i,:);
        data.IB_RPE = struct.IB_RPE(i,:);
        data.OB_RPE = struct.OB_RPE(i,:);
        pathname = strcat('layers_segmentations_JSON/',baseFileName(1:end-5));
        if ~exist(pathname, 'dir')
            mkdir(pathname);
        end
        name = strcat(pathname,'/Skan_nr_',num2str(i),'.mat')
        save(name,'data')
       end

end

% fname = 'layers_segmentations/VMA_0001S_20160715103809.json'; 
% fid = fopen(fname); 
% raw = fread(fid,inf); 
% str = char(raw'); 
% fclose(fid); 
% struct = jsondecode(str);
% for i = 1:141
%     data = {};
%     data.PCV = struct.PCV(i,:);
%     data.ILM = struct.ILM(i,:);
%     data.RNFL_GCL = struct.RNFL_GCL(i,:);
%     data.IPL_INL = struct.IPL_INL(i,:);
%     data.INL_OPL = struct.INL_OPL(i,:);
%     data.OPL_HFL = struct.OPL_HFL(i,:);
%     data.BMEIS = struct.BMEIS(i,:);
%     data.IS_OSJ = struct.IS_OSJ(i,:);
%     data.IB_RPE = struct.IB_RPE(i,:);
%     data.OB_RPE = struct.OB_RPE(i,:);
%     name = strcat('TEST/Skan_nr_',num2str(i),'.mat')
%     save(name,'data')
% 
% end