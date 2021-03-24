
%% Initialization
clear ; close all; clc


path = ''
%% =========== Part 1: Loading  Data =============
for j=1:9
    fprintf('Loading  Data ...\n')
    
    if(j==1)
        P = '../add2/Cotton/';
    elseif(j==2)
        P = '../add2/Denim/';
    elseif(j==3)
        P = '../add2/Fleece/';
    elseif(j==4)
         P = '../add2/Nylon/';
     elseif(j==5)
        P = '../add2/Polyester/';   
    elseif(j==6)
         P = '../add2/Silk/';    
    elseif(j==7)
        P = '../add2/Terrycloth/';       
    elseif(j==8)
        P = '../add2/Viscose/';
    elseif(j==9)
        P ='../add2/Wool/';    
    end
    D = dir([P '*.png']);
    
    %% =========== Part 2: Extract  SiftFea =============
    for i = 1 : length(D)
        if(j==1)
            material1{i}='cotton';
            material1=material1';
            D1=D;
        elseif(j==2)

            material2{i}='denim';
            material2=material2';
            D2=D;
        elseif(j==3)
            material3{i}='fleece';
            material3=material3';
            D3=D;
        elseif(j==4)

            material4{i}='nylon';
            material4=material4';
            D4=D;
        elseif(j==5)

            material5{i}='polyester';
            material5=material5';
            D5=D;
        elseif(j==6)

            material6{i}='silk';
            material6=material6';
            D6=D;
        elseif(j==7)

            material7{i}='terrycloth';
            material7=material7';         
            D7=D;
        elseif(j==8)

            material8{i}='viscose';      
            material8=material8';
            D8=D;
        elseif(j==9)
            
            material9{i}='wool';
            material9=material9';
            D9=D;
        end
        fprintf('Finished:%dï¼?%d\n',j,i);
    end
end
material=[material1;material2;material3';material4;material5;material6;material7;material8';material9];
Dir=[D1;D2;D3;D4;D5;D6;D7;D8;D9];
save('.\hog_gan_result\hog_labels2.mat','material');
% save('.\result\ALLSiftFea_add2.mat','-v7.3','SiftFeats','SiftFeats_cotton','SiftFeats_denim','SiftFeats_fleece','SiftFeats_nylon','SiftFeats_polyester','SiftFeats_silk','SiftFeats_terrycloth','SiftFeats_viscose','SiftFeats_wool');