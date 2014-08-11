Ralf's OpenSCAD designs
-----------------------

:Author: Ralf Schlatterbeck

This project contains various OpenSCAD designs. The ``shapes`` directory
contains mostly experiments that might or might not be useful to others.

The ``mendelmax`` subdirectory contains various changes/improvements to my
MendelMax RepRap and has its own README.

The top-level contains the following:

- ``knob.scad``: parametric knob design for electronics. Sometimes it's
  hard to get a matching knob for a non-standard axis, e.g., a 4.5 mm
  axis of a variable capacitor.

- ``nuts.scad`` contains various parameters of common metric nuts and
  associated screws. I'm using this in other designs to not repeatedly
  reinvent the wheel.

- ``peg.scad`` is my peg design. Thanks to the following animation by
  Clifford Wolf (thanks Clifford!) this will say more than a thousand
  words ... you find the OpenSCAD animation in ``peg_animated.scad``.

.. image:: https://raw.githubusercontent.com/rsc3d/rsc3d/master/animated.gif

- ``stoppel.scad`` is an experiment to fix a broken screw-hole that
  didn't turn out too well when printed.

