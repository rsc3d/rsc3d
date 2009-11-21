//              +++++++++++++
//        +         |   |-h       +
//     +------------+   +------------+
//   +      r       |   |              +
//  +               |   |-radius        +
//  ----------------+   +----------------
//                          |radius
//
// (radius - r)² + r² = (radius)²
//

height    = 7.5;
r         = 11;
radius    = ((height * height) + (r * r)) / r;
cylh      = 15;
slantin   = 5;
slant     = pow (2 * slantin * slantin, 0.5);
eps       = 0;
hole_r1   = 2;
hole_r2   = 4.5;
height_h2 = 4;
cyl1_r    = 4.5;
cyl2_r    = 3.5;

module rounded_part () {
    translate ([0, cylh, 0])
    difference () {
        translate ([0, 0, -radius + height])
            union () {
                sphere (radius);
                rotate (90, [1, 0, 0])
                    cylinder (h=cylh, r = radius);
            }
        translate ([0, 0, -2 * radius])
            cube (4 * radius + eps, center = true);
        translate ([0, -(cylh + 2 * radius), 0])
            cube (4 * radius + eps, center = true);
        rotate (45, [1, 0, 0])
            translate ([0, -(cylh + 2 * radius) + slant, 0])
                cube (4 * radius + eps, center = true);
    }
}

difference () {
    union () {
        rounded_part ();
        rotate (-90, [1, 0, 0])
            rotate (180, [0, 0, 1])
                rounded_part ();
        translate ([0, 0, cylh])
            rotate (90, [1, 0, 0])
                rotate (90, [0, 0, 1])
                    union () {
                        cylinder (h=10, r=cyl1_r);
                        translate ([-1, 0, 0])
                            cylinder (h=16, r=cyl2_r);
                        translate ([-1, 0, 16])
                            cylinder (h=1, r1=cyl2_r, r2=cyl2_r - 1);
                        translate ([0, 0, 10])
                            cylinder (h=2, r1=cyl1_r, r2=cyl2_r - 2);
                    }
    }
    translate ([0, cylh, -height])
        cylinder (h = 2 * height, r=hole_r1);
    translate ([0, cylh, height_h2])
        cylinder (h = height, r=hole_r2);
}
