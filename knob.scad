module knob(axis_dia, knob_dia, axis_carve, conic, depth)
{
    epsilon = 0.1;
    top = 2.5;
    kr  = knob_dia / 2;
    ar  = axis_dia / 2;
    union () {
        difference () {
            cylinder (h = depth, r = kr);
            translate ([0, 0, -epsilon])
                cylinder (h = depth - top, r = ar);
        }
        translate ([0, (1-axis_carve) * axis_dia, (depth - top + epsilon) / 2])
            cube ([axis_dia, axis_dia, depth - top + epsilon], center = true);
    }
}

knob(4.5, 30, 0.25, 0, 15);
