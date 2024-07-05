%% PARAMETROS DO MOTOR

Km = 0.3924
Bm = 817e-6
Jm = 5.4e-6

G = 1

Tmax = 0.3924
wmax = 62.83

L = 0.8
M = 6

Jb = (L*L)*M/3

Jt = Jm + Jb/(G*G)

num = [Km]
den = [Jt Bm]

ft_motor = tf(num, den)

%% EFEITO GRAVITACIONAL
g = 9.81
tau_g = g*(L*L)*M/(6*G)
 
%% PARAMETROS CONTROLADOR DE VELOCIDADE
[C, info] = pidtune(ft_motor, 'PID')

Ts = 0.001
Kp = C.Kp
Ki = C.Ki
Kd = C.Kd

%%CONTROLE FEED-FORWARD

Kff = 1

%%parametro controlador de posicao

vel_loop = C*ft_motor

[C2, info] = pidtune(vel_loop, 'PID')

Kpp = C2.Kp
Kii = C2.Ki
Kdd = C2.Kd

%% GERADOR DE TRAJETORIAS

dt = Ts
vel_max = wmax/G

t_acel = 1
acel = vel_max/t_acel

distancia = 250/G

[tempo, posicao, velocidade, aceleracao] = gerarPerfilVelocidadeTrapezoidal(distancia, vel_max, acel, dt)
