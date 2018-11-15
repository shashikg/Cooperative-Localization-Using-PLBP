function [_A, _b, _sigma] = doSLR(_ul, _Wl)
  N = 4;
  X = zeros(4,9);
  % Sigma Points and Corresponding Weight Generation --------------------------
  X(:,1) = _ul;
  w1 = 1/3;
  wo = (1-w1)./(2.*N);
  T = chol(_Wl);
  f = (N/(1-w1))^(1/2);

  for i=2:5
    X(:,i) = _ul + f.*(T(i-1,:)');
    X(:,i+N) = _ul - f.*(T(i-1,:)');
  end
  
  
  Z = sqrt((X(1,:) - X(3,:)).^2 + (X(2,:) - X(4,:)).^2);
  z = w1.*Z(:,1) + wo.*sum(Z(:,2:9));
  
  shi = w1.*(X(:,1) - _ul).*(Z(:,1) - z);
  for j=2:9
    shi = shi + wo.*(X(:,j) - _ul).*(Z(:,j) - z);
  end
  
  phi = w1.*(Z(:,1) - z).*(Z(:,1) - z);
  for j=2:9
    phi = phi + w1.*(Z(:,j) - z).*(Z(:,j) - z);
  end
    
  _A = (shi')*(_Wl^(-1));
  _b = z - _A*_ul;
  _sigma = phi - _A*_Wl*(_A');
  
end

  