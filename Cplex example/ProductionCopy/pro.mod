/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 7:18:49 PM
 *********************************************/
{string} Products = ...;
{string} Resources = ...;
int NbPeriods = ...;
range Periods = 1..NbPeriods;

float Consumption[Resources][Products] = ...;
float Capacity[Resources] = ...;
float Demand[Products][Periods] = ...;
float InsideCost[Products] = ...;
float OutsideCost[Products]  = ...;
float Inventory[Products]  = ...;
float InvCost[Products]  = ...;
range Periods0 = 0..NbPeriods;

dvar float+ Inside[Products][Periods];
dvar float+ Outside[Products][Periods];
dvar float+ Inv[Products][Periods0];


minimize
  sum( p in Products, t in Periods ) 
      (InsideCost[p]*Inside[p][t] + 
       OutsideCost[p]*Outside[p][t] +
       InvCost[p]*Inv[p][t]);

subject to {
  forall( r in Resources, t in Periods )
    ctCapacity:
      sum( p in Products ) 
        Consumption[r][p] * Inside[p][t] <= Capacity[r];
  forall( p in Products , t in Periods )
    ctDemand:
      Inv[p][t-1] + Inside[p][t] + Outside[p][t] == Demand[p][t] + Inv[p][t];
  forall( p in Products )
    ctInventory:
      Inv[p][0] == Inventory[p]; 
};