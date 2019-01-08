/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 6:58:35 PM
 *********************************************/
{string} Products = ...;
{string} Resources = ...;
int NbPeriods = ...;
range Periods = 1..NbPeriods;
range Periods0 = 0..NbPeriods;

float Consumption[Resources][Products] = ...;
float Capacity[Resources] = ...;
float Demand[Products][Periods] = ...;
float InsideCost[Products] = ...;
float OutsideCost[Products] = ...;
float Inventory[Products] = ...;
float InvCost[Products] = ...;

dvar float+ Inside[Products][Periods];
dvar float+ Outside[Products][Periods];
dvar float+ Inv[Products][Periods0];

minimize
  sum(p in Products, t in Periods)
    (Inside[p][t] * InsideCost[p] + Outside[p][t] * OutsideCost[p] + Inv[p][t] * InvCost[p]);
 
subject to{
	forall( r in Resources, t in Periods)
	  ctCapacity:
	  	sum(p in Products)
	  	  Consumption[r][p] * Inside[p][t] <= Capacity[r];
	  	  
	forall( p in Products, t in Periods)
	  ctDemand:
	  	Inv[p][t-1] + Inside[p][t] + Outside[p][t] == Demand[p][t] + Inv[p][t];
	  	
}