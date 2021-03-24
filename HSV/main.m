path = importdata('./path.txt');

feature  = [];

for i=1:length(path)

     fprintf("%d : %d\n", i, length(path)  );
     img = imread(path{i});
     feature_tmp =  histHSV(img) ;
     feature = [feature;feature_tmp];
end
csvwrite('hsv.csv',feature);