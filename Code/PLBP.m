%% Main PLBP Algorithm -------------------------------------------------
%% Node (1 to 100 - Normal Nodes) and (101 to 113 - Anchor Nodes) ------

clear;

% Load the generated data --------
load data.mat

% Setting up variance for different measured data ---------------------
for i=1:100
  P(:,:,i) = 100.*eye(2);
end

for i=101:113
  P(:,:,i) = 0.01.*eye(2);
end

R = 1;
J = 20;
%----------------------------------------------------------------------

% Run four iterations for 1 PLBP, 2 PLBP, 5 PLBP and 10 PLBP, where M PLBP means M BP iterations.
for M=[1 2 5 10]
  u = x_observed;
  W = P;

  A(:,:,113,113) = zeros(1,4);
  b = zeros(113,113);
  sigma = zeros(113,113);
  Error = x_actual - u;
  RMSE = sqrt(sum(sum(Error.*Error))/113);

  % No of iteration for PLBP i.e. J times -------------------------------
  for k=1:J
    waitbar(k/20)

    % Run SLR Algorithm for i,j edges --------------------------------------
    for i=1:113
      for j=1:113
        if E(i,j)&&(i~=j)
          ul = transpose([u(i,:), u(j,:)]);
          Wl = [W(:,:,i),zeros(2,2);zeros(2,2),W(:,:,j)];
          [A(:,:,i,j), b(i,j), sigma(i,j)] = doSLR(ul, Wl);
        end
      end
    end
    % ----------------------------------------------------------------------

    % Run BP for M times for every nodes from 1 to 113 ----------------------
    for m=1:M
      for r=1:113
        [u(r,:), W(:,:,r)] = doBP(A, b, sigma, u, W, r, E, h_observed, R);
      end
    end
    % ---------------------------------------------------------------------

    Error = x_actual - u;
    RMSE(:,k+1) = sqrt(sum(sum(Error.*Error))/113);
  end

  hold on;
  plot(1:21,RMSE(:,1:21),'o-', 'LineWidth', 1);
end


legend('PLBP M = 1', 'PLBP M = 2', 'PLBP M = 5', 'PLBP M = 10')

title('RMS Error Against Number of Iterations');
xlabel('Number of Iterations')
ylabel('RMS Position Error (m)')
grid on;

figure(2)
plotGraph(x_actual,E)
title('Actual Positions of Nodes');
xlim([-10 110])
ylim([-10 110])
xlabel('x (m)')
ylabel('y (m)')

figure(3)
plotGraph(x_observed,E)
title('Measured Position of Nodes');
xlim([-10 110])
ylim([-10 110])
xlabel('x (m)')
ylabel('y (m)')

figure(4)
plotGraph(u,E)
title('Estimated Positions of Nodes');
xlim([-10 110])
ylim([-10 110])
xlabel('x (m)')
ylabel('y (m)')
