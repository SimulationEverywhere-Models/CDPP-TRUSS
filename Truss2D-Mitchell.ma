#include(Truss2D.macro)

[top]
components : truss

[truss]
type : cell
% Dim1 = vertical position
% Dim2 = horizontal position
% Dim3 = {v, u, fy, fx}
dim : (2,3,4)
delay : transport
defaultDelayTime : 1
border : nowrapped
% Moores Neighborhood
neighbors : truss(-1,-1,-1) truss(-1,0,-1) truss(-1,1,-1)
neighbors : truss(0,-1,-1)  truss(0,0,-1)  truss(0,1,-1)
neighbors : truss(1,-1,-1)  truss(1,0,-1)  truss(1,1,-1)
neighbors : truss(-1,-1,0)  truss(-1,0,0)  truss(-1,1,0)
neighbors : truss(0,-1,0)   truss(0,0,0)   truss(0,1,0)
neighbors : truss(1,-1,0)   truss(1,0,0)   truss(1,1,0)
neighbors : truss(-1,-1,1)  truss(-1,0,1)  truss(-1,1,1)
neighbors : truss(0,-1,1)   truss(0,0,1)   truss(0,1,1)
neighbors : truss(1,-1,1)   truss(1,0,1)   truss(1,1,1)
neighbors : truss(0,0,2)   % To get the external forces
neighbors : truss(0,0,3)   % To get the external forces
initialValue : 0
initialCellsValue : Truss2D-Mitchell.val
zone : externalForces { (0,0,2)..(1,2,3) }
zone : constraint1 { (1,0,0)..(1,0,1) } 
zone : constraint2 { (1,2,0)..(1,2,1) }
localtransition : displacement-rule

[displacement-rule]
% Vertical displacements v
rule : { ( (#Macro(A11) * #Macro(vb2)) - (#Macro(A12) * #Macro(vb1)) ) / 
         ( (#Macro(A11) * #Macro(A22)) - (#Macro(A12) * #Macro(A12)) ) } 1 { cellpos(2)=0 }

% Horizontal displacements u
rule : { ( (#Macro(A22) * #Macro(ub1)) - (#Macro(A12) * #Macro(ub2)) ) / 
         ( (#Macro(A11) * #Macro(A22)) - (#Macro(A12) * #Macro(A12)) ) } 1 { cellpos(2)=1 }

% Catch-all
rule : { (0,0,0) } 1 { t }

[externalForces]
% No change in external forces
rule : { (0,0,0) } 1 { t }

[constraint1]
% No displacements at constraint
rule : 0 1 { t }

[constraint2]
% No displacements at constraint
rule : 0 1 { t }
