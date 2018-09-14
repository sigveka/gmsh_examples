/**

*/

Function Square

  NEx = llx; NEy = lly; NEz = llz;           // Coordinates for North East node
  SEx = llx; SEy = lly; SEz = llz;           // Coordinates for South East node
  SWx = llx; SWy = lly; SWz = llz;           // Coordinates for South West node
  NWx = llx; NWy = lly; NWz = llz;           // Coordinates for North West node



  If( Flag_Plane == 0 ) // XY Plane -- Z direction
    NEx += Len; NEy += Width;
    SEx += Len;
                NWy += Width;

    lx = 0; ly = 0; lz = len;
  
  ElseIf( Flag_Plane == 1 ) // XZ Plane -- Y direction

    NEx += Len; NEz += Width;
    SEx += Len;
                NWz += Width;

    lx = 0; ly = len; lz = 0;

  ElseIf ( Flag_Plane == 2 ) // YZ Plane => X direction
    NEy += Len; NEz += Width;
    SEy += Len;
                NWz += Width;

    lx = len; ly = 0; lz = 0;

  Else
    Abort; // or Error or Exit ==> Abort current script or Exit GMSH
  EndIf

  // !!! ---------------- Do not edit below this line ------------------ !!! //

  /* Declare Points -------------------------------------------------------- */
  NE = newp; Point(NE) = {NEx, NEy, NEz, gridsize};               // North East
  SE = newp; Point(SE) = {SEx, SEy, SEz, gridsize};               // South East
  SW = newp; Point(SW) = {SWx, SWy, SWz, gridsize};               // South West
  NW = newp; Point(NW) = {NWx, NWy, NWz, gridsize};               // North West

  /* Declare Lines --------------------------------------------------------- */
  E = newl; Line(E) = {NE, SE};                    // North East --> South East
  S = newl; Line(S) = {SE, SW};                    // South East --> South West
  W = newl; Line(W) = {SW, NW};                    // South West --> North West
  N = newl; Line(N) = {NW, NE};                    // North West --> North East

  /* Define Topology ------------------------------------------------------- */
  l1 = newll; Line Loop(l1) = {E, S, W, N};// East --> South --> West --> North
  surfaces = news;  Plane Surface(surfaces) = l1;

  /* Mesh Generation ------------------------------------------------------- */
  Transfinite Line{E, W} = Nwidth;
  Transfinite Line{S, N} = Nwidth;
  Transfinite Surface{surfaces};
  Recombine Surface{surfaces};

Return


Function SquareLinearExtrusion

  If( Flag_Plane == 0 ) // XY Plane -- Z direction
    ex = 0; ey = 0; ez = 1;
  ElseIf( Flag_Plane == 1 ) // XZ Plane -- Y direction
    ex = 0; ey = 1; ez = 0;
  ElseIf ( Flag_Plane == 2 ) // YZ Plane => X direction
    ex = 1; ey = 0; ez = 0;
  Else
    Abort; // or Error or Exit ==> Abort current script or Exit GMSH
  EndIf

  out[] = Extrude { ex*len, ey*len, ez*len } {// Perform Linear Extrusion
  	Surface{surfaces};
  	Layers{N};
  	Recombine;
  };

  // Printf("Base Surface     = %g", surfaces);
  // Printf("Top Surface      = %g", out[0]);
  // Printf("Volume           = %g", out[1]);
  // Printf("Lateral Surfaces = %g, %g, %g and %g",out[2],out[3], out[4], out[5]);

  // Top and Bottom
  base   = {surfaces};
  top    = {out[0]};

  // Walls (Lateral Surfaces)
  left  = {out[2]};
  back  = {out[3]};
  right = {out[4]};
  front = {out[5]};

  // Extruded Volumes
  newVol = {out[1]};

Return

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
