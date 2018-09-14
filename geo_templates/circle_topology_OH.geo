/**
 @brief  File Generating a Circle


          N

          x
        o   o
  E   x   c   x   W
        o   o
          x

          S

Parameters:

    cx
    cy
    cz
    
    Flag_Plane
    
    radius
    
    N -- longtitudal layers
    Nang -- angular layers
    Nrad -- radial layers

Returns:
  
  produces list  'surface' with five elements:
    s1                                // Center
    s2                            // North East
    s3                            // South East
    s4                            // South West
    s5                            // North West

*/


// ========================================================================= //
// Define Topology
// ========================================================================= //
Function OHCircle

  // Flag_Plane = 0, 1 or 2;
  // radius = 1;
  // cx = 0; cy = 0; cz = 0; Center
  
  dR = 0.5*radius;
  ri = 0.3*radius;
  lc = 0.1;
  //Nrad = 5;
  //Nang = 7;
  
  
   P2x = cx;  P2y = cy;  P2z = cz;               // Coordinates for "East" node
  Pi2x = cx; Pi2y = cy; Pi2z = cz;         // Coordinates for Inner "East" node
   P3x = cx;  P3y = cy;  P3z = cz;              // Coordinates for "North" node
  Pi3x = cx; Pi3y = cy; Pi3z = cz;        // Coordinates for Inner "North" node
   P4x = cx;  P4y = cy;  P4z = cz;               // Coordinates for "West" node
  Pi4x = cx; Pi4y = cy; Pi4z = cz;         // Coordinates for Inner "West" node
   P5x = cx;  P5y = cy;  P5z = cz;              // Coordinates for "South" node
  Pi5x = cx; Pi5y = cy; Pi5z = cz;        // Coordinates for Inner "South" node
  P32x = cx; P32y = cy; P32z = cz;    // Coordinates for "North East" (NE) node
  P54x = cx; P54y = cy; P54z = cz;    // Coordinates for "South West" (SW) node
  P52x = cx; P52y = cy; P52z = cz;    // Coordinates for "South East" (SE) node
  P34x = cx; P34y = cy; P34z = cz;    // Coordinates for "North West" (NW) node
  
  /* Define Geometry ------------------------------------------------------- */
  
  If(Flag_Plane==0) // XY Plane
     P2x += radius;  P3y += radius;
     P4x -= radius;  P5y -= radius;
  
    Pi4x = P4x + dR; Pi5y = P5y + dR;
    Pi2x = P2x - dR; Pi3y = P3y - dR;
  
    P32x += ri; P32y += ri;
    P54x -= ri; P54y -= ri;
    P52x += ri; P52y -= ri;
    P34x -= ri; P34y += ri;
  
  ElseIf( Flag_Plane == 1 ) // XZ Plane
  
     P2x += radius;  P3z += radius;
     P4x -= radius;  P5z -= radius;
  
    Pi4x = P4x + dR; Pi5z = P5z + dR;
    Pi2x = P2x - dR; Pi3z = P3z - dR;
  
    P32x += ri; P32z += ri;
    P54x -= ri; P54z -= ri;
    P52x += ri; P52z -= ri;
    P34x -= ri; P34z += ri;
  
  ElseIf( Flag_Plane == 2 ) // YZ Plane

     P2y += radius;  P3z += radius;
     P4y -= radius;  P5z -= radius;
  
    Pi4y = P4y + dR; Pi5z = P5z + dR;
    Pi2y = P2y - dR; Pi3z = P3z - dR;
  
    P32y += ri; P32z += ri;
    P54y -= ri; P54z -= ri;
    P52y += ri; P52z -= ri;
    P34y -= ri; P34z += ri;
   Else
     Abort;
  EndIf
  
  /* Declare Points -------------------------------------------------------- */
  
  center = newp; Point(center) = {cx,  cy,  cz, lc};                // "Centre"
  
  // Outer Circle
  p2 = newp; Point(p2) = {P3x, P3y, P3z, lc};                        // "North"
  p3 = newp; Point(p3) = {P2x, P2y, P2z, lc};                         // "East"
  p4 = newp; Point(p4) = {P4x, P4y, P4z, lc};                         // "West"
  p5 = newp; Point(p5) = {P5x, P5y, P5z, lc};                        // "South"

  o2 = newp; Point(o2) = {P32x, P32y, P32z, lc};                // "North East"
  o3 = newp; Point(o3) = {P52x, P52y, P52z, lc};                // "South East"
  o4 = newp; Point(o4) = {P54x, P54y, P54z, lc};                // "South West"
  o5 = newp; Point(o5) = {P34x, P34y, P34z, lc};                // "North West"

  // Inner 'Square'
  x2 = newp; Point(x2) = {Pi3x, Pi3y, Pi3z, lc};                     // "North"
  x3 = newp; Point(x3) = {Pi2x, Pi2y, Pi2z, lc};                      // "East"
  x4 = newp; Point(x4) = {Pi4x, Pi4y, Pi4z, lc};                      // "West"
  x5 = newp; Point(x5) = {Pi5x, Pi5y, Pi5z, lc};                     // "South"

  /* Declare Lines --------------------------------------------------------- */

  // Outer Circle
  lp1 = newl; Circle(lp1) = {p2, center, p3};                 // North --> East
  lp2 = newl; Circle(lp2) = {p3, center, p5};                 // East --> South
  lp3 = newl; Circle(lp3) = {p5, center, p4};                 // South --> West
  lp4 = newl; Circle(lp4) = {p4, center, p2};                 // West --> North

  // Inner Sqare
  lx1 = newl; Circle(lx1) = {x2, o4, x3};                     // North --> East
  lx2 = newl; Circle(lx2) = {x3, o5, x5};                     // East --> South
  lx3 = newl; Circle(lx3) = {x5, o2, x4};                     // South --> West
  lx4 = newl; Circle(lx4) = {x4, o3, x2};                     // West --> North

  // Connecting Inner and Outer Circle
  l1 = newl; Line(l1) = {x2, p2};            // North (inner) --> North (outer)
  l2 = newl; Line(l2) = {x3, p3};            // East  (inner) --> East  (outer)
  l3 = newl; Line(l3) = {x4, p4};            // West  (inner) --> West  (outer)
  l4 = newl; Line(l4) = {x5, p5};            // South (inner) --> South (outer)

  /* Define Topology ------------------------------------------------------- */

  f1 = newll; Line Loop(f1) = {lx1, lx2, lx3,  lx4};            // Inner Square
  f2 = newll; Line Loop(f2) = {l1,  lp1, -l2, -lx1};     // North East Quadrant
  f3 = newll; Line Loop(f3) = {l2,  lp2, -l4, -lx2};     // South East Quadrant
 // f4 = newll; Line Loop(f4) = {l4,  lp3, -l3, -lx3};     // South West Quadrant
 // f5 = newll; Line Loop(f5) = {l3,  lp4, -l1, -lx4};     // North West Quadrant
  f4 = newll; Line Loop(f4) = { l4,  lp3, -l3, -lx3};    // South West Quadrant
  f5 = newll; Line Loop(f5) = { l3,  lp4, -l1, -lx4};    // North West Quadrant
  
  // Declare Surfaces
  s1 = news; Plane Surface(s1) = {f1};                                // Center
  s2 = news; Plane Surface(s2) = {f2};                            // North East
  s3 = news; Plane Surface(s3) = {f3};                            // South East
  s4 = news; Plane Surface(s4) = {f4};                            // South West
  s5 = news; Plane Surface(s5) = {f5};                            // North West
  
  Transfinite Line{l1, l2, l3, l4} = Nrad + 1 Using Progression 0.9; // Radial Grid Points
  Transfinite Line{lp1, lp2, lp3, lp4, lx1, lx2, lx3, lx4} = Nang + 1; // Angular Grid Points
  
  surfaces = {s1, s2, s3, s4, s5};

  /* Mesh Generation ------------------------------------------------------- */
  Transfinite Surface{surfaces};
  Recombine Surface{surfaces};

Return

// ========================================================================= //
// Define Extrusions
// ========================================================================= //

Function LinearExtrusionOHCircle
  /**  Extrudes five (5) surfaces linearly
  
  Parameters
    len
    Flag_Plane
    N
  
  Returns
    newVol -- volume generated by extrusion
    surfaces -- surfaces at the end-point of the extrusion
    innerwalls -- all inner walls of the geometry
    outerwalls -- all outer walls of the geometry
  
  */

  Printf("Performing Linear Extrusion In-Plane");
  newVol     = {};
  innerwalls = {};
  outerwalls = {};

  If( Flag_Plane == 0 ) // XY Plane -- Z direction
    ex = 0; ey = 0; ez = 1;
  
  ElseIf( Flag_Plane == 1 ) // XZ Plane -- Y direction
    ex = 0; ey = 1; ez = 0;

  ElseIf ( Flag_Plane == 2 ) // YZ Plane => X direction
    ex = 1; ey = 0; ez = 0;

  Else
    Abort; // or Error or Exit ==> Abort current script or Exit GMSH
  EndIf
  
  /* ----------------------------------------------------------------------- */
  For i In {0:4} // There are five surfaces in the OH circle  
    out[] = Extrude {ex*len, ey*len, ez*len} {//  Outer: 3, Inner: 5, Sides: 2 and 4
      Surface{surfaces[i]};
      Layers{N};
      Recombine;
    };
    surfaces[i]  = out[0];                     // end-point of extruded surface
    newVol      += out[1];                                  // Generated Volume

    If( i == 0 ) // The "inner square" is always surface number Zero
      innerwalls += {out[2], out[3], out[4], out[5]};
    Else
      outerwalls += {out[3]};
      innerwalls += {out[2], out[4], out[5]};
    EndIf

  EndFor
  
Return



Function ElbowExtrusionOHCircle



  Outlet_Direction = 1;
  
  If(Flag_Plane == 0) // XY Plane
    Printf("  Starting in the XY Plane");
    X = 1;  Y = 0;  Z = 0;                           // rotation axis direction
    x = 1;  y = stop;  z = start;             // one point on the rotation axis
  
    If ( Flag_Plane_Bend == 1 )
      Printf("  Ending in XY Plane");
      X = 1;  Y = 0;   Z = 0;                        // rotation axis direction
      x = 0;  y = start;  z = stop;                 // one point on the rotation axis
  
      If ( len > 0 )
        Printf("  Positive extrusion direction implies negative angle");
        angle = -Pi/2; // rotation angle
      Else
        Printf("  Negative extrusion direction implies positive angle");
        angle = Pi/2; // rotation angle
      EndIf
  
      Update_Flag_Plane = 1;
    EndIf
  
  ElseIf (Flag_Plane == 1) // XZ Plane
    Printf("  Starting in the XZ Plane");
    If ( Flag_Plane_Bend == 0 )
      Printf("  Ending in XY Plane");
      X = 1;  Y = 0;   Z = 0;                        // rotation axis direction
      x = 0;  y = start;  z = stop;           // one point on the rotation axis
  
      If ( len > 0 )     // Determine rotation direction based on sign of "len"
        Printf("  Positive extrusion direction implies negative angle");
        angle = Pi/2; // rotation angle
      Else
        Printf("  Negative extrusion direction implies positive angle");
        angle = -Pi/2; // rotation angle
      EndIf
  
      Update_Flag_Plane = 0;
    EndIf
  
    Update_Flag_Plane = 0;
  
  ElseIf (Flag_Plane == 2) // YZ Plane
    Printf("  Starting in the YZ Plane");
    X = 0;  Y = 1;  Z = 0;
    Update_Flag_Plane = 2;
  EndIf
  

  For i In {0:4}

    out[] = Extrude { {X, Y, Z}, {x, y, z}, angle } {
      Surface{surfaces[i]};
      Layers{N};
      Recombine;
    };
    
    If( i == 0)
      surfaces[i]  = out[0];
      volumes     += out[1];
    Else
      surfaces[i] = out[0];
      volumes    += out[1];
      walls      += out[3]; // Outer: 3, Inner: 5, Sides: 2 and 4
    EndIf


  EndFor


  Flag_Plane = Update_Flag_Plane; // Update the directionality of the plane
Return

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
