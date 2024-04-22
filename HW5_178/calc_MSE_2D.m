function MSE = calc_MSE_2D(conv_res_1, conv_res_2)

diff = conv_res_1 - conv_res_2;
diff_sq = diff.*diff;
MSE = sum(diff_sq(:))/(size(conv_res_1,1)*size(conv_res_1,1));

end