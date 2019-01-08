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

int NbHouses = ...; 
range Houses = 1..NbHouses;

{string} WorkerNames = ...;  
{string} TaskNames   = ...;

int    Duration [t in TaskNames] = ...;
string Worker   [t in TaskNames] = ...;

tuple Precedence {
   string pre;
   string post;
};

{Precedence} Precedences = ...;

int   ReleaseDate[Houses] = ...; 
int   DueDate    [Houses] = ...; 
float Weight     [Houses] = ...; 

//Create the house interval variables
dvar interval houses[h in Houses] in ReleaseDate[h]..(maxint div 2)-1;
//Create the task interval variables
dvar interval itvs [h in Houses][t in TaskNames] size Duration[t];
//Create the sequence variables
dvar sequence workers[w in WorkerNames] in
	all(h in Houses, t in TaskNames: Worker[t]==w) itvs[h][t] types
	all(h in Houses, t in TaskNames: Worker[t]==w) h;
//Create the transition times
tuple triplet { int loc1; int loc2; int value; };
{triplet} transitionTimes = { <i,j, ftoi(abs(i-j))> | i in Houses, j in Houses };

execute {
		cp.param.FailLimit = 20000;
}

//Add the objective
minimize sum(h in Houses)
(Weight[h] * maxl(0, endOf(houses[h])-DueDate[h]) + lengthOf(houses[h]));

subject to {

//Add the precendence constraints
forall(h in Houses)
	forall(p in Precedences)
		endBeforeStart(itvs[h][p.pre], itvs[h][p.post]);
//Add the house span constraints
forall(h in Houses)
	span(houses[h], all(t in TaskNames) itvs[h][t]);
//Add the no overlap constraints
forall(w in WorkerNames)
	noOverlap(workers[w], transitionTimes);
}
