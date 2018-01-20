include <dotSCAD/helix.scad>
include <dotSCAD/rotate_p.scad>
include <dotSCAD/cross_sections.scad>
include <dotSCAD/polysections.scad>
include <dotSCAD/helix_extrude.scad>

module lightcone (h=450, hb=30, ru=65, ro=30, w=10)
{
    shape_pts = [[0, 0], [0, hb/2+1], [ro, hb/2+1], [ro, 0]];
    //polygon (points = shape_pts);
    difference () {
        union () {
            render ()
            helix_extrude
                ( shape_pts
                , radius     = [ru-ro, 1]
                , levels     = h/hb - 1
                , level_dist = hb
                , vt_dir     = "SPI_UP"
                );
            translate ([0, 0, hb/2-1])
            helix_extrude
                ( shape_pts
                , radius     = [ru-ro, 1]
                , levels     = h/hb - 1
                , level_dist = hb
                , vt_dir     = "SPI_UP"
                );
            cylinder (r=ru - (ru-ro) / (h/hb), h=hb);
        }
        translate ([0, 0, -1])
            cylinder (r1=ru-w, r2=ro-w, h=h+2);
    }
}

//lightcone ($fa = 1, $fs = .5);
lightcone ();
