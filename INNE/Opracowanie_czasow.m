combineCSVFiles('WYNIKI_CAVRI/adnet_result/adnet','nieodszumione_czasy_segmentacji.csv')
times_z_zerami = readCSVAsVectors('nieodszumione_czasy_segmentacji.csv');
times = [];
for i = 1:size(times_z_zerami.Times)
    if times_z_zerami.Times(i)>0
        times = [times,times_z_zerami.Times(i)];
    end
end
mean_time = mean(times)
min_time = min(times)
max_time = max(times)
ile = size(times,2)
procent = ile/7050*100