/*
  @brief   Circle
  @author  Sigve Karolius
*/


/* Define Geometry Parameters ---------------------------------------------- */
R = 0.2;        // Radius of the tube
DR = R + R*0.35;   // Shell radius

lc = 0.1;
N0 = 13;
L = 10;

// Centre of circle
cx0 = 0;
cy0 = 0;
cz0 = 0;
m   = 1; // scale
dir = 1; // Extrusion direction

DefineConstant [
  radius = {     R*m, Name "Input/Characteristic Sizes/Radius (m)"}
  dr     = {    DR*m, Name "Input/Characteristic Sizes/Shell Thickness (m)"}
  length = { dir*L*m, Name "Input/Characteristic Sizes/Length (m)"}
  cx     = {   cx0*m, Name "Input/Centre/x-coordinate (m)"}
  cy     = {   cy0*m, Name "Input/Centre/y-coordinate (m)"}
  cz     = {   cz0*m, Name "Input/Centre/z-coordinate (m)"}
  N      = {      N0, Name "Input/Mesh/Layers"}
  Flag_Plane = {0, Choices{0="XY", 1="XZ", 2="YZ"},
                Name "Input/00Plane", Highlight "Blue"}
];




// Declare lists
inlets  = {};
volumes = {};
outlets = {};
walls   = {};


x_length = 0;
y_length = 0;
z_length = 0;

/* ------------------------------------------------------------------------- */

Flag_Plane = 1; // X-Z plane
Include "circle/O-H.geo";                // Generate circle surface in XY-Plane
inlets  = surfaces[];                           // Declare surfaces as "inlets"


Include "extrude/linear-in-plane.geo";            // Extrude "l" in Z-direction


length = 1;
start = length;
Flag_Plane_Bend = 0;
Include "extrude/bend-90.geo";                      // Bend 90 degrees

Include "extrude/linear-in-plane.geo";

Flag_Plane_Bend = 1;
Include "extrude/bend-90.geo";                      // Bend 90 degrees



length = 10;
Include "extrude/linear-in-plane.geo";

outlets = surfaces[];

/* Define Groups of Geometric Entities ------------------------------------- */

Physical Surface("inlet")  = inlets[];
Physical Surface("outlet") = outlets[];
Physical Volume("volume")  = volumes[];
Physical Surface("walls")  = walls[];


Transfinite Surface "*";
Recombine Surface "*";



//Include "shell.geo";


// Vim 'modelines', standardise settings for the 'vim' text editor...
// vim: filetype=gmsh fileencoding=ascii syntax=on colorcolumn=79
// vim: ff=unix tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
