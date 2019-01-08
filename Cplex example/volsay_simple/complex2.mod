/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 10:53:31 AM
 *********************************************/
{string} Products = {"gas","chloride"};
{string} Components = {"nitrogen","hydrogen","chlorine"};

float Demand[Products][Components] = [[1,3,0],[1,4,1]];
float Profit[Products] = [40,50];
float Stock[Components] = [50,180,40];

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