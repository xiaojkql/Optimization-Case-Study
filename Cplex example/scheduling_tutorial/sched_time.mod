// --------------------------------------------------------------------------
// Licensed Materials - Property of IBM
//
// 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55
// Copyright IBM Corporation 1998, 2013. All Rights Reserved.
//
// Note to U.S. Government Users Restricted Rights:
// Use, duplication or disclosure restricted by GSA ADP Schedule
// Contract with IBM Corp.
// --------------------------------------------------------------------------

using CP;

//Declare the interval variables
dvar interval masonry size 35;
dvar interval carpentry size 15;
dvar interval plumbing size 40;
dvar interval ceiling size 15;
dvar interval roofing size 5;
dvar interval painting size 10;
dvar interval windows size 5;
dvar interval facade size 10;
dvar interval garden size 5;
dvar interval moving size 5;

//Add the objective
minimize 400 * maxl(endOf(moving)-100,0)+
		 200 * maxl(25-startOf(masonry),0)+
		 300 * maxl(75 - startOf(carpentry),0)+
		 100 * maxl(75 - startOf(ceiling),0);
		 
subject to {
//Add the precedence constraints
  endBeforeStart(masonry,   carpentry);
  endBeforeStart(masonry,   plumbing);
  endBeforeStart(masonry,   ceiling);
  endBeforeStart(carpentry, roofing);
  endBeforeStart(ceiling,   painting);
  endBeforeStart(roofing,   windows);
  endBeforeStart(roofing,   facade);
  endBeforeStart(plumbing,  facade);
  endBeforeStart(roofing,   garden);
  endBeforeStart(plumbing,  garden);
  endBeforeStart(windows,   moving);
  endBeforeStart(facade,    moving);
  endBeforeStart(garden,    moving);
  endBeforeStart(painting,  moving);

}

execute {

  writeln("Masonry  : " + masonry.start   + ".." + masonry.end);
  writeln("Carpentry: " + carpentry.start + ".." + carpentry.end);
  writeln("Plumbing : " + plumbing.start  + ".." + plumbing.end);
  writeln("Ceiling  : " + ceiling.start   + ".." + ceiling.end);
  writeln("Roofing  : " + roofing.start   + ".." + roofing.end);
  writeln("Painting : " + painting.start  + ".." + painting.end);
  writeln("Windows  : " + windows.start   + ".." + windows.end);
  writeln("Facade   : " + facade.start    + ".." + facade.end);
  writeln("Garden   : " + garden.start    + ".." + garden.end);
  writeln("Moving   : " + moving.start    + ".." + moving.end);

}
