function [meuRobo, configuracoes] = criarRobo()
    % Carregar os dados necessários
    load('comprimentos.mat', 'l1', 'l2', 'l3');
    load('massas.mat', 'm1', 'm2', 'm3');
    load('momentosElo1.mat', 'Ixx1', 'Iyy1', 'Izz1');
    load('momentosElo2.mat', 'Ixx2', 'Iyy2', 'Izz2');
    load('momentosElo3.mat', 'Ixx3', 'Iyy3', 'Izz3');

    % Inicializando o robô
    meuRobo = rigidBodyTree('DataFormat', 'row');

    % Definindo o corpo base do robô
    corpoBase = rigidBody('base_base');

    % Juntas e links
    % Link 1 - Junta Revoluta
    link1 = rigidBody('link1');
    junta1 = rigidBodyJoint('j1', 'revolute');
    setFixedTransform(junta1, [0.1 0 0 0], 'dh'); % DH: [a alpha d theta]
    junta1.PositionLimits = deg2rad([-75 0]); % Limites de posição em graus
    link1.Joint = junta1;

    % Definindo a inércia do Link 1
    link1.Mass = m1; % Massa em kg
    link1.CenterOfMass = [0, 0, l1/2]; % Centro de massa em metros
    link1.Inertia = [Ixx1, Iyy1, Izz1, 0, 0, 0]; % Inércia [Ixx Iyy Izz Iyz Ixz Ixy]

    % Link 2 - Junta Revoluta
    link2 = rigidBody('link2');
    junta2 = rigidBodyJoint('j2', 'revolute');
    setFixedTransform(junta2, [0.1 0 0 0], 'dh'); % DH: [a alpha d theta]
    junta2.PositionLimits = deg2rad([0 150]); % Limites de posição em graus
    link2.Joint = junta2;

    % Definindo a inércia do Link 2
    link2.Mass = m2; % Massa em kg
    link2.CenterOfMass = [0, 0, l2/2]; % Centro de massa em metros
    link2.Inertia = [Ixx2, Iyy2, Izz2, 0, 0, 0]; % Inércia [Ixx Iyy Izz Iyz Ixz Ixy]

    % Link 3 - Junta Revoluta
    link3 = rigidBody('link3');
    junta3 = rigidBodyJoint('j3', 'revolute');
    setFixedTransform(junta3, [0.02 0 0 0], 'dh'); % DH: [a alpha d theta]
    junta3.PositionLimits = deg2rad([0 90]); % Limites de posição em graus
    link3.Joint = junta3;

    % Definindo a inércia do Link 3
    link3.Mass = m3; % Massa em kg
    link3.CenterOfMass = [l3/2, 0, 0]; % Centro de massa em metros
    link3.Inertia = [Ixx3, Iyy3, Izz3, 0, 0, 0]; % Inércia [Ixx Iyy Izz Iyz Ixz Ixy]

    % Montando o robô
    addBody(meuRobo, corpoBase, 'base');
    addBody(meuRobo, link1, 'base');
    addBody(meuRobo, link2, link1.Name);
    addBody(meuRobo, link3, link2.Name);

    % Configurações do robô
    configuracoes.inicial = [0, 0, 0]; % Todas as juntas na posição inicial
    configuracoes.extendido = [0, 0, 0]; % Configuração estendida
    configuracoes.contraido = deg2rad([-75, 150, 30]); % Configuração contraída

    % Adicionando Malhas STL para Renderização (se disponível)
     link1.addVisual('Mesh', 'caminho/para/link1.stl');
     link2.addVisual('Mesh', 'caminho/para/link2.stl');
     link3.addVisual('Mesh', 'caminho/para/link3.stl');

    % Exemplo de uso:
     %[meuRobo, configuracoes] = criarRobo();
     %showdetails(meuRobo);
     %show(meuRobo, configuracoes.extendido);
end
