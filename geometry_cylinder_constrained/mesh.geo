/*
  @brief   Circle
  @author  Sigve Karolius
*/
//SetFactory("OpenCASCADE");

Geometry.CopyMeshingMethod = 1;  // Enable MESH method copying upon translation

/* Define Geometry Parameters ---------------------------------------------- */
R = 0.5;        // Radius of the tube
DR = 0.5*R;     // Shell radius

lc = 0.1;
N0  = 3; // Number of meshed layers in "extruced" geometry
N0a = 5; // Number of 
N0r = 7;
L = 1.0;

// Centre of circle
cx0 = 0; cy0 = 0; cz0 = 0;


DefineConstant [
  Flag_Plane = {2, Choices{0="XY", 1="XZ", 2="YZ"},
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
  radius = {     R*unit, Name "Input/Characteristic Sizes/Radius (m)"}
  thickness  = { DR*unit, Name "Input/Characteristic Sizes/Shell Thickness (m)"}
  len    = {   L*unit, Name "Input/Characteristic Sizes/Length (m)"}
  cx     = {   cx0*unit, Name "Input/Centre/x-coordinate (m)"}
  cy     = {   cy0*unit, Name "Input/Centre/y-coordinate (m)"}
  cz     = {   cz0*unit, Name "Input/Centre/z-coordinate (m)"}
  N      = {      N0, Name "Input/Mesh/Layers"}
  Nang   = {     N0a, Name "Input/Mesh/Ancular"}
  Nrad   = {     N0r, Name "Input/Mesh/Radial"}
];


inlets  = {}; // Bottom of the cylinder
outlets = {}; // Top of the cylinder
volumes = {};
walls   = {};
walls   = {};

Include "../geo_templates/circle_topology_OH.geo";
Include "../geo_templates/circle_circular_shell.geo";
// !!! ---------------- do not edit below this line -------------------- !!! //

// ----------- Create Inner Tube

Call OHCircle;
inlets += surfaces[];
 
Call LinearExtrusionOHCircle;
volumes += newVol[];
 
Call LinearExtrusionOHCircle; // Middle "pipe"
volumes += newVol[];
walls   += outerwalls[];
 
Call LinearExtrusionOHCircle;
volumes += newVol[];
outlets += surfaces[];

// ---------- Create Outer Shell

cx = cz0; cy = cy0; cz = cx0;
Call CircleShellCircleCore;
inlets += surfaces[];

Call LinearExtrusionCircleShell;
volumes += newVol[];
walls   += outerwalls[];
walls   += surfaces[];

// cx = 0; cy = 0; cz = lz; // for XY plane (extrusion in Z-direction)
cz = 0; cy = 0; cx = lx; // for YZ plane (extrusion in X-dicection)
//cz = 0; cx = 0; cy = ly; // XZ

surfaces[] = Translate { cx, cy, cz } {
  Duplicata { Surface { surfaces[] }; }
};
walls += surfaces[];

Call LinearExtrusionCircleShell;
volumes += newVol[];
walls   += outerwalls[];
outlets += surfaces[];

/* Define Groups of Geometric Entities -------------------------------------- */

Color Magenta{ Surface{ inlets[] }; }
Color Gray{ Surface{ walls[] }; }
Color Cyan{ Surface{ outlets[] }; }

Color Yellow{ Volume{ volumes[] }; }

Physical Surface("bottom") = inlets[];
Physical Surface("atmosphere")    = outlets[];
Physical Volume("volume")  = volumes[];
Physical Surface("walls")  = walls[];

Transfinite Surface "*";
Recombine Surface "*";

// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
