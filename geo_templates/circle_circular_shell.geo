/* Define Geometry of a circular shell
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
 *     radius    -- radius of circle
 *     thickness -- shell thickness
 *     
 *     N -- longtitudal layers
 *     Nang -- angular layers
 *     Nrad -- radial layers
 * 
 * Returns:
 *   
 *   produces list  'surface' with five elements:
 *     s1                            // North
 *     s2                            // West
 *     s3                            // South
 *     s4                            // East
 * 
*/


// ========================================================================= //
// Define Topology
// ========================================================================= //
Function CircleShellCircleCore

  /* Define Geometry ------------------------------------------------------- */

  O1x = cx;  O1y = cy;  O1z = cz;          // Coordinates for "North East" node
  O2x = cx;  O2y = cy;  O2z = cz;          // Coordinates for "North West" node
  O3x = cx;  O3y = cy;  O3z = cz;          // Coordinates for "South West" node
  O4x = cx;  O4y = cy;  O4z = cz;          // Coordinates for "South East" node
  
  I1x = cx;  I1y = cy;  I1z = cz;          // Coordinates for "North East" node
  I2x = cx;  I2y = cy;  I2z = cz;          // Coordinates for "North West" node
  I3x = cx;  I3y = cy;  I3z = cz;          // Coordinates for "South West" node
  I4x = cx;  I4y = cy;  I4z = cz;          // Coordinates for "South East" node

  If(Flag_Plane==0)                          // XY Plane (extrude along Z-axis)
    O1x += (thickness + radius)*Cos(  Pi/4); O1y += (thickness + radius)*Sin(  Pi/4);
    O2x += (thickness + radius)*Cos(3*Pi/4); O2y += (thickness + radius)*Sin(3*Pi/4);
    O3x += (thickness + radius)*Cos(5*Pi/4); O3y += (thickness + radius)*Sin(5*Pi/4);
    O4x += (thickness + radius)*Cos(7*Pi/4); O4y += (thickness + radius)*Sin(7*Pi/4);
    
    I1x += radius*Cos(  Pi/4); I1y += radius*Sin(  Pi/4);
    I2x += radius*Cos(3*Pi/4); I2y += radius*Sin(3*Pi/4);
    I3x += radius*Cos(5*Pi/4); I3y += radius*Sin(5*Pi/4);
    I4x += radius*Cos(7*Pi/4); I4y += radius*Sin(7*Pi/4);

    ex = 0; ey = 0; ez = 1;
  
  ElseIf (Flag_Plane==1)                     // XZ Plane (extrude along Y-axis)
    O1x += (thickness + radius)*Cos(  Pi/4); O1z += (thickness + radius)*Sin(  Pi/4);
    O2x += (thickness + radius)*Cos(3*Pi/4); O2z += (thickness + radius)*Sin(3*Pi/4);
    O3x += (thickness + radius)*Cos(5*Pi/4); O3z += (thickness + radius)*Sin(5*Pi/4);
    O4x += (thickness + radius)*Cos(7*Pi/4); O4z += (thickness + radius)*Sin(7*Pi/4);
    
    I1x += radius*Cos(  Pi/4);                       I1z += radius*Sin(  Pi/4);
    I2x += radius*Cos(3*Pi/4);                       I2z += radius*Sin(3*Pi/4);
    I3x += radius*Cos(5*Pi/4);                       I3z += radius*Sin(5*Pi/4);
    I4x += radius*Cos(7*Pi/4);                       I4z += radius*Sin(7*Pi/4);

    ex = 0; ey = 1; ez = 0;
  
  ElseIf (Flag_Plane==2)                     // YZ Plane (extrude along X-axis)
    O1y += (thickness + radius)*Cos(  Pi/4); O1z += (thickness + radius)*Sin(  Pi/4);
    O2y += (thickness + radius)*Cos(3*Pi/4); O2z += (thickness + radius)*Sin(3*Pi/4);
    O3y += (thickness + radius)*Cos(5*Pi/4); O3z += (thickness + radius)*Sin(5*Pi/4);
    O4y += (thickness + radius)*Cos(7*Pi/4); O4z += (thickness + radius)*Sin(7*Pi/4);
    
                          I1y += radius*Cos(  Pi/4); I1z += radius*Sin(  Pi/4);
                          I2y += radius*Cos(3*Pi/4); I2z += radius*Sin(3*Pi/4);
                          I3y += radius*Cos(5*Pi/4); I3z += radius*Sin(5*Pi/4);
                          I4y += radius*Cos(7*Pi/4); I4z += radius*Sin(7*Pi/4);

    ex = 1; ey = 0; ez = 0;

  EndIf

  center = newp; Point(center) = {cx, cy, cz, lc};

  o1 = newp; Point(o1) = {O1x, O1y, O1z, lc};
  o2 = newp; Point(o2) = {O2x, O2y, O2z, lc};
  o3 = newp; Point(o3) = {O3x, O3y, O3z, lc};
  o4 = newp; Point(o4) = {O4x, O4y, O4z, lc};
  
  i1 = newp; Point(i1) = {I1x, I1y, I1z, lc};
  i2 = newp; Point(i2) = {I2x, I2y, I2z, lc};
  i3 = newp; Point(i3) = {I3x, I3y, I3z, lc};
  i4 = newp; Point(i4) = {I4x, I4y, I4z, lc};
  
  // North
  a1 = newl; Circle(a1) = {o1, center, o2};
  r1 = newl; Line(r1)   = {i2, o2};
  a2 = newl; Circle(a2) = {i2, center, i1};
  r2 = newl; Line(r2)   = {i1, o1};
  
  // West
  a3 = newl; Circle(a3) = {o2, center, o3};
  r3 = newl; Line(r3)   = {i3, o3};
  a4 = newl; Circle(a4) = {i3, center, i2};
  
  // South
  a5 = newl; Circle(a5) = {o3, center, o4};
  r4 = newl; Line(r4)   = {i4, o4};
  a6 = newl; Circle(a6) = {i4, center, i3};
  
  // East
  a7 = newl; Circle(a7) = {o4, center, o1};
  a8 = newl; Circle(a8) = {i1, center, i4};
  
  
  ll1 = newll; Line Loop(ll1) = {a1, -r1, a2, r2}; // North
  ll2 = newll; Line Loop(ll2) = {a3, -r3, a4, r1}; // West
  ll3 = newll; Line Loop(ll3) = {a5, -r4, a6, r3}; // South
  ll4 = newll; Line Loop(ll4) = {a7, -r2, a8, r4}; // East
  
  s1 = news; Surface(s1) = { ll1 };
  s2 = news; Surface(s2) = { ll2 };
  s3 = news; Surface(s3) = { ll3 };
  s4 = news; Surface(s4) = { ll4 };
  
  surfaces = {s1, s2, s3, s4};
  
  /* Define Mesh ----------------------------------------------------------- */
  Transfinite Line{r1, r2, r3, r4} = Nrad + 1 Using Progression 0.9;
  Transfinite Line{a1, a2, a3, a4, a5, a6, a7, a8} = Nang + 1 Using Bump 1;

  // Transfinite Surface "*";
  // Recombine Surface "*";

Return


// ========================================================================= //
// Define Extrusions
// ========================================================================= //

Function LinearExtrusionCircleShell

  Printf("Performing Linear Extrusion In-Plane");
  newVol    = {};
  intrawalls = {};
  innerwalls = {};
  outerwalls = {};

  If( Flag_Plane == 0 ) // XY Plane (extrude in Z direction)
    ex = 0; ey = 0; ez = 1;
  EndIf
  
  If ( Flag_Plane == 1 ) // XZ Plane (extrude in Y direction)
    ex = 0; ey = 1; ez = 0;
  EndIf
  
  If ( Flag_Plane == 2 ) // YZ Plane (extrude in X direction)
    ex = 1; ey = 0; ez = 0;
  EndIf
  
  /* ----------------------------------------------------------------------- */
  For i In {0:3} // The Shell has four surfaces  
    out[] = Extrude {ex*len, ey*len, ez*len} {//  Outer: 3, Inner: 5, Sides: 2 and 4
      Surface{surfaces[i]};
      Layers{N};
      Recombine;
    };
    surfaces[i] = out[0];
    newVol     += out[1];
    outerwalls += out[2];
    intrawalls += out[3];
    innerwalls += out[4];
    intrawalls += out[5];
  EndFor
  
Return


// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
