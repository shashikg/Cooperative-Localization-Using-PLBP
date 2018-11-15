function [ui, Wi] = doBP_Marginal(A, b, sigma, u, W, k, E, z, R)
  for p=1:113
    if (E(p,k)&&(p!=k))
      
      alpha = z(p,k) - A(:,1:2,p,k)*(transpose(u(p,:))) - b(p,k);
      H = A(:,3:4,p,k);
      T = R + sigma(p,k) + A(:,1:2,p,k)*W(:,:,k)*transpose(A(:,1:2,p,k));
      
      ze = H*(u(k,:)');
      S = H*W(:,:,k)*(H') + T;
      shi = W(:,:,k)*(H');
      a = u(k,:)' + shi*(S^(-1))*(alpha - ze);
      Ae = W(:,:,k) - shi*(S^(-1))*(shi');
      
      u(k,:) = a';
      W(:,:,k) = Ae;
    end
  end
  ui = u(k,:);
  Wi = W(:,:,k);
end
    