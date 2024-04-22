
Img_d = double(img)/255;
EMap = myEnergyFunc(Img_d);

[E,S] = mySeamCarve_V(EMap);

disp(S);