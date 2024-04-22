function [] = display4hist(img_cell, title_str)

figure
xbins = 0:255;
ax1 = subplot(2,2,1);
hist(ax1,img_cell{1}(:),xbins);
ax2 = subplot(2,2,2);
hist(ax2,img_cell{2}(:),xbins);
ax3 = subplot(2,2,3);
hist(ax3,img_cell{3}(:),xbins);
ax4 = subplot(2,2,4);
hist(ax4,img_cell{4}(:),xbins);

set(gcf,'NextPlot','add');
axes;
h = title(title_str);
set(gca,'Visible','off');
set(h,'Visible','on');