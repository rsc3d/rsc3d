This directory contains modifications to my MendelMax RepRap
------------------------------------------------------------

The file ``extruder_guide.scad`` is a modified extruder where the
filament-guide is thicker (it broke for me). I started out with
``jonaskuehling_gregs-wade-v3_jhead.stl`` but unfortunately this is
malformed and I was unable to fix it (you can find the relevant stl in
the history of this repository). So I re-modelled the part in OpenSCAD.

The ``filamentholder.scad`` is my version of a clip-on for holding a
filament roll on top of the MendelMax. The lower part can be clipped
into the notch of the aluminium extrusion parts. The other part is then
screwed on.

The ``rod_holder.scad`` is a new design for holding the Y-plane rods.
The part I used was printed 90° rotated and breaks when fastening the
screws to hold the rod. I'm printing the part in two halves and glue
them together using 

The file ``yplane.scad`` is the first sketch of trying to lower the
Y-plane. For this the rod holders are mounted at a lower position, the
plane is mounted to the two lower frame aluminium extrusions.

Then I was unsatisfied with the end-stop holders for the Z-plane. From
time to time the Z endstop location has to be calibrated. This is *very*
difficult to get right (needs a sub-millimeter precision) if you have a
part that needs to be screwed to the rod. Using a peg in ``nutpeg.scad``
with the necessary holes for mounting the end-stop electronics makes
this much easier.
