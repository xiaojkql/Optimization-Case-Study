/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 11:11:42 AM
 *********************************************/
{string} Products = ...;
{string} Components = ...;

float Demand[Products][Components] = ...;
float Profit[Products] = ...;
float Stock[Components] = ...;

dvar float+ Production[Products];

maximize
  sum(p in Products)
    Profit[p] * Production[p];
   
subject to {
	forall(c in Components)
	  ct:
	  	sum(p in Products)
	  	  Demand[p][c] * Production[p] <= Stock[c];
}