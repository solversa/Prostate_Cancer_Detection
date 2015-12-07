function [modified_images,filenames] = modify_images(write_flag,input_dir_name,modified_dir_name)
    [image_data,~,filenames, img_x, img_y, numcolors] = load_data(input_dir_name,1);
    [~,total_images] = size(image_data);
    image_data = image_data.';
    image_data = reshape(image_data,total_images,img_x,img_y,numcolors);
    modified_images = zeros(total_images,img_x,img_y,numcolors);
    for i=1:total_images
        modified_images(i,:,:,:) = imadjust(squeeze(image_data(i,:,:,:)),[0.3 0.3 0.3; 1 1 1], [0.1 0.1 0.1; 1 1 1]) * 2;
        if write_flag == 1
            imwrite(squeeze(modified_images(i,:,:,:)), strcat(modified_dir_name, filenames{i}));
        end
    end