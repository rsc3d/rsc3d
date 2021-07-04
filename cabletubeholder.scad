
// Cable tube holder (bracket)
$fn = 100;

module hole (hr, hh, s)
{
    translate ([ s / 2, 0 , 0]) cylinder (r = hr, h = hh);
    translate ([-s / 2, 0 , 0]) cylinder (r = hr, h = hh);
    translate ([0, 0, hh / 2]) cube ([s, 2 * hr, hh], center = true);
}

module recess (l, h)
{
    translate ([0, l / 2, 0]) {
        translate ([-l / 2, 0, 0]) cube ([l, l, h], center = true);
        translate ([0, 0,  h / 2])
            rotate ([0,  45, 0]) translate ([-l / 2,  0, -h / 2])
                cube ([l, l, h], center = true);
        translate ([0, 0, -h / 2])
            rotate ([0, -45, 0]) translate ([-l / 2,  0,  h / 2])
                cube ([l, l, h], center = true);
    }
}

// dia:   Diameter of hole
// screw: Diameter of screw
// l:     Thickness of wall around hole (length) (X)
// w:     Width of part below tube hole (affects length of screw) (Y)
// h:     Width of holder (thickness) (Z)
// screwratio: ratio between screw head diameter and inner hole
// scr_vert: vertical screw, use horizontal one if false
module holder (dia, screw, l, w, h, screwratio=5/3, scr_vert=true)
{
    r  = dia / 2;
    rk = 10 * r;
    ri = screw / 2;
    ro = ri * screwratio;
    sh = rk - l / 2;
    e  = 0.01;
    hd = w * 0.55;
    translate ([0, 0, h/2]) {
        difference () {
            union () {
                // base
                translate ([ 0, -1.5 * w / 2 - r + 0.5 * w, 0])
                    cube ([l, 1.5 * w, h], center = true);
                // rounded bracket
                intersection () {
                    translate ([ sh, -r, 0])
                        cylinder (r = rk, h = h, center = true);
                    translate ([-sh, -r, 0])
                        cylinder (r = rk, h = h, center = true);
                }
            }
            translate ([0, sqrt (2) * l / 2, 0])
            {
                rotate ([0, 0, 30])
                    cube (l, center = true);
                rotate ([0, 0, 60])
                    cube (l, center = true);
            }
            // Screw hole vertical
            if (scr_vert) {
                rotate ([-90, 0, 0]) {
                    translate ([0, 0, -(r + w + 1)])
                        hole (ri, hd + 1, ri);
                    translate ([0, 0, -(r + w + 1) + hd])
                        hole (ro, 3 * hd, ri);
                }
            }
            // Screw hole horizontal
            if (!scr_vert) {
                translate ([0, -r -(w/2), 0])
                    rotate ([0, 90, 0]) {
                        cylinder (r=ri, h=3*l, center=true);
                }
            }
            // Cylinder for tube
            cylinder (r = r, h = 2 * h, center = true);
            // Remove upper and lower parts of rounded bracket
            translate ([0, -rk / 2 - r - w, 0])
                cube (rk, center = true);
            translate ([0,  rk / 2 + r + w, 0])
                cube (rk, center = true);
            // Add recess, destroys rounded bracket :-(
            if (0) {
                translate ([-l / 2 + 1, -r, 0])
                    rotate ([0, 0, -10])
                        recess (4 * r, h - 4);
                translate ([ l / 2 - 1, -r, 0])
                    rotate ([0, 0, 10])
                        rotate ([0, 180, 0]) recess (4 * r, h - 4);
            }
        }
        // Support for screw hole
        if (screw >= 4 && scr_vert) {
            translate ([ ri / 2, -w / 2 - r, 0])
                cube ([0.8, w, h], center = true);
            translate ([-ri / 2, -w / 2 - r, 0])
                cube ([0.8, w, h], center = true);
        }
    }
}

// setting VARIANT using the -D option to openscad overrides this!
VARIANT = "Tube_24.5mm";
// Set to 60 via -D option to increase distance between cable holders
// for Variant Tube_35mm_3mm:6
TUBE_DISTANCE = 0;

echo (VARIANT);
echo (TUBE_DISTANCE);

if (VARIANT == "Tube_24.5mm") {
    // Single holder
    holder (24.5, 5, 34, 13, 12);
} else if (VARIANT == "Tube_24.5mm_2") {
    // dual holder 24.5mm
    translate ([-17 + 0.001, 0, 0])
        holder (24.5, 5, 34, 13, 12);
    translate ([ 17 - 0.001, 0, 0])
        holder (24.5, 5, 34, 13, 12);
}

// Cable holder with 3mm screw
if (VARIANT == "Cable_8mm") {
    // For 8mm cable
    holder (8, 3.2, 11.5, 9, 8);
} else if (VARIANT == "Cable_9mm") {
    // For 9mm cable
    holder (9, 3.2, 12.5, 9, 8);
}


if (VARIANT == "Tube_18mm:2") {
    // For 18mm copper tubing
    translate ([0, 0, 5]) {
        translate ([29, 0, 0])
        holder (18, 3.2, 27, 10, 10);
        holder (18, 3.2, 27, 10, 10);
    }
}

// For 26.3mm PE-AL-PE with 3mm (metric) screw
if (VARIANT == "Tube_35mm_3mm:3" || VARIANT == "Tube_35mm_3mm:6") {
    for (k = [35, -5, -45]) {
        translate ([k, 35, 0])
            holder (26.3, 3.2, 38, 13, 13, 5.75/3);
    }
}
if (VARIANT == "Tube_35mm_3mm:6") {
    translate ([-10, -TUBE_DISTANCE, 0]) {
        rotate ([0, 0, 180]) {
            for (k = [35, -5, -45]) {
                translate ([k, 35, 0])
                    holder (26.3, 3.2, 38, 13, 13, 5.75/3);
            }
        }
    }
}

// For RG-213 cable with vertical screw
if (VARIANT == "Cable_RG213" || VARIANT == "Cable_RG213:4") {
    for (k = (VARIANT == "Cable_RG213" ? [-5] : [-5, -20, -35, -50])) {
        translate ([k, 40, 0])
            holder (9.7, 3.2, 13.5, 9, 8, scr_vert=false);
    }
}
