use <lib/arc.scad>
// starts at y axis + a1 in negative clock direction, continues for a2.
// r - fw is the width of the arc

eps = 0.01;
module hook (id = 16, od = 23.0, l = 29, h = 8)
{
    ro = od / 2;
    ri = id / 2;
    op = 45;
    w  = (od - id) / 2;
    arc (270 - op, 180 + op, ro, w, h);
    translate ([-w/2 - ri, -l/2, h/2])
        cube ([w, l + eps, h], center = true);
    translate ([-od + w, -l, 0])
        arc (90 - op, 180 + op, ro, w, h);
}

translate ([0, 0, 0])
    hook ($fa=3, $fs=0.3);
translate ([25, 0, 0])
    hook ($fa=3, $fs=0.3);
//translate ([50, 0, 0])
//    hook ($fa=3, $fs=0.3);
