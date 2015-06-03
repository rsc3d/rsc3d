use <lib/slice.scad>
// starts at y axis + a1 in clock direction, continues for a2.
module arc (a1, a2, r, fw, h)
{
    rotate ([0, 0, a1])
    {
        difference () {
            slice (r, h, a2);
            rotate ([0, 0, -1])
                translate ([0, 0, -h])
                    slice (r - fw, 3 * h, a2 + 2);
        }
    }
}
