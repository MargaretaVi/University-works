%% lab5 - doing negative laplace

sobelx = [ 1 0 -1; 2 0 -2; 1 0 -1];
sobely = [ -1 -2 -1; 0 0 0 ; 1 2 1 ];

diffx = conv2(sobelx, sobelx);
diffy = conv2(sobely, sobely);

laplace = -diffx - diffy