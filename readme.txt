This directory has the tunnel files in it.  
It is a clone of the hidden fromserver version.
To update from there, type hg pull, then hg update.
To save to it, type hg commit, then hg push.

To save to the "central" fromserver version, you will need:
 hg push ssh://expo@192.168.1.100/.fromserver/cucchg/tunneldata

In the future troggle should allow for tunnel to work on the sketches
directly over the wifi without having to save data to your computer.

