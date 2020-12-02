%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%      Laboratório Virtual de MPS43 - Sistemas de Controle      %
%       --- Carro sobre Trilhos com Pêndulo Invertido ---       %
%                                                               %
%    Autores: João Filipe R. P de A. Silva e Davi A. Santos     %
%                                                               %
%       Script de Inicialização de Parâmetros Constantes        %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARÂMETROS DO CARRO E DO PÊNDULO                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m_pen = 0.15;       %Massa do Pêndulo [kg]
m_cart = 0.8;     %Massa do Carro [kg]
l_pen = 0.3 ;     %Comprimento do Pêndulo [m]
g = 9.81;           %Gravidade [kg*m/s²]
Ts = 0.02;          %Período de Amostragem [s]
mu_s = 0.08;        %Coeficiente de Atrito Estático [no unit]
mu_c = 0.04;        %Coeficiente de Atrito Dinâmico [no unit]
eta = 2.5;          %Coeficiente de Atrito Viscoso [kg/s]
I_haste = 1/3*m_pen*(l_pen)^2; %Momento de Inércia do Pêndulo [kg*m²]


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PARÂMETROS DE COMUNICAÇÃO                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TCP socket com Unity 3D

ip_unity   = '127.0.0.1'; 
port_unity = 55001;
tout_unity = 10;
role_unity = 'Client';

