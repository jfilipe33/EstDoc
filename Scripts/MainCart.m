%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%      Laboratório Virtual de MPS43 - Sistemas de Controle      %
%        --- Carro sobre Trilho com Pêndulo Invertido ---       %
%                                                               %
%    Autores: João Filipe R. P de A. Silva e Davi A. Santos     %
%                                                               %
%                Main Script: Carro sobre Trilhos               %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clear all
clc

ParInit2  %Script de parâmetros fixos

%% Parâmetros do Carro e do Pêndulo

cart.g = g;
cart.I = I_haste;
cart.l = l_pen;
cart.m = m_pen;
cart.M = m_cart;
cart.mu_s = mu_s;
cart.mu_c = mu_c;
cart.eta = eta;
cart.muFlag = 1;
cart.Fn = (cart.m+cart.M)*g;
cart.Fd = 0;                %Força de Distúrbio

%% Parâmetros de Comunicação

tcpipClient = tcpip(ip_unity,port_unity,'NetworkRole',role_unity); %Definindo propriedades da comunicação TCP
set(tcpipClient,'Timeout',tout_unity);

%% Parâmetros de Simulação

sim.tf = 15;   % Duração da Simulação [s]
sim.Ts = Ts ;   % Período de Amostragem [s]
sim.t = 0:sim.Ts:(sim.tf-sim.Ts); % Vetor temporal da simulação [s]        

%% Inicialização de Variáveis 

cart.u = 0;                  % Comando de Força;
cart.r = 0;                  % Posição do Carro [m]
cart.v = 0;                  % Velocidade do Carro [m/s]
cart.theta = 0.05*pi;        % Ângulo do Pêndulo [rad]
cart.theta_dot = 0;          % Velocidade Angular do Pêndulo [deg/s]

%% Ganhos de Controle dor Realimentação de Estados
g1 = 70;                     %70 p/ rápido - 50 p/ lento
g2 = 140;                    %140 p/ rápido - 100 p/ lento
g3 = 40.0;                   %40 p/ rápido - 20 p/ lento
g4 = 26;                     %26 p/ rápido - 26 p/ lento

%% Execution

for cont = 1:(sim.tf/sim.Ts) %Início do loop de simulação
    
    states = [cart.r cart.theta cart.v cart.theta_dot]';  %Definição do vetor de estados

    cart.u = g1*states(1) + g2*states(2) + g3*states(3) + g4*states(4); %Definição do comando de força
%     cart.u = 0; %Definição do comando de força
    
    if cont == 250
        cart.Fd = 200;      % Inserindo distúrbio positivo no instante cont = 250
    elseif cont == 500
        cart.Fd = -300;     % Inserindo distúrbio negativo no instante cont = 500
    else
        cart.Fd = 0;        % Anulando o disturbio para todos os outros instantes
    end
       
%    cart = friction(cart);          %Cálculo da força de Atrito 
%    cart.Fa = -cart.eta*states(3);    %Aproximação da força de atrito para um amortecimento proporcional a velocidade do carro  
   cart.Fa = 0;                    %Força de atrito nula
    
    %Integração Numérica das equações dinâmicas por Runge-Kutta
            
    k1 = sim.Ts*cartDyn(states,cart);
    k2 = sim.Ts*cartDyn(states+k1/2,cart);
    k3 = sim.Ts*cartDyn(states+k2/2,cart);         
    k4 = sim.Ts*cartDyn(states+k3,cart); 
    states  = states + k1/6 + k2/3 + k3/3 + k4/6;
    
    histStates(cont,1:4) = states;  %Salvando histórico dos estados
    histStates(cont,5) = cart.Fa;   %Salvando histórico da Força de Atrito
    
    %Atualização dos Estados
            
    cart.r = states(1);             
    cart.theta = states(2);
    cart.v = states(3);
    cart.theta_dot = states(4);
    
    %Variáveis a serem plotadas
    
    cartpos(cont) = cart.r;
    cartang(cont) = cart.theta;
    cartat(cont) = cart.Fa;
    thetamsg = (180/pi)*cart.theta;
    cartu(cont) = cart.u;
    
    %Transmissão dos dados para o Unity
    
    fopen(tcpipClient);                 %Abrindo comunicação com o servidor TCP
    rmsg = round(cart.r,4);             %Posição do Carro para envio
    tmsg = round(thetamsg,4);           %Ângulo do Pêndulo para envio
    msg = sprintf('%f,%f',rmsg,tmsg);   %Acondicionamento dos dados em uma string
    fwrite(tcpipClient,msg);            %Envio de mensagem ao servidor
    fclose(tcpipClient);                %Fechando comunicação com o servidor TCP
    pause(Ts);                          %Aguardo do tempo de amostragem
 
end

plot(sim.t,cartpos)
title('Deslocamento do Carro no Trilho');
xlabel('Tempo [s]');
ylabel('Posição [m]');
figure
plot(sim.t,cartang)
title('Ângulo de giro do Pêndulo');
xlabel('Tempo [s]');
ylabel('Ângulo [rad]');
% figure
% plot(sim.t,cartvel)
% figure
% plot(sim.t,cartat)