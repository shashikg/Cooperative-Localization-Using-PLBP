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

%m = 1;
%n = 2;
%_u = transpose([u(m,:), u(n,:)]);
%_W = [W(:,:,m),zeros(2,2);zeros(2,2),W(:,:,n)];

for k=1:J
  
  for i=1:113
    for j=1:i-1
      if E(i,j)
        %_ul = transpose([u(i,:), u(j,:)]);
        %_Wl = [W(:,:,i),zeros(2,2);zeros(2,2),W(:,:,j)];
        %[A(:,:,i,j), b(i,j), sigma(i,j)] = doSLR(_ul, _Wl); 
      end
    end
  end
  
  for m=1:M
    for i=1:113
      for j=1:i-1
        if E(i,j)
          [u(i,:), u(j,:), W(:,:,i), W(:,:,j)] = doBP(A, b, sigma, u, W, i, j, E, h_observed, R);
        end
      end
    end
  end
  
end

plotGraph(u, E)