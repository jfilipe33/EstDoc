%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                               %
%      Laboratório Virtual de MPS43 - Sistemas de Controle      %
%       --- Carro sobre Trilhos com Pêndulo Invertido ---       %
%                                                               %
%    Autores: João Filipe R. P de A. Silva e Davi A. Santos     %
%                                                               %
%                 Script de Dinâmica do Modelo                  %
%                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function xnew = cartDyn(x,cart)
                   
    v = x(3);
    omega = x(4);
    if cart.muFlag == 1
        mu = cart.mu_s;
    else
        mu = cart.mu_c;
    end

    
    Aux1 = [(cart.m+cart.M) (cart.l*cart.m*(cos(x(2)) - mu*sin(x(2))));
            (cart.l*cart.m*cos(x(2))) (cart.I + cart.m*(cart.l)^2)];
    Aux2 = [(cart.l*cart.m*(mu*cos(x(2)) + sin(x(2)))*omega^2 + cart.Fa + cart.u + cart.Fd);
            cart.l*cart.m*cart.g*sin(x(2))];
    xtheta = zeros(2,1);
    xtheta = inv(Aux1)*Aux2;

      
    
    xnew =  [v;
            omega;
            xtheta(1);
            xtheta(2)];
         

end