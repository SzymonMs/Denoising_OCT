x = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14'};
y = [23.13
21.52
11.55
11.35
11.48
4.05
29.07
45.90
49.44
46.26
42.46
10.68
28.34
6.70
];

b = bar(y, 'FaceColor', 'flat');
set(gca, 'XTickLabel', x, 'XTick', 1:numel(x));

b.CData(1, :) = [0 0.4470 0.7410];
b.CData(2, :) = [0.6350 0.0780 0.1840];
b.CData(3, :) = [0.6350 0.0780 0.1840];
b.CData(4, :) = [0.6350 0.0780 0.1840];
b.CData(5, :) = [0.6350 0.0780 0.1840];
b.CData(6, :) = [0.6350 0.0780 0.1840];
b.CData(7, :) = [0.8500 0.3250 0.0980];
b.CData(8, :) = [0.8500 0.3250 0.0980];
b.CData(9, :) = [0.8500 0.3250 0.0980];
b.CData(10, :) = [0.8500 0.3250 0.0980];
b.CData(11, :) = [0.8500 0.3250 0.0980];
b.CData(12, :) = [0.9290 0.6940 0.1250];
b.CData(13, :) = [0.9290 0.6940 0.1250];
b.CData(14, :) = [0.9290 0.6940 0.1250];


title('warstwa RPE')
ylabel('�redni b��d')