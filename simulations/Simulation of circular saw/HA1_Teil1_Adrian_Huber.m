% Laborarbeit 1 im Sommersemester 2022
% Teilaufgabe 1 der LA1
% Berechnung des maximalen Belastungs-Torsions/Drehmomentes in der
% Kreissägenwelle (Kreissägenwelle als Einmassenschwinger)
%
% Das gesuchte Verhältnis alpha ist der Quotient aus dem dynamischen und
% statischen Lastmoment
% alpha wird für verschiedene Dämpfungswerte betrachtet
%
clear;                     
close all;
clc;
%
T = 10.0;                   % Zeitdauer
h = 0.001;                  % Schrittweite  
t = 0:h:T;	                % Zeitbereich
N = length(t);              % Anzahl der Zeitschritte
%
D0 = 0;                     % minimale Dämpfung (ohne Dämpfung)
D_max = 0.1;                % maximale Dämpfung
iD = 0.01;                  % Intervallgröße
D = 0:iD:D_max;             % Dämpfungsbereich
%
alpha = zeros(1,length(D)); % Vektor für alpha
M_dyn = zeros(1,length(D)); % Vektor für M_dyn
% 
c_t = 1;                    % Torsionsfedersteifigkeit (frei gewählt)
M = 1;                      % konstantes äußeres Moment (frei gewählt)
Js = 1;                     % Massenträgheitsmoment (frei gewählt)
q0 = 0.0;
v0 = 0.0;
phi0 = [q0,v0];
w0 = sqrt(c_t/Js);          % Eigenkreifrequenz
M_stat = M/(Js*w0^2);       % Berechnung des statischen Momentes
%
%
% Konvergenzprüfung
opts = odeset('RelTol',1e-1,'AbsTol',1e-1); % Festlegung der Toleranzen für die Konvergenzprüfung
alpha_k = zeros(1,length(D));               % Vektor für alpha_k der Konvergenzprüfung
M_dyn_k = zeros(1,length(D));               % Vektor für M_dyn_k der Konvergenzprüfung
%
%
%
for i = 1:1:length(D)
    %
    [t_sim,phi_sim] = ode45(@(t,phi) rhs_Labor11(D(i),w0,M,phi,Js),t,phi0);
    % Lösung der Differenzialgleichung mit ode45
    % Berechnung der Strecke q zum Zeitpunkt i
    %
    M_dyn(i) = max(phi_sim(:,1));   % Berechnung des dynamischen Moments
    alpha(i) = M_dyn(i)/M_stat;     % Berechnung des Anwendungsfaktors
    %
    [t_sim_k,phi_sim_k] = ode45(@(t,phi) rhs_Labor11(D(i),w0,M,phi,Js),t,phi0,opts);
    % Lösung der Differenzialgleichung mit ode45
    % Berechnung der Strecke q zum Zeitpunkt i für die Konvergenzprüfung
    M_dyn_k(i) = max(phi_sim_k(:,1));   % Berechnung des dynamischen Moments für die Konvergenzprüfung
    alpha_k(i) = M_dyn_k(i)/M_stat;     % Berechnung des Anwendungsfaktors für die Konvergenzprüfung
    %
end
hold on
plot(D,alpha);                      % Erstellung und beschriftung des Plots
plot(D,alpha_k);                    % Plot der Konvergenzprüfung
grid on; 
title('alpha bei verschiedenen Dämpfungswerten')
ylabel('alpha')
xlabel('Lehrsches Dämpfungsmaß')
legend('alpha','Konvergenz')