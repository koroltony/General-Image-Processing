function [] = display4images(img_cell, title_str)

figure
subplot(2,2,1), subimage(img_cell{1});
subplot(2,2,2), subimage(img_cell{2});
subplot(2,2,3), subimage(img_cell{3});
subplot(2,2,4), subimage(img_cell{4});
set(gcf,'NextPlot','add');
axes;
h = title(title_str);
set(gca,'Visible','off');
set(h,'Visible','on');