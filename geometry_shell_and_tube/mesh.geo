/*
  @brief   Circle
  @author  Sigve Karolius
*/
// SetFactory("OpenCASCADE");


/* Define Geometry Parameters ---------------------------------------------- */
R = 0.5;                                                  // Radius of the tube
DR = 0.5*R;                                                     // Shell radius
lc = 0.1;                                                        // Size factor
N0 =  3;                                     // Nominal longditudal mesh layers
Na0 = 5;                                         // Nominal angular mesh layers
Nr0 = 7;                                          // Nominal radial mesh layers
L = 1.0;                                                    // Extrusion length
cx0 = 0; cy0 = 0; cz0 = 0;                              // Centre of the circle

// Display options in General User Interface (GUI)
DefineConstant [
  Flag_Plane = {1, Choices{0="XY", 1="XZ", 2="YZ"},
                Name "Input/00Plane", Highlight "Blue"}
  Flag_Unit  = {2, Choices{0="mm", 1="cm", 2="m", 3="km"},
                        Name "Input/01Unit", Highlight "Blue"}
];

If ( Flag_Unit == 0 )
  Printf("Scaling to unit millimeter [mm]");
  unit = 0.001;
ElseIf ( Flag_Unit == 1 )
  Printf("Scaling to unit centimeter [cm]");
  unit = 0.01;
ElseIf ( Flag_Unit == 2 )
  Printf("Scaling to unit meter [m]");
  unit = 1;
ElseIf ( Flag_Unit == 3 )
  Printf("Scaling to unit kilometer [km]");
  unit = 1000;
EndIf

DefineConstant [
  radius = {     R*unit, Name "Input/Characteristic Sizes/Radius"}
  thickness  = {DR*unit, Name "Input/Characteristic Sizes/Shell Thickness"}
  len    = {     L*unit, Name "Input/Characteristic Sizes/Length"}
  cx     = {   cx0*unit, Name "Input/Centre/x-coordinate"}
  cy     = {   cy0*unit, Name "Input/Centre/y-coordinate"}
  cz     = {   cz0*unit, Name "Input/Centre/z-coordinate"}
  N      = {      N0, Name "Input/Mesh/Layers"}
  Nang   = {     Na0, Name "Input/Mesh/Angular"}
  Nrad   = {     Nr0, Name "Input/Mesh/Radial"}
];

// Define variables used to group patches and volumes
inlets_tube   = {};
inlets_shell  = {};
inlets_square = {};

outlets_tube  = {};
outlets_shell = {};
outlets_square = {};

walls_tube  = {};
walls_shell = {};
walls_square = {};

volumes_tube  = {};
volumes_shell = {};
volumes_square = {};

Include "../geo_templates/circle_topology_OH.geo";
Include "../geo_templates/circle_circular_shell.geo";
Include "../geo_templates/circle_square_shell.geo";
// !!! ---------------- do not edit below this line -------------------- !!! //

// ----------- Create Inner Tube
Call OHCircle;
inlets_tube += surfaces[];

Call LinearExtrusionOHCircle;
volumes_tube += newVol[];
walls_tube   += outerwalls[];
outlets_tube += surfaces[];

// ---------- Create Outer (circluar) Shell
Nrad = Ceil(Nrad*0.7);
Call CircleShellCircleCore;
inlets_shell += surfaces[];

Call LinearExtrusionCircleShell;
volumes_shell += newVol[];
walls_shell   += outerwalls[];
outlets_shell += surfaces[];

// ---------- Create Outer (square) Shell
// Nrad = Ceil(Nrad*0.7);
// radius = radius + thickness;
// Call SquareShellCircleCore;
// inlets_square += surfaces[];
// 
// Call LinearExtrusionCircleShell;
// volumes_shell += newVol[];
// walls_shell   += outerwalls[];
// outlets_shell += surfaces[];


/* Define Groups of Geometric Entities -------------------------------------- */

// Colour patches for better visibility in the General User Interface (GUI)
Color Cyan{ Surface{ inlets_tube[] }; }
Color Blue{ Surface{ inlets_shell[] }; }

Color Yellow{ Surface{ walls_tube[] }; }
Color Gray{ Surface{ walls_shell[] }; }

Color Magenta{ Surface{ outlets_tube[] }; }
Color Red{ Surface{ outlets_shell[] }; }


Color Gray50{ Volume{ volumes_shell[] }; }
Color Green{ Volume{ volumes_tube[] }; }


// Provide names of the physical entities
Physical Surface("inlet")   = inlets_tube[];
Physical Surface("outlet")  = outlets_tube[];
Physical Surface("liquid_to_solid")  = walls_tube[];
Physical Surface("walls") = walls_shell[];

Physical Volume("liquid")   = volumes_tube[];
Physical Volume("solid")    = volumes_shell[];


Transfinite Surface "*";
Recombine Surface "*";

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
//+
