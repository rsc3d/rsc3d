// Slice of a cylinder (think pie slice)
// Starts at Y-axis in negative clock direction around Z
module slice (r = 10, h = 10, ang = 30) {
    aa = (ang % 360 > 0) ? ang % 360 : ang % 360 + 360;
    rotate (-90) {
        difference() {
            cylinder (r = r, h = h);
            if (aa > 180)
                intersection_for (a = [0, 180 - aa])
                    rotate(-a) translate([-r, 0, -h])
                        cube ([r * 2, r * 2, 3 * h]);
            else union() for (a = [0, 180 - aa])
                rotate(-a) translate([-r, 0, -h])
                    cube ([r * 2, r * 2, 3 * h]);
        }
    }
}
