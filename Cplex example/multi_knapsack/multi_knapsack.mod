/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 3:18:34 PM
 *********************************************/
int NbItems = ...;
int NbResources = ...;
range Items = 1..NbItems;
range Resources = 1..NbResources;
int Capacity[Resources] = ...;
int Value[Items] = ...;
int Use[Resources][Items] = ...;
int MaxValue = max(r in Resources) Capacity[r];

dvar int Take[Items] in 0..MaxValue;

maximize
  sum(i in Items)
    Value[i] * Take[i];

subject to {
	forall( r in Resources)
	  ctCapcity:
	  	sum( i in Items)
	  	  Use[r][i] * Take[i] <= Capacity[r];
}