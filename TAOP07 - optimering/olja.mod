set PRODUKTER;
set RAFFINADERIER;
set TERMINALER;

param ovre{p in PRODUKTER, t in TERMINALER};
param undre{p in PRODUKTER, t in TERMINALER};
param pris{p in PRODUKTER, t in TERMINALER};
param milkostn;
param avstand{r in RAFFINADERIER, t in TERMINALER};
param raffkostn{p in PRODUKTER, r in RAFFINADERIER};
param raffkap{r in RAFFINADERIER};

var z{p in PRODUKTER,r in RAFFINADERIER,t in TERMINALER} >=0;
var x{p in PRODUKTER,r in RAFFINADERIER} >=0;

maximize vinst: sum {p in PRODUKTER, r in RAFFINADERIER, t in
TERMINALER} ((pris[p,t]-milkostn*avstand[r,t])*z[p,r,t]) - sum {p
in PRODUKTER, r in RAFFINADERIER} (raffkostn[p,r]*x[p,r]);

subject to undregrans{p in PRODUKTER, t in TERMINALER}:
	sum{r in RAFFINADERIER} z[p,r,t] >= undre[p,t];

subject to ovregrans{p in PRODUKTER, t in TERMINALER}:
	sum{r in RAFFINADERIER} z[p,r,t] <= ovre[p,t];

subject to kapacitet{r in RAFFINADERIER}:
	sum{p in PRODUKTER} x[p,r] <= raffkap[r];

subject to lager{p in PRODUKTER, r in RAFFINADERIER}:
	sum{t in TERMINALER}z[p,r,t] = x[p,r];

