clear;close all;
load data.mat

for i=1:100
  P(:,:,i) = 100.*eye(2);
end

for i=101:113
  P(:,:,i) = 0.01.*eye(2);
end

R = 1;
J = 20;
u = x_observed;
W = P;
M = 1;

A(:,:,113,113) = zeros(1,4);
b = zeros(113,113);
sigma = zeros(113,113);

Error = x_actual - u;
RMSE = sqrt(sum(sum(Error.*Error))/113);

for k=1:20
  waitbar(k/20)
  for i=1:113
    for j=1:113
      if E(i,j)&&(i!=j)
        _ul = transpose([u(i,:), u(j,:)]);
        _Wl = [W(:,:,i),zeros(2,2);zeros(2,2),W(:,:,j)];
        [A(:,:,i,j), b(i,j), sigma(i,j)] = doSLR(_ul, _Wl); 
      end
    end
  end  
  
  for m=1:1
    for r=1:113
      [u(r,:), W(:,:,r)] = doBP_Marginal(A, b, sigma, u, W, r, E, h_observed, R);
    end
  end
  
  Error = x_actual - u;
  RMSE(:,k+1) = sqrt(sum(sum(Error.*Error))/113);
end

RMSE
