%% förbergedelse 4

s = tf('s');

g_s = 32 / (s + 8);

bodeplot (g_s)

%% 5

g_enkel = k_enkel/(s*T +1);
