# Moteur pas à pas unipolaire-programmation mode demi-pas
# TP_FPGA3 programation PL ( logique programmable)
Support des TP FPGA3 formation instrumentation
L’objectif de ce TP est de développer sa propre conception électronique pour l’intégrer dans un ensemble plus complexe. Intégrer et développer des sous-ensembles électroniques qui pilotent un ou plusieurs moteurs pas à pas en logique numérique, interfacer en langage de haut niveau et communiquer à distance avec pour exemple une Raspberry Pi4 connectée en SSH.

1.1 Objectif :
Développer des cartes modulaires qui s’adapterons sur un kit FPGA, la CmodA7 pour contrôler un moteur pas à pas. On utilisera le moteur pas à pas et le programme VHDL étudié l’année précédente qui sera à adapté pour la nouvelle cible FPGA mais avec VIVADO comme environnement de programmation, voir description : TP FPGA 2
En pratique, il faudra afficher la fréquence de fonctionnement du moteur, le pas ainsi que la vitesse en tr/min. Attention dans le projet vous devrez afficher sur 12 afficheurs.
Le moteur fonctionne en boucle ouverte non asservi, moteur utilisé : 28BYJ-48 5V moteur unipolaire à 4 enroulements avec réducteur, driver moteur ULN2003 et encodeur PEC11R 24 pas/tours. Le moteur à une réduction de 1/64 soit 360 degrés/64 = 5.625 degré/pas. En mode demi-pas qui correspond à 8 états et 4 phases la réduction finale est de 4096 (64x64). Le moteur aura un pas unitaire angulaire de 5.625/64 = 0,0879 degrés !
Vitesse max du moteur = 255Hz Moteur utilisé : 28BYJ-48 5V moteur unipolaire • Alimentation : 5 Vcc • Résistance : 21 ohms • Intensité : 25 mA • Réduction : 1/64 • Nombre de pas par tour : 64 (réduction de 4096 en sortie d'axe) • Entraxe de fixation : 35 mm • Axe : Ø5 mm avec double méplat (épaisseur 3 mm) • Longueur de l’axe : 12 mm

**Un document pdf demarrer avec Vivado est fourni dans les sources**

![ezcv logo](https://github.com/fabzz60/TP_FPGA3/blob/main/bloc_design_FPGA3.jpg)

1.2 Outils et logiciels :
Le composant numérique principal choisi pour cette carte pour piloter le moteur pas à pas est un FPGA de la famille Xilinx l’Artix 7-35T disposé sur un kit Digilent, le kit CMODA7 35T. 
https://digilent.com/shop/cmod-a7-35t-breadboardable-artix-7-fpga-module/
La gamme Xilinx à découvrir :
https://www.xilinx.com/products/silicon-devices/fpga.html
Le code VHDL du TP FPGA 2 est à adapter sur la cible CmodA7 sous VIVADO et les circuits à développer sur ALTIUM designer. La carte électronique sera auto-alimentée par l’USB. Enfin on utilisera un Raspberry pi 4 en démonstration pour tester une communication distante (SSH) si le temps le permet.


![ezcv logo](https://github.com/fabzz60/TP_FPGA3/blob/main/cartes_a_developper.jpg)

# Courbes de vitesses à appliquer au moteur

![ezcv logo](https://github.com/fabzz60/TP_FPGA3/blob/main/bloc_design_FPGA3.jpg)
