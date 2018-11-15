function [A, b, sigma] = doSLR(ul, Wl)
  N = 4;
  X = zeros(4,9);
  % Sigma Points and Corresponding Weight Generation --------------------------
  X(:,1) = ul;
  w1 = 1/3;
  wo = (1-w1)./(2.*N);
  T = chol(Wl);
  f = (N/(1-w1))^(1/2);

  for i=2:5
    X(:,i) = ul + f.*(T(i-1,:)');
    X(:,i+N) = ul - f.*(T(i-1,:)');
  end
  
  
  Z = sqrt((X(1,:) - X(3,:)).^2 + (X(2,:) - X(4,:)).^2);
  z = w1.*Z(:,1) + wo.*sum(Z(:,2:9));
  
  shi = w1.*(X(:,1) - ul).*(Z(:,1) - z);
  for j=2:9
    shi = shi + wo.*(X(:,j) - ul).*(Z(:,j) - z);
  end
  
  phi = w1.*(Z(:,1) - z).*(Z(:,1) - z);
  for j=2:9
    phi = phi + w1.*(Z(:,j) - z).*(Z(:,j) - z);
  end
    
  A = (shi')*(Wl^(-1));
  b = z - A*ul;
  sigma = phi - A*Wl*(A');
  
end

  