/*
 * This code is licensed under the CC BY-NC-SA 4.0 (Attribution-NonCommercial-ShareAlike).
 * Please read LICENCE.md for full details.
 *
 * A set of modules for creating bolt holes at specific sizes
 *
 * All of these modules will render flat on the XY plane and centered on the origin.
 * Heights are measured along the Y axis.
 * Widths are measured along the X axis.
 * Thickness are measured along the Z axis.
 */

/*
 * M mounting hole. Radius is (Msize/2) + 0.25mm
 * The 0.5mm gives some extra room so the bolt does not get restricted by the plastic & is free to move.
 *
 * size The size of the hole, e.g. 4 for a M4 bolt
 * t    The thickness of the material the hole is in
 */
module MHole(size,t) {
    translate([0, 0, -1]) cylinder( r=(size/2)+.5, h=t+2, $fn=80);
}

/*
 * A rectangular slotted hole for bolts, used so there's some directional movement in attaching something.
 *
 * boltSize     The diameter of the bolt this slot is to fit. 0.5mm either side will be included in the slot
 * height       The height of the slot in mm
 * thickness    The thickness of the material the slot is to cut out.
 */
 module BoltSlot( boltSize,height, thickness) {
    translate([-(boltSize+1)/2,-height/2,-(thickness+1)/2])
        cube([boltSize+1, height, thickness+1]);
 }

/*
 * A bar with multiple slots cut out of it
 *
 * width The width of the bar
 * height The height of the bar
 * thickness The thickness of the bar
 * boltSize The size of bolt that will be used in the slot, remember slots are 10mm apart!
 * baseOffset The offset from the bottom to the bottom of the slot
 * topOffset The offset from the top of the slot from the top of the bar
 */
module SlottedBar(width, height, thickness, boltSize, baseOffset, topOffset) {
    bo = baseOffset <=0 ? thickness : baseOffset;
    to = topOffset <= 0 ? thickness : topOffset;
    
    // Y offset to middle of slot
    dy = baseOffset + ((height-baseOffset-topOffset)/2);
    
    // last slot index that fits, first slot is #0
    numSlots = floor(width/10)-1;
    
    translate([-width/2, -height/2, -thickness/2])
        difference() {
            // Actual bar
            cube([width, height, thickness]);
            for( n = [0:numSlots] ) {
                translate([ 5+(10*n), dy, thickness/2 ])
                    BoltSlot( boltSize, height-baseOffset-topOffset, thickness );
            }
        }
}

SlottedBar( 100, 20, 5, 4, 5, 5 );

translate([0,30,0])
SlottedBar( 100, 20, 5, 4, 7, 5 );

//BoltSlot( 4, 20, 5);
