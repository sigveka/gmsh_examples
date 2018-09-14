/**
 *
 */


Function Valve

  P1x = cx; P1y = cy; P1z = cz;             // Coordinates for "Top Left" point
  P2x = cx; P2y = cy; P2z = cz;            // Coordinates for "Top Right" point
  P3x = cx; P3y = cy; P3z = cz;         // Coordinates for "Bottom Right" point
  P4x = cx; P4y = cy; P4z = cz;          // Coordinates for "Bottom Left" point

  Ri =(1-position)*radius/2; // compute internal radius based on valve position


  If(Flag_Plane == 0)                       // XY Plane (extrude around Z-axis)
    x0 = cz + len/2.0;                // Location of "pinch" point of the valve
    P1x += radius;
    P2x += radius;               P2z += len;
    P3x += Ri;                   P3z += len;
    P4x += Ri;
    ex = 0; ey = 0; ez = 1;

  ElseIf(Flag_Plane == 1)                   // XZ Plane (extrude around Y-axis)
    x0 = cy + len/2.0;                // Location of "pinch" point of the valve
                                   P1z += radius;
                  P2y += len;      P2z += radius;
                  P3y += len;      P3z += Ri;
                                   P4z += Ri;
    ex = 0; ey = 1; ez = 0;

  ElseIf(Flag_Plane == 2)                   // YZ Plane (extrude around X-axis)
    x0 = cx + len/2.0;                // Location of "pinch" point of the valve
                    P1y += radius;
    P2x += len;     P2y += radius;
    P3x += len;     P3y += Ri;
                    P4y += Ri;
    ex = 1; ey = 0; ez = 0;
   
  EndIf

  center = newp; Point(center) = {cx, cy, cz, ls};

  p0 = newp; Point(p0) = {P1x, P1y, P1z, ls};                     // upper left
  p1 = newp; Point(p1) = {P2x, P2y, P2z, ls};                      // top right
  p2 = newp; Point(p2) = {P3x, P3y, P3z, ls};                    // lower right
  p3 = newp; Point(p3) = {P4x, P4y, P4z, ls};                     // lower left



  pList = {};
  pList += p0;                    // First point label (top-left of the region)
  nPoints = 21;                               // Number of interpolation points
  For i In {1 : nPoints}

    If(Flag_Plane == 0)                           // XY (extrude around Z-axis)
      z = cz + len*i/(nPoints + 1);
      x = cx + (radius * (1 - position/2 *(1 + Cos(2.0*Pi*(z - x0)/len) ) ));
      y = cy;

    ElseIf(Flag_Plane == 1)                       // XZ (extrude around Y-axis)
      y = cy + len*i/(nPoints + 1);
      z = cz + (radius * (1 - position/2 *(1 + Cos(2.0*Pi*(y - x0)/len) ) ));
      x = cx;

    ElseIf(Flag_Plane == 2)
      x = cx + len*i/(nPoints + 1);
      y = cy + (radius * (1 - position/2 *(1 + Cos(2.0*Pi*(x - x0)/len) ) ));
      z = cz;

    EndIf

    pList += newp; Point(pList[i]) = {x, y, z, ls};

  EndFor
  pList += p1;       // Last point label (top-right point of the outlet region)

  /* Define Topology ------------------------------------------------------- */

  l0 = newl; Line(l0) = {p1, p2};                  // top right --> lower right
  l1 = newl; Line(l1) = {p2, p3};                 // lower right --> lower left
  l2 = newl; Line(l2) = {p3, p0};                    // lower left --> top left
  l3 = newl; Spline(l3) = pList[];

  ll0 = newll; Line Loop(ll0) = {l0, l1, l2, l3};

  /* Define Mesh ----------------------------------------------------------- */

  Transfinite Line{l0, l2} = Nrad + 1;
  Transfinite Line{l1, l3} = N + 1;

  s0 = news; Plane Surface(s0) = {ll0};
  Transfinite Surface{s0};
  Recombine Surface{s0};

  intrafaces  = { s0 };
  inletfaces  = {};
  outletfaces = {};
  innerfaces  = {};
  outerfaces  = {};
  newVolumes  = {};

  For i In {0:3} 

    out[] = Extrude { {ex, ey, ez}, { cx, cy, cz}, Pi/2} {
      Surface{intrafaces[]};
      Layers{Nang};
      Recombine;
    };

    intrafaces   = { out[0] };
    newVolumes  += out[1];
    outletfaces += out[2];
    innerfaces  += out[3];
    inletfaces  += out[4];
    outerfaces  += out[5];

  EndFor
   
 //Coherence; // Ensure Topological Consistency (delete duplicate surfaces)

  Include "circle_topology_OH.geo";
  radius = Ri;
  Nrad   = Ceil(Nrad * 0.5);
  Call OHCircle;
  inletfaces += surfaces[];

  Call LinearExtrusionOHCircle;

  newVolumes += newVol[];
  outletfaces += surfaces[];

  surfaces = outletfaces[];

  //
  Transfinite Surface "*";
  Recombine Surface "*";

Return

Function ExtrudeValveOutlet

  For i In {0:8}
    out[] = Extrude {lx, ly, lz} {
      Surface{outletfaces[i]};
      Layers{N};
      Recombine;
    };
  EndFor


  // If( i == 0 ) // The "inner square" is always surface number Zero
  //   innerwalls += {out[2], out[3], out[4], out[5]};
  // Else
  //   outerwalls += {out[3]};
  //   innerwalls += {out[2], out[4], out[5]};
  // EndIf

Return



Function ExtrudeValveInlet

  If( Flag_Plane == 0)
    ex = 0; ey = 0; ez = 1; // Extrude along Z-axis

  ElseIf( Flag_Plane == 1)  // Extrude along Y-axis
    ex = 0; ey = 1; ez = 0;

  ElseIf( Flag_Plane == 2)  // Extrude aloxing X-axis
    ex = 1; ey = 0; ez = 0;
  EndIf

  For i In {0:8}
    out[] = Extrude {len*ex, len*ey, len*ez} {
      Surface{inletfaces[i]};
      Layers{N};
      Recombine;
    };
  EndFor


  // If( i == 0 ) // The "inner square" is always surface number Zero
  //   innerwalls += {out[2], out[3], out[4], out[5]};
  // Else
  //   outerwalls += {out[3]};
  //   innerwalls += {out[2], out[4], out[5]};
  // EndIf

Return


// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
