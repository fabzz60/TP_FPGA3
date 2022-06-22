# TP_FPGA3
Support des TP FPGA3 formation instrumentation
L’objectif de ce TP est de développer sa propre conception électronique pour l’intégrer dans un ensemble plus complexe. Intégrer et développer des sous-ensembles électroniques qui pilotent un ou plusieurs moteurs pas à pas en logique numérique, interfacer en langage de haut niveau et communiquer à distance avec pour exemple une Raspberry Pi4 connectée en SSH.

1.1 Objectif :
Développer des cartes modulaires qui s’adapterons sur un kit FPGA pour contrôler un moteur pas à pas. On utilisera le moteur pas à pas et le programme VHDL étudié l’année précédente qui sera à adapté pour la nouvelle cible FPGA, voir description : TP FPGA 2

![ezcv logo](https://github.com/fabzz60/Cmod-A7-Stopwatch-Demo-10s/blob/main/design_vivado.jpg)

1.2 Outils et logiciels :
Le composant numérique principal choisi pour cette carte pour piloter le moteur pas à pas est un FPGA de la famille Xilinx l’Artix 7-35T disposé sur un kit Digilent, le kit CMODA7 35T. 
https://digilent.com/shop/cmod-a7-35t-breadboardable-artix-7-fpga-module/
La gamme Xilinx à découvrir :
https://www.xilinx.com/products/silicon-devices/fpga.html
Le code VHDL du TP FPGA 2 est à adapter sur la cible CmodA7 associé à la carte fille à développer. La carte électronique sera auto-alimentée par l’USB. Enfin on utilisera un Raspberry pi 4 en démonstration pour tester une communication distante (SSH) si le temps le permet.
