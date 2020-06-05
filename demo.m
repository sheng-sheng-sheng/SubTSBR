%--------------------------------------------------------------------------
% Example: fish-harvesting problem with bifurcations
%--------------------------------------------------------------------------
% dx/dt = x(4-x) - 3
%--------------------------------------------------------------------------
%% initialization
clc, close all, clear all
addpath('./RVM');
rng(0); rand(2);

%% parameters
n_grid = 20;         % grid size for arrows
n_curve_data = 5;    % number of curves in the data
n_step_data = 20;    % number of time steps in the data

%% velocity field
[t_all,x_all] = meshgrid(linspace(0,4,n_grid),linspace(0,4,n_grid));
dt_all = ones(size(t_all));
dx_all = x_all.*(4-x_all) - 3;

%% generate data
t_data = linspace(0,2,n_step_data);      % row vector
x0_data = 1 + 2*rand(n_curve_data,1);    % column vector
x_data = zeros(n_curve_data,n_step_data);

figure
quiver(t_all,x_all,dt_all,dx_all,'Color',[0.9290 0.6940 0.1250])
hold on
for k1 = 1:n_curve_data
    [~,x_] = ode45(@(t,x) x*(4-x) - 3, t_data, x0_data(k1));
    x_data(k1,1:size(x_,1)) = max(x_',0);
    plot(t_data,x_data(k1,:),'ko','LineWidth',1,'MarkerSize',3)
    hold on
end
xlabel('t')
ylabel('N')
xlim([0 4])
ylim([0 4])
legend('velocity field for true model','data','Location','south')

%% discover ODE
t_ode = []; x_ode = []; dx_ode = [];
for k1 = 1:n_curve_data
    t_ode = [t_ode; t_data(3:end-2)'];
    x_ode = [x_ode; x_data(k1,3:end-2)'];
    dx_ode = [dx_ode; (x_data(k1,1:end-4)' - 8*x_data(k1,2:end-3)' + 8*x_data(k1,4:end-1)'...
        - x_data(k1,5:end)') / (12*(t_data(2)-t_data(1)))];
end

degree = 10;
PHI = gen_phi([ones(size(t_ode)) t_ode x_ode], degree);
Basis = gen_basis(["" "t" "x"], degree);

[weight, standard_deviation, MSC] = SubTSBR(PHI, dx_ode, 0.1, round(size(dx_ode,1)/2), 30);
disp(['dxdt = ' output(Basis, weight, standard_deviation, MSC)])
