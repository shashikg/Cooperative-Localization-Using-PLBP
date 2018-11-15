%% This function is to generate the required positions of nodes to setup the model.
% Output: data.mat = matlab workspace file which will contain the node positions
% x_actual - Actual position of nodes
% x_observed - Measured position of nodes i.e. a gaussian noise is added to actual positions
% h_actual, h_observed - Message (Distance) between two nodes, actual and with noise(measure) respectively
% E - Matrix giving information about which node can communicate with each other ie. distance between them is within 20m
% E(i,j) = 0 for no communication between i and j nodes, E(i,j) = 1 for communication between i and j nodes.
%----------------------------------------------------------------------------------------------------------------

clear;

Xa = [16.666,50,83.333,33.333,66.666,16.666,50,83.333,33.33,66.66,16.666,50,83.33];
Ya = [16.666,16.666,16.666,33.333,33.333,50,50,50,66.66,66.66,83.333,83.33,83.33];

x_actual = zeros(113, 2);
x_actual(1:100,:) = 100.*rand(100,2);
x_actual(101:113,:) = [transpose(Xa), transpose(Ya)];

x_observed = zeros(113, 2);
x_observed(1:100,:) = x_actual(1:100,:) + 10.0.*randn(100, 2);
x_observed(101:113,:) = x_actual(101:113,:) + 0.1.*randn(13, 2);

h_actual = zeros(113,113);
E = zeros(113,113);
for i = 1:113
  for j = 1:113
    h_actual(i,j) = norm(x_actual(i,:) - x_actual(j,:));
    if h_actual(i,j) <= 20.0
      E(i,j) = 1;
    end
  end
end

h_observed = h_actual + 1.*randn(113, 113);

save data.mat
