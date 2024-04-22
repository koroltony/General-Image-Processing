function [] = display2images(img_cell, title_str)

figure
subplot(1,2,1), subimage(img_cell{1});
subplot(1,2,2), subimage(img_cell{2});
set(gcf,'NextPlot','add');
axes;
h = title(title_str);
set(gca,'Visible','off');
set(h,'Visible','on');