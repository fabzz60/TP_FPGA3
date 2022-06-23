# -*- coding: utf-8 -*-
# On importe Tkinter
import numpy as np
import matplotlib.pyplot as plt
from pylab import *
import serial
import struct
import time
import math  # importation du module
import sys
 
ser =serial.Serial(
port ='COM11',
baudrate = 9600, 
parity = serial.PARITY_NONE, 
stopbits = serial.STOPBITS_ONE, 
bytesize = serial.EIGHTBITS,
timeout = 100
)
def packUnsignedCharAsUChar(valeur):
    """Packs a python 1 byte unsigned char"""
    return struct.pack('B', valeur)    #should check bounds

print("courbe en x^2 et -x")
for i in [0, 1, 2, 3 , 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]:
    w = i**2
    time.sleep(1)
    ser.write(packUnsignedCharAsUChar(w))
    print(w)
    if i == 15:
     while (w > 0):
       w = w - 1 
       time.sleep(0.005)
       ser.write(packUnsignedCharAsUChar(w))
       print(w)
if w == 0:
 ser.write(packUnsignedCharAsUChar(0))
        print("ARRET MOTEUR")
        print("fermeture UART")
        ser.close()

    
ser.open()
time.sleep(1)

print("Courbe cos")
for z in range(0,360):
    i = math.radians(z)
    w = 50*cos(i) + 50
    time.sleep(0.05)
    print(w)
    ser.write(packUnsignedCharAsUChar(int(w)))
    if z == 360:
        ser.write(packUnsignedCharAsUChar(0))
        print("ARRET MOTEUR")
        print("fermeture UART")
        ser.close()

ser.write(packUnsignedCharAsUChar(0))
print("ARRET MOTEUR")
print("fermeture UART")
ser.close()
