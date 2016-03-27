x :=
BITUMEN180 ANTWERPEN   286
BITUMEN180 DUNDEE      117
BITUMEN180 GOTEBORG    197
BITUMEN180 LIVERPOOL   110
BITUMEN180 NYNASHAMN   237
BITUMEN55  ANTWERPEN   214
BITUMEN55  DUNDEE      184
BITUMEN55  GOTEBORG    193
BITUMEN55  LIVERPOOL   230
BITUMEN55  NYNASHAMN   263
;

vinst = 4776740

z [BITUMEN180,*,*] (tr)
:           ANTWERPEN DUNDEE GOTEBORG LIVERPOOL NYNASHAMN    :=
ABERYSTWYTH      0        0       0       56         0
ARHUS            0        0      44        0         0
BODEN            0        0       0        0        34
BOLLNAS          0        0       0        0        27
BRYSSEL         69        0       0        0         0
GLASGOW          0       71       0        0         0
HARNOSAND        0        0       0        0        45
KOPENHAMN        0        0      38        0         0
MALMO            0        0      57        0         0
MOLNDAL          0        4       0        0         0
NANTES          89        0       0        0         0
NORRKOPING       0        0       0        0         7
OREBRO           0        0      17        0         0
OSKARSHAMN       0        0       0        0        29
PONTEVENDRA     66        0       0       54         0
SANDEFJORD      17        0       0        0         0
SKELLEFTEA       0        0       0        0        12
SZCZECIN        45       42       0        0         0
TALINN           0        0       0        0        65
VASTERAS         0        0      41        0        18

 [BITUMEN55,*,*] (tr)
:           ANTWERPEN DUNDEE GOTEBORG LIVERPOOL NYNASHAMN    :=
ABERYSTWYTH       0       0       0        89        0
ARHUS             0       0      46         0        0
BODEN             0       0       0         0       32
BOLLNAS           0       0       0         0        4
BRYSSEL          49       0       0         0        0
GLASGOW           0      91       0         0        0
HARNOSAND         0       0       0         0       12
KOPENHAMN         0       0      62         0        0
MALMO             0       0      24         0        0
MOLNDAL           0      45       0         0        0
NANTES          106       0       0         0        0
NORRKOPING        0       0       0         0       35
OREBRO            0       0       0         0       52
OSKARSHAMN        0       0       0         0       27
PONTEVENDRA       0       0       0       141        0
SANDEFJORD       59       0       0         0        0
SKELLEFTEA        0       0       0         0       21
SZCZECIN          0      48      61         0        0
TALINN            0       0       0         0       78
VASTERAS          0       0       0         0        2
;

kapacitet.slack [*] :=
ANTWERPEN   0
   DUNDEE  19
 GOTEBORG   0
LIVERPOOL   0
NYNASHAMN   0
;

kapacitet.dual [*] :=
ANTWERPEN   160
   DUNDEE     0
 GOTEBORG  3220
LIVERPOOL   550
NYNASHAMN  3560
;

