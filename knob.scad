include <nuts.scad>

e=0.01; // epsilon
kd=30;  // knob diameter
kdo=kd; // for conic knob outer diameter (the diameter facing the user)
ad=6;   // axis diameter
ah=17;  // height of axis from bottom of case (=knob height excluding thickness)
aw=4;   // wall around axis
af=1.5; // width of flat part of axis
t=2.5;  // thickness of outer wall
sl=10;  // length of screw excluding screw head
hs=7;   // height of inner part before axis starts
d=0.5;  // Delta by which axis is made larger (to fit) and screw head is deeper
md=2;   // Minimum distance of screw head and nut
nut=m3;

module inner_hollow (rhi, rho, rhoo, h)
{
    difference () {
        cylinder (r1=rho, r2=rhoo, h=h);
        translate ([0, 0, -h])
            cylinder (r=rhi, h=3*h);
    }
}

module axis (r, x, h, d)
{
    difference () {
        cylinder (r=r+d, h=h);
        translate ([2*r-x+d, 0, 0])
            cube ([2*r, 2*r, 3*h], center = true);
    }
}

module screwguide (kr, ar, af, ri, h, nut, min_d=2)
{
    // min_d is the minimum distance between axis and nut and outer
    // material of nut
    w = max (2*ri, nut [nut_diameter_high] + 2*min_d);
    difference () {
        translate ([(kr-ar+af)/2+ar-af, 0, h/2])
            cube ([kr-ar+af, w, h], center = true);
            // Remove the part that would overlap the knob outer dia
            difference () {
                translate ([0, 0, -h])
                    cylinder (r=2*kr, h=3*h);
                translate ([0, 0, -2*h])
                    cylinder (r=kr-e, h=5*h);
            }
    }
}

module knob
    ( kd=kd, kdo=kdo
    , ad=ad, ah=ah, aw=aw, af=af
    , t=t, sl=sl, hs=hs, d=d, md=md, nut=nut
    )
{
    kr  = kd/2;    // knob radius
    kro = kdo/2;   // outer knob radius
    h   = ah + t;  // height (incl material thickness)
    ar  = ad/2;    // axis radius
    ri  = ar + aw; // inner radius around axis
    difference () {
        union () {
            difference () {
                cylinder (r1=kro, r2=kr, h=h);
                // subtract inner hollow
                translate ([0, 0, t])
                    inner_hollow (ri, kr-t, kro-t, h);
            }
            screwguide (kr, ar, af, ri, t+h-hs, nut);
        }
        // cut out axis
        translate ([0, 0, t])
            axis (r=ar, x=af, h=h, d=d);
        // cut out non-axis part of inner knob
        translate ([0, 0, t+h-hs])
            cylinder (r=kro-t, h=h);
        // screw channel in middle of height of inner isle
        translate ([0, 0, (t+h-hs)/2])
            rotate ([0, 90, 0])
                cylinder (r=nut [screw_channel]/2, h=kr+t);
        // screw head channel
        translate ([0, 0, (t+h-hs)/2])
            translate ([sl+ar-af-d, 0, 0])
                rotate ([0, 90, 0])
                    cylinder (r=nut [screw_head_channel]/2, h=kr+t);
        // embedded nut
        translate ([ar-af+sl-md-d, 0, (t+h-hs)/2])
            rotate ([0, 0, 180])
                embedded_nut (nut, h);
    }
}

knob ($fa=3, $fs=.5);
