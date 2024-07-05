%% PARAMETROS DO MOTOR

Km = 0.228
Bm = 817e-6
Jm = 200e-6

G = 107.83

Tmax = 0.9
wmax = 165

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
[C, info] = pidtune(ft_motor, 'PI')

Ts = 0.001
Kp = C.Kp
Ki = C.Ki

%%CONTROLE FEED-FORWARD

Kff = 1

%%parametro controlador de pos

vel_loop = C*ft_motor

[C2, info] = pidtune(vel_loop, 'PI')

Kpp = C2.Kp
Kii = C2.Ki

%% GERADOR DE TRAJETORIAS

dt = Ts
vel_max = wmax/G

t_acel = 1
acel = vel_max/t_acel

distancia = 250/G

[tempo, posicao, velocidade, aceleracao] = gerarPerfilVelocidadeTrapezoidal(distancia, vel_max, acel, dt)