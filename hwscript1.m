clear

image = imread('test1.tif');
%imshow(image)

m = 7;
n = 7;
proc_image = localhisteq(image, m,n);
proc_mat_image = histeq(image);


folder = '\\apporto.com\dfs\IIT\Users\amaliwat_iit\Documents\MATLAB\ECE565';
imshow(proc_image)
%imwrite(proc_image, fullfile(folder, sprintf('proc_image%dx%d.tif',m,n)));
%imshow(proc_mat_image)
imwrite(proc_mat_image, fullfile(folder, 'mat_proc_image.tif'));

