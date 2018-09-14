/* Define Geometry for a square shell around a circle


  Ne --------N--------- Ne
  |                     |
  |          x          |
  |        o   o        |
  W      x   c   x      E
  |        o   o        |
  |          x          |
  |                     |
  Sw --------S--------- SE


Parameters:
     
    cx = 0; cy = 0; cz=0;

    radius -- radius of inner circle

    N     --  Longitudal
    Nang  --  Angular
    Nrad  --  Radial

Returns:

*/



// ========================================================================= //
// Define Topology
// ========================================================================= //

Function SquareShellCircleCore

  /* Define Geometry ------------------------------------------------------- */

  P1x = cx;  P1y = cy;  P1z = cz;          // Coordinates for "North East" node
  P2x = cx;  P2y = cy;  P2z = cz;          // Coordinates for "North West" node
  P3x = cx;  P3y = cy;  P3z = cz;          // Coordinates for "South West" node
  P4x = cx;  P4y = cy;  P4z = cz;          // Coordinates for "South East" node
  
  O1x = cx;  O1y = cy;  O1z = cz;          // Coordinates for "North East" node
  O2x = cx;  O2y = cy;  O2z = cz;          // Coordinates for "North West" node
  O3x = cx;  O3y = cy;  O3z = cz;          // Coordinates for "South West" node
  O4x = cx;  O4y = cy;  O4z = cz;          // Coordinates for "South East" node

  If(Flag_Plane==0)                          // XY Plane (extrude along Z-axis)
    O1x += radius*Cos(  Pi/4); O1y += radius*Sin(  Pi/4);
    O2x += radius*Cos(3*Pi/4); O2y += radius*Sin(3*Pi/4);
    O3x += radius*Cos(5*Pi/4); O3y += radius*Sin(5*Pi/4);
    O4x += radius*Cos(7*Pi/4); O4y += radius*Sin(7*Pi/4);

    P1x += len; P1y += len;
    P2x -= len; P2y += len;
    P3x -= len; P3y -= len;
    P4x += len; P4y -= len;

    ex = 0; ey = 0; ez = 1;
  
  ElseIf (Flag_Plane==1)                     // XZ Plane (extrude along Y-axis)
    O1x += radius*Cos(  Pi/4); O1z += radius*Sin(  Pi/4);
    O2x += radius*Cos(3*Pi/4); O2z += radius*Sin(3*Pi/4);
    O3x += radius*Cos(5*Pi/4); O3z += radius*Sin(5*Pi/4);
    O4x += radius*Cos(7*Pi/4); O4z += radius*Sin(7*Pi/4);

    P1x += len; P1z += len;
    P2x -= len; P2z += len;
    P3x -= len; P3z -= len;
    P4x += len; P4z -= len;

    ex = 0; ey = 1; ez = 0;
  
  ElseIf (Flag_Plane==2)                     // YZ Plane (extrude along X-axis)
    O1y += radius*Cos(  Pi/4); O1z += radius*Sin(  Pi/4);
    O2y += radius*Cos(3*Pi/4); O2z += radius*Sin(3*Pi/4);
    O3y += radius*Cos(5*Pi/4); O3z += radius*Sin(5*Pi/4);
    O4y += radius*Cos(7*Pi/4); O4z += radius*Sin(7*Pi/4);

    P1y += len; P1z += len;
    P2y -= len; P2z += len;
    P3y -= len; P3z -= len;
    P4y += len; P4z -= len;

    ex = 1; ey = 0; ez = 0;

  EndIf

  p1 = newp; Point(p1) = {P1x, P1y, P1z, lc};
  p2 = newp; Point(p2) = {P2x, P2y, P2z, lc};
  p3 = newp; Point(p3) = {P3x, P3y, P3z, lc};
  p4 = newp; Point(p4) = {P4x, P4y, P4z, lc};
  
  o1 = newp; Point(o1) = {O1x, O1y, O1z, lc};
  o2 = newp; Point(o2) = {O2x, O2y, O2z, lc};
  o3 = newp; Point(o3) = {O3x, O3y, O3z, lc};
  o4 = newp; Point(o4) = {O4x, O4y, O4z, lc};
  
  
  // North
  a1 = newl; Line(a1)   = {p1, p2};                // North East --> North West
  r1 = newl; Line(r1)   = {o2, p2};
  a2 = newl; Circle(a2) = {o2,center, o1};
  r2 = newl; Line(r2)   = {o1, p1};
  
  // West
  a3 = newl; Line(a3)   = {p2, p3};                // North West --> South West
  r3 = newl; Line(r3)   = {o3, p3};
  a4 = newl; Circle(a4) = {o3, center, o2};
  
  // South
  a5 = newl; Line(a5)   = {p3, p4};                // South West --> South East
  r4 = newl; Line(r4)   = {o4, p4};
  a6 = newl; Circle(a6) = {o4, center, o3};
  
  // East
  a7 = newl; Line(a7)   = {p4, p1};                // South East --> North East
  a8 = newl; Circle(a8) = {o1, center, o4};
  
  /* Define Topology ------------------------------------------------------- */  
  ll1 = newll; Line Loop(ll1) = {a1, -r1, a2, r2};
  ll2 = newll; Line Loop(ll2) = {a3, -r3, a4, r1};
  ll3 = newll; Line Loop(ll3) = {a5, -r4, a6, r3};
  ll4 = newll; Line Loop(ll4) = {a7, -r2, a8, r4};
  
  s1 = news; Surface(s1) = { ll1 };
  s2 = news; Surface(s2) = { ll2 };
  s3 = news; Surface(s3) = { ll3 };
  s4 = news; Surface(s4) = { ll4 };
  
  surfaces = {s1, s2, s3, s4};
  
  /* Mesh Generation ------------------------------------------------------- */
  Transfinite Line{r1, r2, r3, r4} = Nrad + 1 Using Progression 0.9;
  Transfinite Line{a1, a2, a3, a4, a5, a6, a7, a8} = Nang + 1 Using Bump 1;

Return



Function SquareShell

   O2x = cx;  O2y = cy;  O2z = cz;               // Coordinates for "East" node
   O3x = cx;  O3y = cy;  O3z = cz;              // Coordinates for "North" node
   O4x = cx;  O4y = cy;  O4z = cz;               // Coordinates for "West" node
   O5x = cx;  O5y = cy;  O5z = cz;              // Coordinates for "South" node

  /* Declare Options --------------------------------------------------------- */

  If(Flag_Plane==0)                          // XY Plane (extrude along Z-axis)
    O2x += radius;  O3y += radius;
    O4x -= radius;  O5y -= radius;

  ElseIf (Flag_Plane==1)                     // XZ Plane (extrude along Y-axis)
     O2x +=  radius + dr ;  O3z +=  radius + dr;
     O4x -= (radius + dr);  O5z -= (radius + dr);

  ElseIf (Flag_Plane==2)                     // YZ Plane (extrude along X-axis)
     O2y +=  radius + dr ;  O3z +=  radius + dr;
     O4y -= (radius + dr);  O5z -= (radius + dr);

  EndIf


  /* Declare Points ---------------------------------------------------------- */
  N  = newp; Point(N)  = { 0,  2, 0};
  Ne = newp; Point(Ne) = { 2,  2, 0};
  E  = newp; Point(E)  = { 2,  0, 0};
  Se = newp; Point(Se) = { 2, -2, 0};
  S  = newp; Point(S)  = { 0, -2, 0};
  Sw = newp; Point(Sw) = {-2, -2, 0};
  W  = newp; Point(W)  = {-2,  0, 0};
  Nw = newp; Point(Nw) = {-2,  2, 0};


  center = newp; Point(center)  = { cx,  cy,  cz}; // Center point


  // Outer Shell
  c2 = newp;  Point(c2) = {O3x, O3y, O3z, lc};                       // "North"
  c3 = newp;  Point(c3) = {O2x, O2y, O2z, lc};                        // "East"
  c4 = newp;  Point(c4) = {O4x, O4y, O4z, lc};                        // "West"
  c5 = newp;  Point(c5) = {O5x, O5y, O5z, lc};                       // "South"

  /* Declare Lines --------------------------------------------------------- */

  // Outer circle
  lo1 = newl; Circle(lo1) = {c2, center, c3};                 // North --> East
  lo2 = newl; Circle(lo2) = {c3, center, c5};                 // East --> South
  lo3 = newl; Circle(lo3) = {c5, center, c4};                 // South --> West
  lo4 = newl; Circle(lo4) = {c4, center, c2};                 // West --> North

  // Connecting inner and outer circle
  l1 = newl; Line(l1) = {c2, N};                     // North (outer) --> North
  l2 = newl; Line(l2) = {c3, E};                      // East  (outer) --> East
  l3 = newl; Line(l3) = {c4, W};                      // West  (outer) --> West
  l4 = newl; Line(l4) = {c5, S};                     // South (outer) --> South

  l5 = newl; Line(l5) = {N, Ne};                        // North --> North East
  l6 = newl; Line(l6) = {Ne, E};                         // North East --> East
  l7 = newl; Line(l7) = {E, Se};                         // East --> South East
  l8 = newl; Line(l8) = {Se, S};                        // South East --> South
  l9 = newl; Line(l9) = {S, Sw};                        // South --> South West
  l10 = newl; Line(l10) = {Sw, W};                       // South West --> West
  l11 = newl; Line(l11) = {W, Nw};                       // West --> North West
  l12 = newl; Line(l12) = {Nw, N};                      // North West --> North

  l13 = newl; Line(l13) = {N, E}; // Diagonal, North --> East
  l14 = newl; Line(l14) = {E, S};
  l15 = newl; Line(l15) = {S, W};
  l16 = newl; Line(l16) = {W, N};


  /* Define Topology ------------------------------------------------------- */

  // Declare Line Loops
  f2 = newll; Line Loop(f2) = { l1,  l5, l6,  -l2, -lo1};// North East Quadrant
  f3 = newll; Line Loop(f3) = { l2,  l7, l8,  -l4, -lo2};// South East Quadrant
  f4 = newll; Line Loop(f4) = { l4,  l9, l10, -l3, -lo3};// South West Quadrant
  f5 = newll; Line Loop(f5) = { l3, l11, l12, -l1, -lo4};// North West Quadrant
  // Declare Surfaces
  s2 = news; Plane Surface(s2) = {f2};                            // North West
  s3 = news; Plane Surface(s3) = {f3};                            // South West
  s4 = news; Plane Surface(s4) = {f4};                            // South East
  s5 = news; Plane Surface(s5) = {f5};                            // North East

  surfaces = {s2, s3, s4, s5};

  // Mesh Generation ------------------------------------------------------- //
  Transfinite Line{lo1, lo2, lo3, lo4} = Nang + 1; // Circles
  Transfinite Line{l5:l12} = Nrad + 1;

Return


// ========================================================================= //
// Define Extrusions
// ========================================================================= //

Function LinearExtrusionSquareShell

  Printf("Performing Linear Extrusion In-Plane");
  newVol    = {};
  innerwalls = {};
  outerwalls = {};

  If( Flag_Plane == 0 ) // XY Plane
    Printf("  Z-direction");
    lx = 0; ly = 0; lz = len;
  
  ElseIf ( Flag_Plane == 1 ) // XZ Plane
    Printf("  Y-direction");
    lx = 0; ly = len; lz = 0;
  
  ElseIf ( Flag_Plane == 2 ) // YZ Plane
    Printf("  X-direction");
    lx = len; ly = 0; lz = 0;
  EndIf
  
  /* ----------------------------------------------------------------------- */
  For i In {0:3} // The Shell has four surfaces  
    out[] = Extrude {lx, ly, lz} {//  Outer: 3, Inner: 5, Sides: 2 and 4
      Surface{surfaces[i]};
      Layers{N + 1};
      Recombine;
    };
    surfaces[i] = out[0];
    newVol     += out[1];
    innerwalls += out[2];
    outerwalls += out[3];
    innerwalls += out[4];
    innerwalls += out[5];
  EndFor
  
Return


// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
