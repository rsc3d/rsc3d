include <dotSCAD/helix.scad>
include <dotSCAD/rotate_p.scad>
include <dotSCAD/cross_sections.scad>
include <dotSCAD/polysections.scad>
include <dotSCAD/helix_extrude.scad>

module lightcone (h=450, hb=30, ru=70, ro=22.5, w=3, w2=3, hole1=50.5, hole2=7)
{
    inner_f = (ro - hole2) / h;
    inner_w = (1-inner_f) * ro + (inner_f) * ru;
    factor  = 0.8;
    shape_pts = [[0, 0], [0, factor*hb+1], [ro, factor*hb+1], [ro, 0]];
    //polygon (points = shape_pts);
    difference () {
        union () {
            helix_extrude
                ( shape_pts
                , radius     = [ru-ro, 1]
                , levels     = h/hb
                , level_dist = hb
                , vt_dir     = "SPI_UP"
                );
            translate ([0, 0, (1-factor)*hb-1])
            helix_extrude
                ( shape_pts
                , radius     = [ru-ro, 1]
                , levels     = h/hb
                , level_dist = hb
                , vt_dir     = "SPI_UP"
                );
            cylinder (r=ru, h=hb);
        }
        translate ([0, 0, -1])
            cylinder (r1=ru-w, r2=ro-w, h=h+2);
        translate ([0, 0, h])
            cylinder (r=ru, h=2*hb);
    }
    translate ([0, 0, 0])
    difference () {
        cylinder (r=ru - (ru-ro) / (h/hb), h=w2);
        translate ([0, 0, -w2])
            cylinder (r=hole1, h=3*w2);
    }
    translate ([0, 0, h-(ro-hole2+w2)])
        difference () {
            cylinder (r1=inner_w, r2=ro, h=ro-hole2+w2);
            cylinder (r1=inner_w, r2=hole2, h=ro-hole2);
            translate ([0, 0, -(ro-hole2)])
                cylinder (r=hole2, h=3*(ro-hole2));
        }
}

h  = 450;
ru = 70;
fa = 3;
fs = 0.5;
//fa = 12;
//fs = 2;
hprint = 100;

part = 0;

difference () {
    lightcone (h=h, ru=ru, $fa=fa, $fs=fs);
    // cut away upper
    translate ([0, 0, (part + 1) * hprint])
        cylinder (r=2*ru, h=h);
    // cut away lower
    translate ([0, 0, -h + part * hprint])
        cylinder (r=2*ru, h=h);
    // for partially-printed part 0
    // translate ([0, 0, -h + 24.2])
    //     cylinder (r=2*ru, h=h);
    // for partially-printed part 3
    // translate ([0, 0, -h + part * hprint + 48])
    //     cylinder (r=2*ru, h=h);
}
