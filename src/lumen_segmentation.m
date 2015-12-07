close all
clear all
clc

% directories to read and write from
input_dir = './../pictures_data/complete3/';
output_dir = './../pictures_data/complete3_lumen/';
prob_image_dir = '../pictures_data/compelte3_lumen_probs/';

if (exist(output_dir) ~= 7)
	mkdir(output_dir)
end
if(exist(prob_image_dir)~=7)
    mkdir(prob_image_dir)
end

load('./../pixel_data.mat');
idx = randperm(size(epithelial_pixels, 1));
epithelial_pixels = epithelial_pixels(idx(1:600), :);
idx = randperm(size(lumen_pixels, 1));
lumen_pixels = lumen_pixels(idx(1:600), :);
idx = randperm(size(stroma_pixels, 1));
stroma_pixels = stroma_pixels(idx(1:600), :);
training_pixels = [lumen_pixels' epithelial_pixels' stroma_pixels'];
class_labels = [1*ones(size(lumen_pixels,1),1);2*ones(size(epithelial_pixels,1),1); 3*ones(size(stroma_pixels,1),1)];





[ image_data, ~, filenames, imgx, imgy, numcolors] = load_data( input_dir, 1);

for i = 1:length(filenames)
	im = reshape(image_data(:,i), imgx, imgy, numcolors);
	[class_probabilities, binary_lumen_image] = colorBasedSegmentation(training_pixels, class_labels, im, strcat(prob_image_dir,filenames{i}));
	imwrite(binary_lumen_image, strcat(output_dir, filenames{i}));
end

