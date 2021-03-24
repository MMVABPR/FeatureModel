path = importdata('./path.txt');

feature = do_labcolour(path{1});
feature2 =do_labcolour(path{2});
feature3 = [feature;feature2];

feature  = [];

for i=1:length(path)
 feature_tmp =  do_labcolor(path{i}) ;
 feature = [feature;feature_tmp];
end
csvwrite('lab.csv',feature);