function [tempo, posicao, velocidade, aceleracao] = gerarPerfilVelocidadeTrapezoidal(distancia, vel_max, acel, dt)
    tempo_acel = vel_max / acel;                % Tempo para acelerar até vel_max
    dist_acel = 0.5 * acel * tempo_acel^2;      % Distância coberta durante a aceleração

    if 2 * dist_acel > distancia
        dist_acel = distancia / 2;
        vel_max = sqrt(2 * acel * dist_acel);
        tempo_acel = vel_max / acel;
    end

    dist_const = distancia - 2 * dist_acel;         % Distância da fase de velocidade constante
    tempo_const = dist_const / vel_max;             % Tempo da fase de velocidade constante
    tempo_total = 2 * tempo_acel + tempo_const;     % Tempo total do movimento

    tempo = 0:dt:tempo_total;                  
    posicao = zeros(size(tempo));              
    velocidade = zeros(size(tempo));           
    aceleracao = zeros(size(tempo));           

    % Calcular as trajetórias
    for i = 1:length(tempo)
        if tempo(i) < tempo_acel
            aceleracao(i) = acel;
            velocidade(i) = acel * tempo(i);
            posicao(i) = 0.5 * acel * tempo(i)^2;
        elseif tempo(i) < (tempo_acel + tempo_const)
            aceleracao(i) = 0;
            velocidade(i) = vel_max;
            posicao(i) = dist_acel + vel_max * (tempo(i) - tempo_acel);
        else
            aceleracao(i) = -acel;
            velocidade(i) = vel_max - acel * (tempo(i) - (tempo_acel + tempo_const));
            posicao(i) = dist_acel + dist_const + vel_max * (tempo(i) - tempo_acel - tempo_const) - 0.5 * acel * (tempo(i) - tempo_acel - tempo_const)^2;
        end
    end

    % Criar figura para os gráficos
    figura = figure;
    subplot(3,1,1);
    plot(tempo, posicao, 'LineWidth', 2);
    title('Perfil de Posição');
    xlabel('Tempo (s)');
    ylabel('Posição (rad)');
    
    subplot(3,1,2);
    plot(tempo, velocidade, 'LineWidth', 2);
    title('Perfil de Velocidade');
    xlabel('Tempo (s)');
    ylabel('Velocidade (rad/s)');
    
    subplot(3,1,3);
    plot(tempo, aceleracao, 'LineWidth', 2);
    title('Perfil de Aceleração');
    xlabel('Tempo (s)');
    ylabel('Aceleração (rad/s^2)');
    
    % Melhorar a visibilidade do gráfico
    grid on;
    sgtitle('Perfil de Movimento Trapezoidal'); % Título geral para todos os subplots
    
    % Criar o objeto que armazena as informaçoes da trajetoria
    Trajetoria.time = tempo;
    Trajetoria.signals.values = [posicao', velocidade'];
    Trajetoria.signals.dimensions = 2;
    save('Trajetoria.mat', 'Trajetoria');
end




