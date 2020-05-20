/*
 * This code is licensed under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike).
 * Please read LICENCE.md for full details.
 *
 * A warp disk which is a simple 10mm x 0.6mm disk which is placed just touching a base corner of your model.
 * These disks then give the model extra area against a heated base plate on the printer and help in reducing
 * warping of the model
 */

module WarpDisk(x,y,z) {
    translate([x,y,z]) cylinder(r=5,h=.6,$fn=30);
}

