% ME 3 Hausarbeit 1
%
clear;                      % Leeren des Arbeitsraums
close all;
clc;
%
z1 = 17;
z2 = 55;
z3 = 127;
eta = 0.96;              % Wirkungsgrad
T_ab = 210000;           % Beschleunigungsmoment der Ausgangswelle
%
wg = (z3/z1)+1;          % Übersetzung 
T_an = T_ab/(wg*eta);    % Berechnung des Antriebmoments
%
%% Vordimensionierung der Welle
%
tau_zul = 44;       % Zulässige Torsionspannung, ist vorgeben
%
T_1max = T_an/3;    % Berechnung des maximalen Moments, das sich auf 3 Planetenräder verteilt
%
x_an = (16*T_an)/(tau_zul*pi);  
d_an = nthroot(x_an,3);             % Berechnung des Durchmessers der Eingangswelle
x_ab = (16*T_ab)/(tau_zul*pi);
d_ab = nthroot(x_ab,3);             % Berechnung des Durchmessers der Ausgangswelle
fprintf('Der Durchmesser der Eingangswelle beträgt %2.4f.\n',d_an)
d_an = input('Wählen Sie den Durchmesser nach der Norm Din 748: ');
%
fprintf('Der Durchmesser der Ausgangswelle beträgt %2.4f.\n',d_ab)
d_ab = input('Wählen Sie den Durchmesser nach der Norm Din 748: ');
%
%% Berechnung des Normalmoduls
%
Z_E = 190;
Z_eps = 1;
Z_H = 2.49;
lambda = 20;
sigma_Hlim = 1470;
S_H = 1.3;
%
u = z2/z1;
sigma_HP = sigma_Hlim/S_H;
%
x2 = ((u+1)*2*T_1max*Z_E.^2*Z_eps.^2*Z_H.^2)/(u*lambda*z1.^2*sigma_HP.^2);
m_n = nthroot(x2,3);
fprintf('Das berechnete Modul ist %1.4f groß.\n',m_n);
m_n = input('Wählen sie ihr Modul: ');
%
d_f1 = m_n*z1-2.5*m_n;  % Fußkreisdruchmesser
%
%% Hohlradaußendruchmesser
% 
d_h = m_n*(z3+6.5);
%% Berechnung der Sicherheiten
% Dynamische Sicherheit
%
Rm = 780; 
K_Dt = 1.4;
%
tau_tw = 0.3*Rm;                 % Wechselfestigkeit
tau_ZGW = tau_tw/K_Dt;           % Torsionsgestaltausschlagfestigkeit
tau_ta = (16*T_an)/(pi*d_f1.^3); % Ausschlagspannung am Antrieb
S_Dt = tau_ZGW/tau_ta;           % Dynamische Sicherheit
%
if S_Dt >= 1.5
    disp('Ausreichende dynamische Sicherheit')
end
% Statische Sicherheit
%
T_Notaus = 625000;     % Notausmoment
Re = 590;               % Streckgrenze Zug/Druck
%
tau_te = Re/sqrt(3);    % 
T_AN = T_Notaus/(wg*eta);   %
tau_tNotaus = (T_AN*16)/(pi*d_an^3);
S_st = tau_te/tau_tNotaus;  % Statische Sicherheit
%
if S_st >= 1.5
    disp('Ausreichende statische Sicherheit')
end
%
%% Berechnung der überschlägigen Zahnradbreite 
%
b = lambda*m_n; 
%
%% Berechnung des Achsabstandes und Zahnradbreite
%
alpha_t = 20;
%
d_a1 = (z1+2)*m_n;
d_a2 = (z2+2)*m_n;
d_b1 = m_n*z1*cos(alpha_t);
d_b2 = m_n*z2*cos(alpha_t);
%
a = 0.5*(m_n*z1+m_n*z2);        % Berechnung Achsabstand
%
eps_a = (sqrt(d_a1^2-d_b1^2)+sqrt(d_a2^2-d_b2^2)-2*a*sin(alpha_t))/(2*pi*m_n*cos(alpha_t)); % Berechnung von Epsilon-Alpha
Z_eps = sqrt((4/3)-(eps_a/3));
b_g = ((u+1)*2*T_an*Z_E^2*Z_eps^2*Z_H^2)/(u*3*z1^2*sigma_HP^2*m_n^2);
%
%% Kontrolle der nominellen Lebensdauer von Wälzlager und Ausgangswelle
%
d_gudel = 45.094;         % Ausgangswellendurchmesser der konstruierten Welle
m_gudel = 2.5;
C_0r = 78000;       % Statische Tragzahl in N
C_r = 95000;        % Dynamische Tragzahl in N
Y_0 = 0.97;          % Statischer Axialfaktor
Y = 1.76;           % Dynamischer Axialfaktor
e = 0.34;	        % Berechnungsfaktor
gamma = 20*pi/180;  % Berechnung des 20° Winkels in Bogenmaß
%
F_t = (2*T_ab)/d_gudel;                   % Tangenzialkraft
beta = 19.5*pi/180;   
alpha = atan(tan(gamma)/cos(beta));
F_r = F_t*tan(alpha);               % Radialkraft
F_a = F_t*tan(beta);                % Axialkraft
%
F_r0 = F_r*T_Notaus/T_ab;           % Statische Radialkraft
F_a0 = F_a*T_Notaus/T_ab;           % Statische Axialkraft
%
% Statische Tragfähigkeit
e_st = 0.5/Y_0;
sTf = F_a0/F_r0;
%
if sTf <= e_st
    X_0 = 1;
    Y_0 = 0;
else
    X_0 = 0.5;
end
%
P_0 = X_0*F_r0+Y_0*F_a0;    % Äquivalente statische Belastung
%
S_0 = C_0r/P_0;             % Statische Tragfähigkeit
%
% Dynamische Tragfähigkeit
dTf = F_a/F_r;  
%
if dTf <= e
    X = 1;
    Y = 0;
else
    X = 0.4;
end
%
P = X*F_r+Y*F_a;            % Äquivalente dynamische Belastung
P = 18106;
%
% Nominelle Lebensdauer
p = 10/3;                   % Lebendauerexponent für Rollenlager
n_e = 2000;                 % Eingangsdrehzahl
%
n_a = n_e/wg;               % Ausgangsdrehzahl
L_10h = (((C_r/P)^p)*10^6)/(60*n_a);    
%
%% Ausgabe
fprintf('Die Planetenräder haben eine Zähnezahl von %d.\n',z2)
fprintf('Das Hohlrad hat eine Zähnezahl von %d.\n',z3)
fprintf('Das Modul beträgt %2.3f mm.\n',m_n)
fprintf('Die Eingangswelle hat einen Durchmesser von %d mm.\n',d_an)
fprintf('Die Ausgangswelle hat einen Durchmesser von %d mm.\n',d_ab)
fprintf('Die überschlägige Zahnradbreite beträgt %2.4f mm.\n',b)
fprintf('Die Zahnradbreite beträgt %2.4f mm.\n',b_g)
fprintf('Der Achsabstand beträgt %2.4f mm.\n',a)
fprintf('Der Außendurchmesser des Hohlrades beträgt %2.4f mm.\n',d_h)
fprintf('Die nominelle Lebensdauer beträgt %8.4f.\n',L_10h)
%