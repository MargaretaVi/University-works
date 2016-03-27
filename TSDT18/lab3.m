 %% b)

 load uppgift5b_H1.mat
 load uppgift5b_H2.mat
 pzchange(H1)
 pzchange(H2)
 
 %% c)
 
 
 load uppgift5c.mat %% H3
 pzchange(H3)
 
 %% d)
 
  load uppgift5d.mat %% H4
  pzchange(H4)
  
 %% e) - butter
 
 [B,A] = butter(10,2*pi*100,'low','s');
 pzchange(in(B,A,'s'))
 
 %% e) - chevbyshev
 
 [B,A] = cheby1(7,0.5,2*pi*100,'low','s');
 pzchange(in(B,A,'s'))
 
 %% f)
 
 %%Wn = [935 1215];
 
 [B,A] = butter(3,[2*pi*935 2*pi*1215],'s');
 pzchange(in(B,A,'s'))
 %%load uppg5f.mat
 %%pzhange(H7)
 
 
 load dtmf;
 X = foutr (toner);
 Y = output(X,H5);
 b= ifoutr(Y);
 
 fig1 = figure
 signal(toner)
 fig2 = figure
 signal(b)
 
 
 
 