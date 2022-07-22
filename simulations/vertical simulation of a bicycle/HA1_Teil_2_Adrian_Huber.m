% Teilaufgabe 2 der LA1
%
% Vertikaldynamik eines Fahrrads mit Federgabel
%
% Leeren des Arbeitsraums
clear;                      
close all;
clc;
%
T = 5.0;                    % Zeitraum
h = 0.001;                  % Schrittweite  
t = 0:h:T;	                % Zeitbereich
%
y0 = 0.005;                 % Wegamplitude
D = 0.1;                    % Dämpfungsmaß 
m = 30;                     % Masse
lambda = 0.275;	            % Anregung
%
a = 0;                      % Beschleunigung in horizontaler Richtung
w = 2*pi*2.7;               % ungedämpfte Eigenkreisfrequenz omega
%
%{Hier werden neue Zustandskoordinaten eingeführt:
% Weg: j = q
% Geschwindigkeit: j' = b
% somit ist b = q' und b' = q''}
%
b0 = 0;
j0 = 0;
q0 = [b0,j0];
%
v0_kmh = 1:1:50;            % Fahrgeschwindigkeit
v0_ms = v0_kmh/3.6;         % Umrechnung der Geschwindiekeit von (km/h) in (m/s)
%
%% Teilaufgabe 2 Teil 1 & 2
%
figure                      % Neuer Plot erstellen
%
% Konvergenz
opts_1 = odeset('RelTol',1e-1,'AbsTol',1e-2); % Festlegung der Toleranzen für die Konvergenzprüfung
% 
%
[t_sim,q_sim] = ode45(@(t,q) rhs_122(D,lambda,y0,a,v0_ms(50),w,q,t),t,q0);
% Lösung der Differenzialgleichung mit ode45
% Berechnung der Strecke q bei 50 km/h
%
[t_sim_k,q_sim_k] = ode45(@(t,q) rhs_122(D,lambda,y0,a,v0_ms(50),w,q,t),t,q0,opts_1);
% Lösung der Differenzialgleichung mit ode45
% Berechnung der Strecke q zum Zeitpunkt i für die Konvergenzprüfung
%
hold on                                    % Erstellung und beschriftung des Plots
grid on
plot(t_sim,q_sim(:,1));
plot(t_sim_k,q_sim_k(:,1),'-.')            % Plot für Konvergenzprüfung
xlabel('Zeit in s');
ylabel('Strecke der Auslenkung in m');
title('Gedämpfte Schwingung der Federgabel inkl. Konvergenzanalyse')
legend('q(t)','q(t) konvergenz','location','best')
%
%% Teilaufgabe 2 Teil 3
% 
T = 30.0;                   % Zeitraum
h = 0.001;                  % Schrittweite  
t = 0:h:T;	                % Zeitbereich
N = length(t);              % Anzahl der Zeitschritte
A_f = zeros(1,50);          % Erstellung des Vektors für die Amplitudenfrequenzgang
%
% Konvergenz
opts_3 = odeset('RelTol',1e-3,'AbsTol',1e-3); % Festlegung der Toleranzen für die Konvergenzprüfung
A_f_k = zeros(1,50);                          % Erstellung des Vektors für die Amplitudenfrequenzgang
%
%
% Nach dem das System eingeschwungen ist, soll ein gewünschter Bereich im Zeitraum gefunden werden
go = find(t==9);        % Anfangsstelle im Zeitraum finden    
stop = find(t==20);     % Endstelle im Zeitraum finden   
%
for i = 1:1:50
    %
    [t_sim_3,q_sim_3] = ode45(@(t,q) rhs_122(D,lambda,y0,a,v0_ms(i),w,q,t),t,q0);
    % Lösung der Differenzialgleichung mit ode45
    % Berechnung der Strecke q zum Zeitpunkt i
    %
    maximum = max(q_sim_3(go:stop));     % Maximalwert zwischen Anfangs- und Endstelle definieren
    A_f(i) = maximum;                    % Maximalwert in Amplitudenfrequenzgang schreiben
    %
    [t_sim_3k,q_sim_3k] = ode45(@(t,q) rhs_122(D,lambda,y0,a,v0_ms(i),w,q,t),t,q0,opts_3);
    % Lösung der Differenzialgleichung mit ode45
    % Berechnung der Strecke q zum Zeitpunkt i
    %
    A_f_k(i) = max(q_sim_3k(go:stop));    % Maximalwert in Amplitudenfrequenzgnag schreiben für Konvergenzprüfung
    %
end
%
figure                                 % Erstellung und beschriftung des Plots
hold on
grid on
plot(v0_ms,A_f); 
plot(v0_ms,A_f_k);                     % Plot für Konvergenzprüfung
xlabel('Geschwindigkeit in m/s');
ylabel('Amplitudenfrequenzgang in m');
title('Amplitudenfrequenzgang im eingeschwungenem System inkl. Konvergenzanalyse')
legend('Amplitudenfrequenzgang','Konvergenz')
%
%% Teilaufgabe 2 Teil 4
%
F_Rmin = zeros(1,50);                           % Erstellung des Vektors für die minimale Radaufstandskraft
%
% Konvergenz
opts_4 = odeset('RelTol',1e-3,'AbsTol',1e-3);   % Festlegung der Toleranzen für die Konvergenzprüfung
F_Rmin_k= zeros(1,50);                        
%
%
while min(F_Rmin) >= 0                          % Schleife durchlaufen bis minimale Radaufstandskraft kleinergleich 0 ist
    %
    for i = 1:1:50
        %
        [t_sim_4,q_sim_4] = ode45(@(t,q) rhs_122(D,lambda,y0,a,v0_ms(i),w,q,t),t,q0);
        % Lösung der Differenzialgleichung mit ode45
        % Berechnung der Strecke q zum Zeitpunkt i
        %
        y = y0*sin(2*pi*lambda*(v0_ms(i).*t+0.5*a*t.^2));                                 % Berechnung der Auslenkung zum Zeitpunkt i
        dy = 2*pi*lambda*y0*(v0_ms(i)+a*t).*cos(2*pi*lambda*(v0_ms(i).*t+0.5*a*t.^2));    % Berechnung der Ableitung der Auslenkung zum Zeitpunkt i
        %
        FR = m*9.81-(w^2*m*(q_sim_4(:,1)-y')+2*w*D*m*(q_sim_4(:,2)-dy'));                 % Berechnung der Aufstandskraft zum Zeitpunkt i 
        F_Rmin(i) = min(FR(go:stop));                                                     % minimale Aufstandskraft im gewünschten Zeitraum
        %
        [t_sim_4k,q_sim_4k] = ode45(@(t,q) rhs_122(D,lambda,y0,a,v0_ms(i),w,q,t),t,q0,opts_4);
        % Lösung der Differenzialgleichung mit ode45
        % Berechnung der Strecke q zum Zeitpunkt i für Konvergenzprüfung
        %
        FR_k = m*9.81-(w^2*m*(q_sim_4k(:,1)-y')+2*w*D*m*(q_sim_4k(:,2)-dy'));              % Berechnung der Aufstandskraft zum Zeitpunkt i 
        F_Rmin_k(i) = min(FR_k(go:stop));                                                  % minimale Aufstandskraft im gewünschten zeitraum
        %
    end
    %
    y0 = y0+0.001;      % Erhöhung der Wegamplitude
    %
end
%            
figure                  % Erstellung und beschriftung des Plots
hold on
grid on
plot(v0_ms,F_Rmin);
plot(v0_ms,F_Rmin_k);   % Erstellung des Plots für Konvergenzprüfung
xlabel('Geschwindigkeit in m/s');
ylabel('Minimale Aufstandskraft in N');
title('Minimale Aufstandskraft in Abhängigkeit der Geschwindigkeit inkl. Konvergenzanalyse')
legend('F_{R,min}','Konvergenz','location','best')
%
%% Teilaufgabe 2 Teil 5
%
y0 = 0.005;             % Wegamplitude
%
figure                  % Erstellung und beschriftung des Plots
grid on
hold on 
plot(v0_ms,A_f);
xlabel('Geschwindigkeit in m/s');
ylabel('Amplitudenfrequentgang in m');
title('Simulation bei konstanter Beschleunigung')
for T_B = 1:10:20
    %
    h1 = 0.001;         % Schrittweite   
    t_B = 0:h1:T_B;     % Zeitbereich
    v0_ms = 0;          % Anfangsgeschwindigkeit der Beschleunigung 
    a = 50/(3.6*T_B);   % Beschleunigung zum Zeitpunkt T_B
    %
    [t_sim_B, q_sim_B] = ode45(@(t,q) rhs_122(D,lambda,y0,a,v0_ms,w,q,t),t_B,q0);
    % Lösung der Differenzialgleichung mit ode45
    % Berechnung der Strecke q zum Zeitpunkt i
    %
    v_ms5 = a*t_sim_B;               % Berechnung der Geschwindigkeit zum Zeitpunkt t_B
    %
    hold on
    plot(v_ms5,abs(q_sim_B(:,1)));   % Erstellung des Plots
    %
end
%
legend('Amplitudenfrequenzgang','Beschleunigungsfahrt 1','Beschleunigungsfahrt 2','location','best')
%