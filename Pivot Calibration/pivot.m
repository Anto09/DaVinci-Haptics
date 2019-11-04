function [P_tip, P_post, RMS, RMS_xyz ] = pivot( T )
%pivot Returns a calibrated pivot point
%   Detailed explanation goes here

%% Using the Least Squares Solution Discussed in class

% Find the length of T to make the code a little more modular
n = length(T);

% Create the stacked matrices for each Transformation matrix
c=0;
for i=1:n
    P(3*c+1) = T(1,4,i);
    P(3*c+2) = T(2,4,i);
    P(3*c+3) = T(3,4,i);
    A(3*c+1,:) = [T(1,1:3,i) -1 0 0];
    A(3*c+2,:) = [T(2,1:3,i) 0 -1 0];
    A(3*c+3,:) = [T(3,1:3,i) 0 0 -1];
    c = c + 1;
end

% Compute the least squares fit using the psuedo inverse
x = pinv(A)*(-P');

% Break the x vector into p_tip and p_post
P_tip = x(1:3);
P_post = x(4:6);

% Compute the RMS error
x_post_sum = 0; y_post_sum = 0; z_post_sum = 0; total_sum = 0;
for i=1:n
    %run the equation p_post = T*p_tip for each T
    error = T(:,:,i)*[P_tip; 1];
    
    %finding total distance error
    total_sum = total_sum + sqrt(((error(1)-P_post(1))^2 + (error(3)-P_post(3))^2 + (error(2)-P_post(2))^2));
    %finding the error in the x-axis
    x_post_sum = x_post_sum + (error(1)-P_post(1))^2;
    %finding the error in the y-axis
    y_post_sum = y_post_sum + (error(2)-P_post(2))^2;
    %finding the error in the z-axis
    z_post_sum = z_post_sum + (error(3)-P_post(3))^2;
end

% Report the RMS error for the total distance and the x,y,and z axes
RMS_xyz = [ sqrt(x_post_sum/n) sqrt(y_post_sum/n) sqrt(z_post_sum/n) ];
RMS = total_sum/n;
end

