function [total_error, x_error, y_error, z_error] = RMSe(actual,expected)

    n = size(actual);

    x_sum = 0; y_sum = 0; z_sum = 0; total_sum = 0;
    for i=1:5
        %finding total distance error
        total_sum = total_sum + sqrt(((actual(i,1)-expected(i,1))^2 + ...
                    (actual(i,3)-expected(i,3))^2 + (actual(i,2)-expected(i,2))^2));
        %finding the error in the x-axis
        x_sum = x_sum + (actual(i,1)-expected(i,1))^2;
        %finding the error in the y-axis
        y_sum = y_sum + (actual(i,2)-expected(i,2))^2;
        %finding the error in the z-axis
        z_sum = z_sum + (actual(i,3)-expected(i,3))^2;
    end

    x_error = sqrt(x_sum/n(1));
    y_error = sqrt(y_sum/n(1));
    z_error = sqrt(z_sum/n(1));
    total_error = total_sum/n(1);
    
end