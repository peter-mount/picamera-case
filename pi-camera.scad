/*
 * Raspberry PI HQ Camera Case
 *
 * This is a 3D printed case for the Raspberry PI HQ Camera
 */

/*
 * Parameters from Raspberry PI mecanical drawings
 */

CAM_WIDTH       = 38;       // 38mm square
CAM_DEPTH       = 10.2;     // Depth from front to pcb
CAM_PCB_THICK   = 1.4;      // Thickness of PCB
CAM_MOUNT_INDENT= 4;        // Indent from corners to mount holes

CAM_DIAM        = 36;       // 36mm diameter for C/CS mount
CAM_TOP_WIDTH   = 10.16;    // width of top bracket
CAM_BOT_WIDTH   = 13.97;    // Width of bottom bracket
CAM_BOT_DEPTH   = 7.62;     // Hepth of bottom bracket

CAM_WIDTH2      = CAM_WIDTH/2;
CAM_MARGIN_B    = 10;       // Margin below camera to allow for mount
CAM_MARGIN_W    = 3;        // Side margin
CAM_MARGIN_T    = 5;        // Top margin to allow for mount


use <warpDisk.scad>;
use <boltHoles.scad>;

/*
 * Camera mount
 *
 * shoe=1 to include the hotshoe
 */
module camera_mount(shoe=0) {
    d=CAM_DEPTH + CAM_PCB_THICK +2;

    difference() {
        // Outer shell
        translate([-CAM_WIDTH2-CAM_MARGIN_W,-CAM_WIDTH2-CAM_MARGIN_B,-d])
            cube([
                CAM_WIDTH + CAM_MARGIN_W + CAM_MARGIN_W,
                CAM_WIDTH + CAM_MARGIN_B + CAM_MARGIN_T,
                d
                ]);

        // Inner enclosure
        translate([-CAM_WIDTH2-1,-CAM_WIDTH2-1-7,-d-1])
            cube([
                CAM_WIDTH + 2,
                CAM_WIDTH + 2 + 7,
                d
                ]);

        // Slot for top
        translate([-1-CAM_TOP_WIDTH/2,0,-d-1])
            cube([CAM_TOP_WIDTH+2, CAM_WIDTH2+4,d]);

        // Slot for base mount
        translate([-1-CAM_BOT_WIDTH/2,-CAM_WIDTH,-d-1])
            cube([CAM_BOT_WIDTH+2, CAM_WIDTH2+4,d]);

        // Cutout camera body
        translate([0,0,-1-d])
            cylinder(r=(CAM_DIAM/2)+0.5, h=d+2, $fn=120);

        // Mounting holes
        for(x=[CAM_MOUNT_INDENT-CAM_WIDTH2, CAM_WIDTH2-CAM_MOUNT_INDENT]) {
            for(y=[CAM_MOUNT_INDENT-CAM_WIDTH2, CAM_WIDTH2-CAM_MOUNT_INDENT]) {
                translate([x,y,-1]) MHole(2.5,3);
            }
        }
    }

    for( x=[-CAM_WIDTH2 -CAM_MARGIN_W -3, CAM_WIDTH2 +CAM_MARGIN_W +3] ) {
        for( y=[ -CAM_WIDTH2 -CAM_MARGIN_B -3, CAM_WIDTH2 +CAM_MARGIN_B -3 ] ) {
            WarpDisk( x,y, -0.5);
        }
    }

    if(shoe) {
        hotshoe(d);
    }
}

/*
 * Backplate for the camera mount
 *
 */
module camera_backplate(shoe=0) {
    d=CAM_DEPTH + CAM_PCB_THICK +2;

    difference() {
        // Outer shell
        translate([-CAM_WIDTH2-CAM_MARGIN_W,-CAM_WIDTH2-CAM_MARGIN_B,-d])
            cube([
                CAM_WIDTH + CAM_MARGIN_W + CAM_MARGIN_W,
                CAM_WIDTH + CAM_MARGIN_B + CAM_MARGIN_T,
                d
                ]);

        // Inner enclosure
        translate([-CAM_WIDTH2-1,-CAM_WIDTH2-1-7,1-d])
            cube([
                CAM_WIDTH + 2,
                CAM_WIDTH + 2 + 7,
                d
                ]);

        // Mounting holes
        for(x=[CAM_MOUNT_INDENT-CAM_WIDTH2, CAM_WIDTH2-CAM_MOUNT_INDENT]) {
            for(y=[CAM_MOUNT_INDENT-CAM_WIDTH2, CAM_WIDTH2-CAM_MOUNT_INDENT]) {
                translate([x,y,-d-1]) MHole(2.5,3);
            }
        }

        // Slot for feeding the camera cable through
        cw=20;
        cd=2;
        translate([-cw/2,-cd/2,-d-1])
            cube([cw,cd,3]);
    }

    translate([0,0,-13.1])
    for( x=[-CAM_WIDTH2 -CAM_MARGIN_W -3, CAM_WIDTH2 +CAM_MARGIN_W +3] ) {
        for( y=[ -CAM_WIDTH2 -CAM_MARGIN_B -3, CAM_WIDTH2 +CAM_MARGIN_B -3 ] ) {
            WarpDisk( x,y, -0.5);
        }
    }

    if(shoe) {
        hotshoe(d);
    }
}

/*
 * Raspberry PI 4 enclosure base
 */
module camera_PI3A_base() {
    d=12;//CAM_DEPTH + CAM_PCB_THICK +2;

    // Raspberry PI 3A+ board dimensions
    //pw=52.5;
    //ph=65;
    pw=65;
    ph=52.5;
    pw2=pw/2;
    ph2=ph/2;

    difference() {
        // Outer shell
        translate([-pw2-CAM_MARGIN_W,-CAM_WIDTH2-CAM_MARGIN_B,-d])
            cube([
                pw+CAM_MARGIN_W+CAM_MARGIN_W,
                ph+CAM_MARGIN_T+CAM_MARGIN_T,
                d
                ]);

        // Inner enclosure
        translate([1-pw2-CAM_MARGIN_W,1-CAM_WIDTH2-CAM_MARGIN_B,-d-1])
            cube([
                pw+CAM_MARGIN_W+CAM_MARGIN_W-2,
                ph+CAM_MARGIN_T+CAM_MARGIN_T-2,
                //CAM_WIDTH + 2,
                //CAM_WIDTH + 2 + 7,
                d
                ]);

        // SD Card Slot
        translate([-1-pw2-CAM_MARGIN_W,-7.5,-d-1])
            cube([3,15,4]);

        // Mounting holes for the camera
        for(x=[CAM_MOUNT_INDENT-CAM_WIDTH2, CAM_WIDTH2-CAM_MOUNT_INDENT]) {
            for(y=[CAM_MOUNT_INDENT-CAM_WIDTH2, CAM_WIDTH2-CAM_MOUNT_INDENT]) {
                translate([x,y,-1]) MHole(2.5,3);
            }
        }

        // Slot for feeding the camera cable through
        cw=20;
        cd=2;
        translate([-cw/2,-cd/2,-2])
            cube([cw,cd,4]);

        // Mounting holes for the Raspberry PI 3A+
        translate([-pw2-CAM_MARGIN_W+3,-CAM_WIDTH2-CAM_MARGIN_B+4,-1]) {
            translate([3.5, 3.5, 0]) {
                MHole(2.5,5);
                translate([58, 0, 0]) MHole(2.5,5);
                translate([0, 49, 0]) {
                    MHole(2.5,5);
                    translate([58, 0, 0]) MHole(2.5,5);
                }
            }
        }
    }

    for( x=[-pw2-CAM_MARGIN_W -3, pw2+CAM_MARGIN_W +3] ) {
        for( y=[ -CAM_WIDTH2-CAM_MARGIN_B -3, ph-CAM_WIDTH2+CAM_MARGIN_B -7 ] ) {
            WarpDisk( x,y, -0.6);
        }
    }
}

/*
 * Raspberry PI 4 enclosure top
 */
module camera_PI3A_top() {
    d=21;//12;//CAM_DEPTH + CAM_PCB_THICK +2;

    // Raspberry PI 3A+ board dimensions
    //pw=52.5;
    //ph=65;
    pw=65;
    ph=52.5;
    pw2=pw/2;
    ph2=ph/2;

    difference() {
        union() {
            // Outer shell
            translate([-pw2-CAM_MARGIN_W,-CAM_WIDTH2-CAM_MARGIN_B,-d])
                cube([
                    pw+CAM_MARGIN_W+CAM_MARGIN_W,
                    ph+CAM_MARGIN_T+CAM_MARGIN_T,
                    d
                    ]);

        }

        // Inner enclosure
        translate([1-pw2-CAM_MARGIN_W,1-CAM_WIDTH2-CAM_MARGIN_B,1-d])
            cube([
                pw+CAM_MARGIN_W+CAM_MARGIN_W-2,
                ph+CAM_MARGIN_T+CAM_MARGIN_T-2,
                d
                ]);

        // USB A socket
        translate([-2+pw2+CAM_MARGIN_W,-16/2,-2-8])
            cube([3,16,11]);

        // Power, HDMI & Audio/Composite sockets
        translate([9-pw2-CAM_MARGIN_W, -1+CAM_WIDTH2+CAM_MARGIN_B ,-10])
                    cube([pw-3-9, 8,10.5]);

        // Ventilation
        for(y=[-3:4]) {
            translate([-15,5*y,-1-d])
                cube([30,2,5]);
        }

        // Mounting holes for the Raspberry PI 3A+
        translate([-pw2-CAM_MARGIN_W+3,-CAM_WIDTH2-CAM_MARGIN_B+4,-d]) {
            translate([3.5, 3.5, 0]) {
                MHole(2.5,5);
                translate([58, 0, 0]) MHole(2.5,5);
                translate([0, 49, 0]) {
                    MHole(2.5,5);
                    translate([58, 0, 0]) MHole(2.5,5);
                }
            }
        }
    }

    for( x=[-pw2-CAM_MARGIN_W -3, pw2+CAM_MARGIN_W +3] ) {
        for( y=[ -CAM_WIDTH2-CAM_MARGIN_B -3, ph-CAM_WIDTH2+CAM_MARGIN_B -7 ] ) {
            WarpDisk( x,y, -d);
        }
    }
}

/* Optional hotshoe mount */
module hotshoe(d) {
    difference() {
        translate([0,CAM_WIDTH2+CAM_MARGIN_B-3,-d/2])
            cube([20,5,d], center=true);
        translate([0,CAM_WIDTH2+CAM_MARGIN_B+4,-d/2]) difference() {
            cube([20,14.8,17.5], center=true);
            translate([0,-7.6,0]) cube([9.4,2.5,17.5], center=true);
            translate([-8.125,-0.60,0]) cube([3.99,10,17.5], center=true);
            translate([-9.65,-6.5,0]) cube([1,2,17.9], center=true);
            translate([8.125,-0.60,0]) cube([3.99,10,17.5], center=true);
            translate([9.65,-6.5,0]) cube([1,2,17.9], center=true);
        }
        translate([0,CAM_WIDTH2+CAM_MARGIN_B-2.5,1-d/2])
            cube([12,2,d+3], center=true);
    }
}

/*
 * Module to show everything in place
 *
 * This is used to ensure it all fits together
 */
module assembly() {
    camera_mount(1);
    translate([0,0, -CAM_WIDTH2+5]) camera_backplate(1);
    translate([0,0, -CAM_WIDTH+8]) camera_PI3A_base();
    translate([0,0, -CAM_WIDTH-5]) camera_PI3A_top();
}

assembly();
