%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%      Laboratório Virtual de MPS43 - Sistemas de Controle      %
%       --- Carro sobre Trilhos com Pêndulo Invertido ---       %
%                                                               %
%    Autores: João Filipe R. P de A. Silva e Davi A. Santos     %
%                                                               %
%            Script de Modelagem da Força de Atrito             %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function sys = friction(sys)
% Calcula a Força de Atrito

% Esta função calcula a força de atrito que atua no carrinho, com base
% em sua velocidade, a comando de força e alguns coeficientes de atrito. Para
% mais informações, verifique o trabalho de Campbell, Crawford e Morris
% "FRICTION AND THE INVERTED PENDULUM STABILIZATION PROBLEM"
    
    Fs = 0;
    
    if sys.muFlag == 1
        mu = sys.mu_s;
    else
        mu = sys.mu_c;
    end
    Ft = sys.u + (sys.m*sys.l*(mu*cosd(sys.theta) - sind(sys.theta))*sys.theta_dot^2);
    
    if abs(sys.u + sys.Fd) < sys.mu_s*sys.Fn
        Fs = -Ft;
    else
        Fs = -sys.mu_s*sys.Fn*sign(sys.u);
    end
    
    if (sys.v >= -0.005) && (sys.v <= 0.005)
        sys.Fa = Fs;
        sys.muFlag = 1;
    else
        sys.Fa = -sys.mu_c*sys.Fn*sign(sys.v) - sys.eta*sys.v;
        sys.muFlag = 2;
    end
        
end

