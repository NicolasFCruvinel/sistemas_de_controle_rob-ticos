% Função para calcular o momento de inércia de um cilindro sólido
calculateCylindricalInertia = @(r, h, m) (1/12) * m * (3*r^2 + h^2);

% Definição dos parâmetros dos braços robóticos
r = 0.075/10; % Raio dos braços (m)

l1 = 1/10; % Comprimento do primeiro elo (m)
l2 = 1/10; % Comprimento do segundo elo (m)
l3 = 0.2/10; % Comprimento do terceiro elo (m)
save('comprimentos.mat', 'l1', 'l2', 'l3');

% Densidade do material em kg/m^3
rho = 2700; % Alumínio (kg/m^3)

% Calculando volume e massa de cada elo
V1 = pi * r^2 * l1; % Volume do primeiro elo (m^3)
m1 = rho * V1; % Massa do primeiro elo (Kg)

V2 = pi * r^2 * l2; % Volume do segundo elo (m^3)
m2 = rho * V2; % Massa do segundo elo (kg)

V3 = pi * r^2 * l3; % Volume do terceiro elo (m^3)
m3 = rho * V3; % Massa do terceiro elo (kg)
save('massas.mat', 'm1', 'm2', 'm3');

% Calculando momentos de inércia Ixx, Iyy, Izz
Ixx1 = calculateCylindricalInertia(r, l1, m1); % Momento de inércia do primeiro elo em torno de x (kg*m^2)
Iyy1 = calculateCylindricalInertia(r, l1, m1); % Momento de inércia do primeiro elo em torno de y (kg*m^2)
Izz1 = (1/2) * m1 * r^2; % Momento de inércia do primeiro elo em torno de z (kg*m^2)
save('momentosElo1.mat', 'Ixx1', 'Iyy1', 'Izz1');

Ixx2 = calculateCylindricalInertia(r, l2, m2); % Momento de inércia do segundo elo em torno de x (kg*m^2)
Iyy2 = calculateCylindricalInertia(r, l2, m2); % Momento de inércia do segundo elo em torno de y (kg*m^2)
Izz2 = (1/2) * m2 * r^2; % Momento de inércia do segundo elo em torno de z (kg*m^2)
save('momentosElo2.mat', 'Ixx2', 'Iyy2', 'Izz2');

Ixx3 = calculateCylindricalInertia(r, l3, m3); % Momento de inércia do terceiro elo em torno de x (kg*m^2)
Iyy3 = calculateCylindricalInertia(r, l3, m3); % Momento de inércia do terceiro elo em torno de y (kg*m^2)
Izz3 = (1/2) * m3 * r^2; % Momento de inércia do terceiro elo em torno de z (kg*m^2)
save('momentosElo3.mat', 'Ixx3', 'Iyy3', 'Izz3');

% Mostrando os resultados
disp('Momentos de inércia do primeiro elo (elo 1):');
disp(['Ixx: ' num2str(Ixx1) ' kg.m^2, Iyy: ' num2str(Iyy1) ' kg.m^2, Izz: ' num2str(Izz1) ' kg.m^2, massa: ' num2str(m1) ' kg']);

disp('Momentos de inércia do segundo elo (elo 2):');
disp(['Ixx: ' num2str(Ixx2) ' kg.m^2, Iyy: ' num2str(Iyy2) ' kg.m^2, Izz: ' num2str(Izz2) ' kg.m^2, massa: ' num2str(m2) ' kg']);

disp('Momentos de inércia do terceiro elo (elo 3):');
disp(['Ixx: ' num2str(Ixx3) ' kg.m^2, Iyy: ' num2str(Iyy3) ' kg.m^2, Izz: ' num2str(Izz3) ' kg.m^2, massa: ' num2str(m3) ' kg']);