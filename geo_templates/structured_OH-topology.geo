// vim: set filetype=gmsh
/*
  @brief   OH-topology (butterfly topology) (2-domains)
  @author  Sigve Karolius
*/

/* Define Geometry Parameters ---------------------------------------------- */
R = 1;
dR = 0.5;
Ri = 0.3;

lc = 0.1;

cx0 = 0; cy0 = 0; cz0 = 0;

R = 1;                                                         // Circle radius
rat = 0.6;                     // Ration of size between inner and outer circle
rot = 0*Pi/4;                                           // Rotate entire geometry
lc = 0.1;
dl = 0.1;                                                // "thickness of disc"

DefineConstant [
  dim = {1, Choices{1000="km", 1="m", 0.1="dm", 0.01="cm", 0.001="mm"},
        Name "Input/01Dimension", Highlight "Green" }
];

Nang = 5;
Nrad = 7;

DefineConstant [
  radius = {    R*dim, Name "Input/Characteristic Sizes/Radius"}
  ratio  = {      rat, Name "Input/Characteristic Sizes/Ratio"}
  cx     = {  cx0*dim, Name "Input/Centre/x-coordinate"}
  cy     = {  cy0*dim, Name "Input/Centre/y-coordinate"}
  cz     = {  cz0*dim, Name "Input/Centre/z-coordinate"}
  Flag_Plane = {0, Choices{0="XY", 1="XZ", 2="YZ"},
                Name "Input/00Plane", Highlight "Blue"}
];

Function CircleOH

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

  center = newp; Point(center) = {cx,  cy, cz, lc};                     // Centre
  
  // Declare points on the circle
  o1 = newp; Point(o1) = {O1x, O1y, O1z, lc};                             // East
  o2 = newp; Point(o2) = {O2x, O2y, O2z, lc};                            // North
  o3 = newp; Point(o3) = {O3x, O3y, O3z, lc};                             // West
  o4 = newp; Point(o4) = {O4x, O4y, O4z, lc};                            // South
  
  s1 = newp; Point(s1) = { S1x, S1y, S1z, lc}; // East
  s2 = newp; Point(s2) = { S2x, S2y, S2z, lc}; // North
  s3 = newp; Point(s3) = { S3x, S3y, S3z, lc}; // West
  s4 = newp; Point(s4) = { S4x, S4y, S4z, lc}; // South
  
  // Declare Points for the inner square
  i1 = newp; Point(i1) = {I1x, I1y, I1z, lc};                             // East
  i2 = newp; Point(i2) = {I2x, I2y, I2z, lc};                            // North 
  i3 = newp; Point(i3) = {I3x, I3y, I3z, lc};                             // West
  i4 = newp; Point(i4) = {I4x, I4y, I4z, lc};                            // South
  
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

Return

/* ------------------------------------------------------------------------- */
// Circle inside square

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

/* ------------------------------------------------------------------------- */
// Square inside circle

Function CircleShellSquareCore

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

  center = newp; Point(center) = {cx, cy, cz, lc};

  p1 = newp; Point(p1) = {P1x, P1y, P1z, lc};
  p2 = newp; Point(p2) = {P2x, P2y, P2z, lc};
  p3 = newp; Point(p3) = {P3x, P3y, P3z, lc};
  p4 = newp; Point(p4) = {P4x, P4y, P4z, lc};
  
  o1 = newp; Point(o1) = {O1x, O1y, O1z, lc};
  o2 = newp; Point(o2) = {O2x, O2y, O2z, lc};
  o3 = newp; Point(o3) = {O3x, O3y, O3z, lc};
  o4 = newp; Point(o4) = {O4x, O4y, O4z, lc};
  
  // North
  a1 = newl; Circle(a1) = {o1, center, o2};
  r1 = newl; Line(r1)   = {p2, o2};
  a2 = newl; Line(a2)   = {p2, p1};
  r2 = newl; Line(r2)   = {p1, o1};
  
  // West
  a3 = newl; Circle(a3) = {o2, center, o3};
  r3 = newl; Line(r3)   = {p3, o3};
  a4 = newl; Line(a4)   = {p3, p2};
  
  // South
  a5 = newl; Circle(a5) = {o3, center, o4};
  r4 = newl; Line(r4)   = {p4, o4};
  a6 = newl; Line(a6)   = {p4, p3};
  
  // East
  a7 = newl; Circle(a7) = {o4, center, o1};
  a8 = newl; Line(a8)   = {p1, p4};
  
  
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

/* ------------------------------------------------------------------------- */

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
    
    I1x += radius*Cos(  Pi/4); I1z += radius*Sin(  Pi/4);
    I2x += radius*Cos(3*Pi/4); I2z += radius*Sin(3*Pi/4);
    I3x += radius*Cos(5*Pi/4); I3z += radius*Sin(5*Pi/4);
    I4x += radius*Cos(7*Pi/4); I4z += radius*Sin(7*Pi/4);

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
  
  
  ll1 = newll; Line Loop(ll1) = {a1, -r1, a2, r2};
  ll2 = newll; Line Loop(ll2) = {a3, -r3, a4, r1};
  ll3 = newll; Line Loop(ll3) = {a5, -r4, a6, r3};
  ll4 = newll; Line Loop(ll4) = {a7, -r2, a8, r4};
  
  s1 = news; Surface(s1) = { ll1 };
  s2 = news; Surface(s2) = { ll2 };
  s3 = news; Surface(s3) = { ll3 };
  s4 = news; Surface(s4) = { ll4 };
  
  surfaces = {s1, s2, s3, s4};
  
  Transfinite Line{r1, r2, r3, r4} = Nrad + 1 Using Progression 0.9;
  Transfinite Line{a1, a2, a3, a4, a5, a6, a7, a8} = Nang + 1 Using Bump 1;

Return

Function SquareShellSquareCore

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
    O1x += len; O1y += len;
    O2x -= len; O2y += len;
    O3x -= len; O3y -= len;
    O4x += len; O4y -= len;
    
    I1x += tmp; I1y += tmp;
    I2x -= tmp; I2y += tmp;
    I3x -= tmp; I3y -= tmp;
    I4x += tmp; I4y -= tmp;

    ex = 0; ey = 0; ez = 1;
  
  ElseIf (Flag_Plane==1)                     // XZ Plane (extrude along Y-axis)
    O1x += len; O1z += len;
    O2x -= len; O2z += len;
    O3x -= len; O3z -= len;
    O4x += len; O4z -= len;
    
    I1x += tmp; I1z += tmp;
    I2x -= tmp; I2z += tmp;
    I3x -= tmp; I3z -= tmp;
    I4x += tmp; I4z -= tmp;

    ex = 0; ey = 1; ez = 0;
  
  ElseIf (Flag_Plane==2)                     // YZ Plane (extrude along X-axis)
    O1y += len; O1z += len;
    O2y -= len; O2z += len;
    O3y -= len; O3z -= len;
    O4y += len; O4z -= len;
    
    I1y += tmp; I1z += tmp;
    I2y -= tmp; I2z += tmp;
    I3y -= tmp; I3z -= tmp;
    I4y += tmp; I4z -= tmp;


    ex = 1; ey = 0; ez = 0;

  EndIf

  o1 = newp; Point(o1) = {O1x, O1y, O1z, lc};
  o2 = newp; Point(o2) = {O2x, O2y, O2z, lc};
  o3 = newp; Point(o3) = {O3x, O3y, O3z, lc};
  o4 = newp; Point(o4) = {O4x, O4y, O4z, lc};
  
  i1 = newp; Point(i1) = {I1x, I1y, I1z, lc};
  i2 = newp; Point(i2) = {I2x, I2y, I2z, lc};
  i3 = newp; Point(i3) = {I3x, I3y, I3z, lc};
  i4 = newp; Point(i4) = {I4x, I4y, I4z, lc};

  // North
  a1 = newl; Line(a1) = {o1, o2};
  r1 = newl; Line(r1) = {i2, o2};
  a2 = newl; Line(a2) = {i2, i1};
  r2 = newl; Line(r2) = {i1, o1};
  
  // West
  a3 = newl; Line(a3) = {o2, o3};
  r3 = newl; Line(r3) = {i3, o3};
  a4 = newl; Line(a4) = {i3, i2};
  
  // South
  a5 = newl; Line(a5) = {o3, o4};
  r4 = newl; Line(r4) = {i4, o4};
  a6 = newl; Line(a6) = {i4, i3};
  
  // East
  a7 = newl; Line(a7) = {o4, o1};
  a8 = newl; Line(a8) = {i1, i4};
  
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
  
  /* Define Mesh ----------------------------------------------------------- */
  Transfinite Line{r1, r2, r3, r4} = Nrad + 1 Using Progression 0.9;
  Transfinite Line{a1, a2, a3, a4, a5, a6, a7, a8} = Nang + 1 Using Bump 1;

Return

/* ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: */

// We then set some general options:

General.Trackball = 0;
General.RotationX = 0; General.RotationY = 0; General.RotationZ = 0;
General.Color.Background = White; General.Color.Foreground = Black;
General.Color.Text = Black;
General.Orthographic = 0;
General.Axes = 0; General.SmallAxes = 0;


radius = 1;
//Call CircleOH;
//
//Color Red{ Surface{ surfaces[] }; }
//
//len = 2;
//Call SquareShellCircleCore;
//
//radius = 4;
//Call CircleShellSquareCore;

thickness = 1;
Call CircleShellCircleCore;

//len = 6;
//radius = 5;
//Call SquareShellCircleCore;

// tmp = 6;
// len = 10;
// Call SquareShellSquareCore;


//newVol = {};
//a  = {};
//b  = {};
//c  = {};
//d  = {};
//
//Color Red{ Surface{ surfaces[] }; }
//
//  For i In {0:3} // The Shell has four surfaces  
//    out[] = Extrude {ex, ey, ez} {//  Outer: 3, Inner: 5, Sides: 2 and 4
//      Surface{surfaces[i]};
//      Layers{10};
//      Recombine;
//    };
//    surfaces[i] = out[0];
//    newVol     += out[1];
//    a += out[2];
//    b += out[3]; // "internal walls"
//    c += out[4];
//    d += out[5]; // "internal walls"
//  EndFor
//
//Color Grey50{ Surface{ a[] }; }
//Color Purple{ Surface{ c[] }; }
//Color Red{ Surface{ surfaces[] }; }
//
//
//Physical Surface("outer_wall") = {a[]};
//Physical Surface("inner_wall") = {c[]};
//
//
Transfinite Surface "*";
Recombine Surface "*";
//
Mesh 3;

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
