%% lab7 upp3

a = getactive;

maxval = max(max(a));
b = maxval * imnoise(a/maxval, 'gaussian', 0.005);

newimage(b, 'saturnbrus',2);

%%
c = wiener2(b, [5 5]);

newimage(c, 'saturnbrus_wiener2',2);