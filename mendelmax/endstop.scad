//    from http://www.thingiverse.com/thing:30085/#files
//    License CC-BY-SA
//    Heavily modified to look nice in OpenSCAD preview and for
//    dimensions of original Mendelmax endstop.

module endstop ()
{
    difference() {
	union() {
            cube([4, 53, 10]);  //4, 45, 10
            translate([8, 15, 0]) cylinder(h = 10, r = 8, $fn = 50);
            cube([16, 15, 10]);
            
            translate([17, 6, 5])
                cube([2, 5.75, 10], center = true);
            translate([17, 6, 5]) rotate([60, 0, 0])
                cube([2, 5.75, 10], center = true);
            translate([17, 6, 5]) rotate([120, 0, 0])
                cube([2, 5.75, 10], center = true);
	}
	translate([8, 15, 0])
            cylinder(h = 22, r = 4.1, center = true, $fn = 50);
	translate([5, -1, -1]) cube([6, 16, 12]);
	translate([-10, 6, 5]) rotate([0, 90, 0])
            cylinder(h = 30, r = 1.6, $fn= 20);
	translate([-10, 28, 5]) rotate([0, 90, 0])
            cylinder(h = 30, r = 1.6, $fn= 20);
	translate([-10, 28 + 19, 5]) rotate([0, 90, 0])
            cylinder(h = 30, r = 1.6, $fn= 20);
	translate([17.1, 6, 5])
            cube([2.2, 3.5, 6], center = true);
	translate([17.1, 6, 5]) rotate (a = [60, 0, 0])
            cube([2.2, 3.5, 6], center = true);
	translate([17.1, 6, 5]) rotate (a = [120, 0, 0])
            cube([2.2, 3.5, 6], center = true);
    }
}

translate ([-20, 0, 0]) endstop ();
translate ([  0, 0, 0]) endstop ();
