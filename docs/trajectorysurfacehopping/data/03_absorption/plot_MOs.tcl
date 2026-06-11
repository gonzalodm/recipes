# $Id: au-iso.vmd,v 1.2 2004/05/21 15:50:29 akohlmey Exp $
# Display settings
display projection Orthographic
display nearclip set 0.000000
display farclip set 10.000000
display depthcue off
display rendermode GLSL
color Display Background white
axes location off
light 0 on
light 1 on
light 2 on
light 3 on

# Change colors
color change rgb red 0.301 0.701 0.800
color change rgb gray 1.000 0.577 0.000
color add item Name C black
color Name C black

# store the molecule id for later use
set updmol [mol new {wp-1-1-6-real.cube} type cube waitfor all]
mol addfile {wp-1-1-7-real.cube} type cube waitfor all
mol addfile {wp-1-1-5-real.cube} type cube waitfor all
mol addfile {wp-1-1-7-real.cube} type cube waitfor all

# Representation 0: The molecule
mol delrep 0 top
mol material Glossy
mol representation CPK 1.0 0.5 300 300
mol color Name
mol selection {all}
mol addrep top

# Representation 1: Positive isosurface
mol material EdgyGlass
mol color ColorID 1
mol representation Isosurface 0.010 0.0 0.0 0.0 1 1
mol selection {all}
mol addrep top

# Representation 2: Negative isosurface
mol material EdgyGlass
mol color ColorId 2
mol representation Isosurface -0.010 0.0 0.0 0.0 1 1
mol selection {all}
mol addrep top

set updrep1 [mol repname top 1]
set updrep2 [mol repname top 2]
mol rename top {test}

# the isosurface representation
proc update_iso {args} {
  global updmol
  global updrep1
  global updrep2

  # get representation id and return if invalid
  set repid1 [mol repindex $updmol $updrep1]
  if {$repid1 < 0} {return}
  set repid2 [mol repindex $updmol $updrep2]
  if {$repid2 < 0} {return}

  set frame [molinfo $updmol get frame]
  lassign [molinfo $updmol get "{rep $repid1}"] rep
  mol color colorid 1
  mol representation [lreplace $rep 2 2 $frame]
  mol modrep $repid1 $updmol

  lassign [molinfo $updmol get "{rep $repid2}"] rep
  mol color colorid 2
  mol representation [lreplace $rep 2 2 $frame]
  mol modrep $repid2 $updmol
}
trace variable vmd_frame($updmol) w update_iso
animate goto 0
