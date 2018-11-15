% Generate required data ------------------------------------------------------
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