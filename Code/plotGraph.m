%% To plot the graphs with all nodes and vertices --------
% Inputs: V - Nodes/ Vertex
%           E - edges

function plotGraph(V, E)
  for i = 1:113
    for j = 1:113
      if E(i,j)
        hold on;
        plot([V(i,1) V(j,1)], [V(i,2) V(j,2)], 'o-b', 'LineWidth', 1);
      end
    end
  end
  plot(V(101:113,1), V(101:113,2), 'xr', 'LineWidth', 5);
  grid on
end
