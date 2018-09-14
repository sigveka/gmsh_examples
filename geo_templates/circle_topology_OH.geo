/**
 * @brief  File Generating a Circle
 * 
 * 
 *           N
 * 
 *           x
 *         o   o
 *   E   x   c   x   W
 *         o   o
 *           x
 * 
 *           S
 * 
 * Parameters:
 * 
 *     cx
 *     cy
 *     cz
 *     
 *     Flag_Plane
 *     
 *     radius
 *     ratio
 *     
 *     N -- longtitudal layers
 *     Nang -- angular layers
 *     Nrad -- radial layers
 * 
 * Returns:
 *   
 *   produces list  'surface' with five elements:
 *     s1                                // Center
 *     s2                            // North East
 *     s3                            // South East
 *     s4                            // South West
 *     s5                            // North West
 * 
**/


// ========================================================================= //
// Define Topology
// ========================================================================= //
Function OHCircle
  ratio = 0.6;
  lc = 0.1;
  rot = 0;
  //Nrad = 5;
  //Nang = 7;
  

  /* Define Geometry ------------------------------------------------------- */

  // Coordinates for "Outer Circle"
  O1x = cx;  O1y = cy;  O1z = cz;                // Coordinates for "East" node
  O2x = cx;  O2y = cy;  O2z = cz;               // Coordinates for "North" node
  O3x = cx;  O3y = cy;  O3z = cz;                // Coordinates for "West" node
  O4x = cx;  O4y = cy;  O4z = cz;               // Coordinates for "South" node

  // Coordinates for "Inner Circle"
  I1x = cx;  I1y = cy;  I1z = cz;                // Coordinates for "East" node
  I2x = cx;  I2y = cy;  I2z = cz;               // Coordinates for "North" node
  I3x = cx;  I3y = cy;  I3z = cz;                // Coordinates for "West" node
  I4x = cx;  I4y = cy;  I4z = cz;               // Coordinates for "South" node

  // Coordinates for "Inner Square"
  S1x = cx;  S1y = cy;  S1z = cz;                // Coordinates for "East" node
  S2x = cx;  S2y = cy;  S2z = cz;               // Coordinates for "North" node
  S3x = cx;  S3y = cy;  S3z = cz;                // Coordinates for "West" node
  S4x = cx;  S4y = cy;  S4z = cz;               // Coordinates for "South" node


  If(Flag_Plane==0)                          // XY Plane (extrude along Z-axis)
    O1x += radius*Cos(  Pi/4 + rot); O1y += radius*Sin(  Pi/4 + rot);
    O2x += radius*Cos(3*Pi/4 + rot); O2y += radius*Sin(3*Pi/4 + rot);
    O3x += radius*Cos(5*Pi/4 + rot); O3y += radius*Sin(5*Pi/4 + rot);
    O4x += radius*Cos(7*Pi/4 + rot); O4y += radius*Sin(7*Pi/4 + rot);

    I1x += ratio*radius*Cos(  Pi/4 + rot); I1y += ratio*radius*Sin(  Pi/4 + rot);
    I2x += ratio*radius*Cos(3*Pi/4 + rot); I2y += ratio*radius*Sin(3*Pi/4 + rot);
    I3x += ratio*radius*Cos(5*Pi/4 + rot); I3y += ratio*radius*Sin(5*Pi/4 + rot);
    I4x += ratio*radius*Cos(7*Pi/4 + rot); I4y += ratio*radius*Sin(7*Pi/4 + rot);

    S1x += ratio*radius*Cos(rot);          S1y += ratio*radius*Sin(rot);
    S2x += ratio*radius*Cos(Pi/2   + rot); S2y += ratio*radius*Sin(Pi/2   + rot);
    S3x += ratio*radius*Cos(Pi     + rot); S3y += ratio*radius*Sin(Pi     + rot);
    S4x += ratio*radius*Cos(3/2*Pi + rot); S4y += ratio*radius*Sin(3/2*Pi + rot);

    ex = 0; ey = 0; ez = 1;
  
  ElseIf (Flag_Plane==1)                     // XZ Plane (extrude along Y-axis)
    O1x += radius*Cos(  Pi/4 + rot); O1z += radius*Sin(  Pi/4 + rot);
    O2x += radius*Cos(3*Pi/4 + rot); O2z += radius*Sin(3*Pi/4 + rot);
    O3x += radius*Cos(5*Pi/4 + rot); O3z += radius*Sin(5*Pi/4 + rot);
    O4x += radius*Cos(7*Pi/4 + rot); O4z += radius*Sin(7*Pi/4 + rot);

    I1x += ratio*radius*Cos(  Pi/4 + rot); I1z += ratio*radius*Sin(  Pi/4 + rot);
    I2x += ratio*radius*Cos(3*Pi/4 + rot); I2z += ratio*radius*Sin(3*Pi/4 + rot);
    I3x += ratio*radius*Cos(5*Pi/4 + rot); I3z += ratio*radius*Sin(5*Pi/4 + rot);
    I4x += ratio*radius*Cos(7*Pi/4 + rot); I4z += ratio*radius*Sin(7*Pi/4 + rot);

    S1x += ratio*radius*Cos(rot);          S1z += ratio*radius*Sin(rot);
    S2x += ratio*radius*Cos(Pi/2   + rot); S2z += ratio*radius*Sin(Pi/2   + rot);
    S3x += ratio*radius*Cos(Pi     + rot); S3z += ratio*radius*Sin(Pi     + rot);
    S4x += ratio*radius*Cos(3/2*Pi + rot); S4z += ratio*radius*Sin(3/2*Pi + rot);

    ex = 0; ey = 1; ez = 0;
  
  ElseIf (Flag_Plane==2)                     // YZ Plane (extrude along X-axis)
    O1y += radius*Cos(  Pi/4 + rot); O1z += radius*Sin(  Pi/4 + rot);
    O2y += radius*Cos(3*Pi/4 + rot); O2z += radius*Sin(3*Pi/4 + rot);
    O3y += radius*Cos(5*Pi/4 + rot); O3z += radius*Sin(5*Pi/4 + rot);
    O4y += radius*Cos(7*Pi/4 + rot); O4z += radius*Sin(7*Pi/4 + rot);

    I1y += ratio*radius*Cos(  Pi/4 + rot); I1z += ratio*radius*Sin(  Pi/4 + rot);
    I2y += ratio*radius*Cos(3*Pi/4 + rot); I2z += ratio*radius*Sin(3*Pi/4 + rot);
    I3y += ratio*radius*Cos(5*Pi/4 + rot); I3z += ratio*radius*Sin(5*Pi/4 + rot);
    I4y += ratio*radius*Cos(7*Pi/4 + rot); I4z += ratio*radius*Sin(7*Pi/4 + rot);

    S1y += ratio*radius*Cos(rot);          S1z += ratio*radius*Sin(rot);
    S2y += ratio*radius*Cos(Pi/2   + rot); S2z += ratio*radius*Sin(Pi/2   + rot);
    S3y += ratio*radius*Cos(Pi     + rot); S3z += ratio*radius*Sin(Pi     + rot);
    S4y += ratio*radius*Cos(3/2*Pi + rot); S4z += ratio*radius*Sin(3/2*Pi + rot);

    ex = 1; ey = 0; ez = 0;

  EndIf

  center = newp; Point(center) = {cx,  cy, cz, lc};                   // Centre
  
  // Declare points on the circle
  o1 = newp; Point(o1) = {O1x, O1y, O1z, lc};                           // East
  o2 = newp; Point(o2) = {O2x, O2y, O2z, lc};                          // North
  o3 = newp; Point(o3) = {O3x, O3y, O3z, lc};                           // West
  o4 = newp; Point(o4) = {O4x, O4y, O4z, lc};                          // South
  
  s1 = newp; Point(s1) = { S1x, S1y, S1z, lc};                          // East
  s2 = newp; Point(s2) = { S2x, S2y, S2z, lc};                         // North
  s3 = newp; Point(s3) = { S3x, S3y, S3z, lc};                          // West
  s4 = newp; Point(s4) = { S4x, S4y, S4z, lc};                         // South
  
  // Declare Points for the inner square
  i1 = newp; Point(i1) = {I1x, I1y, I1z, lc};                           // East
  i2 = newp; Point(i2) = {I2x, I2y, I2z, lc};                          // North 
  i3 = newp; Point(i3) = {I3x, I3y, I3z, lc};                           // West
  i4 = newp; Point(i4) = {I4x, I4y, I4z, lc};                          // South
  
  // Declare Lines
  a1 = newl; Circle(a1) = {o1, center, o2};
  r1 = newl; Line(r1)   = {i2, o2};
  a2 = newl; Circle(a2) = {i2, s4, i1}; 
  r2 = newl; Line(r2)   = {i1, o1};
  
  a3 = newl; Circle(a3) = {o2, center, o3};
  r3 = newl; Line(r3)   = {i3, o3};
  a4 = newl; Circle(a4) = {i3, s1, i2};
  
  a5 = newl; Circle(a5) = {o3, center, o4};
  r4 = newl; Line(r4)   = {i4, o4};
  a6 = newl; Circle(a6) = {i4, s2, i3};
  
  a7 = newl; Circle(a7) = {o4, center, o1};
  a8 = newl; Circle(a8) = {i1, s3, i4};
  
  /* Define Topology ------------------------------------------------------- */
  
  ll0 = newll; Line Loop(ll0) = {-a2, -a4, -a6, -a8};
  
  ll1 = newll; Line Loop(ll1) = {a1, -r1, a2, r2};            // North Quadrant
  ll2 = newll; Line Loop(ll2) = {a3, -r3, a4, r1};             // West Quadrant
  ll3 = newll; Line Loop(ll3) = {a5, -r4, a6, r3};            // South Quadrant
  ll4 = newll; Line Loop(ll4) = {a7, -r2, a8, r4};             // East Quadrant
  
  s0 = news; Plane Surface(s0) = {ll0};
  s1 = news; Plane Surface(s1) = {ll1};
  s2 = news; Plane Surface(s2) = {ll2};
  s3 = news; Plane Surface(s3) = {ll3};
  s4 = news; Plane Surface(s4) = {ll4};
  
  surfaces = {s0, s1, s2, s3, s4};
  
  /* Mesh Generation ------------------------------------------------------- */
  Transfinite Line{r1, r2,  r3, r4} = Nrad + 1 Using Progression 0.9;
  Transfinite Line{a1, a2, a3, a4, a5, a6, a7, a8} = Nang + 1 Using Bump 1;


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
    lx = 0; ly = 0; lz = len;
  
  ElseIf( Flag_Plane == 1 ) // XZ Plane -- Y direction
    lx = 0; ly = len; lz = 0;

  ElseIf ( Flag_Plane == 2 ) // YZ Plane => X direction
    lx = len; ly = 0; lz = 0;

  Else
    Abort; // or Error or Exit ==> Abort current script or Exit GMSH
  EndIf
  
  /* ----------------------------------------------------------------------- */
  For i In {0:4} // There are five surfaces in the OH circle  
    out[] = Extrude {lx, ly, lz} {//  Outer: 3, Inner: 5, Sides: 2 and 4
      Surface{surfaces[i]};
      Layers{N};
      Recombine;
    };
    surfaces[i]  = out[0];                     // end-point of extruded surface
    newVol      += out[1];                                  // Generated Volume

    If( i == 0 ) // The "inner square" is always surface number Zero
      innerwalls += {out[2], out[3], out[4], out[5]};
    Else
      outerwalls += {out[2]};
      innerwalls += {out[3], out[4], out[5]};
    EndIf

  EndFor
  
Return



Function ElbowExtrusionOHCircle



  Outlet_Direction = 1;
  
  If(Flag_Plane == 0) // XY Plane
    Printf("  Starting in the XY Plane");
    X = 1;  Y = 0;  Z = 0;                             // rotation axis direction
    x = 1;  y = stop;  z = start;               // one point on the rotation axis
  
    If ( Flag_Plane_Bend == 1 )
      Printf("  Ending in XY Plane");
      X = 1;  Y = 0;   Z = 0;                        // rotation axis direction
      x = 0;  y = 12;  z = 2;             // one point on the rotation axis
  
      If ( length > 0 )
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
      X = 1;  Y = 0;   Z = 0;                             // rotation axis direction
        x = 0;  y = start;  z = stop;               // one point on the rotation axis
  
      If ( length > 0 )
        Printf("  Positive extrusion direction implies negative angle");
        angle = Pi/2; // rotation angle
      Else
        Printf("  Negative extrusion direction implies positive angle");
        angle = -Pi/2; // rotation angle
      EndIf
  
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
