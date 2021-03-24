path = importdata('./path.txt');
feature = do_rgbcolor(path{1});
feature2 = do_rgbcolor(path{2});
feature3 = [feature;feature2];

feature  = [];

for i=1:length(path)
 feature_tmp =  do_rgbcolor(path{i}) ;
 feature = [feature;feature_tmp];
end
csvwrite('rgb.csv',feature);