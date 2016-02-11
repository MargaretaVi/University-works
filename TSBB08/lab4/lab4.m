%%
clear; clc; close all

load ('/site/edu/bb/mips/7.0/images/nuf4b.mat');
load ('/site/edu/bb/mips/7.0/images/nuf2a.mat');
midway(nuf4,109)

%%
clc

nuf4 = getactive;
mid = midway(nuf4,90)
lesat = least_error(nuf4)
%%
nuf2 = getactive;
least2 = least_error(nuf2)

%% filtered 4a
filtered4 = getactive;
fil4 = least_error(filtered4)

%% filtered 0b

filtered0 = getactive;
fil0 = least_error(filtered0)


%%
clc;
number = getactive;
output = which_number(number)

%%
clc;
number = getactive;
in = number;
%%
clc
ble= getactive;
number = ocrdecide(ble,8)

