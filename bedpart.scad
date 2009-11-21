//              +++++++++++++
//        +         |   |-h       +
//     +------------+   +------------+
//   +      r       |   |              +
//  +               |   |-radius        +
//  ----------------+   +----------------
//                     |radius
//
// (radius - r)² + r² = (radius)²
//

height    = 7.5;
r         = 11;
alpha     = 45;
radius    = ((height * height) + (r * r)) / r;
cylh      = 15;
eps       = 0;


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
    }
}

union () {
    rounded_part ();
    rotate (-90, [1, 0, 0])
        rotate (180, [0, 0, 1])
            rounded_part ();
    translate ([0, 2, 2])
        sphere (r);
}
