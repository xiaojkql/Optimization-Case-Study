/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 10:44:49 AM
 *********************************************/
{string} Products = {"gas","chloride"};
dvar float production[Products];//decision variables

maximize
  40 * production["gas"] + 50 * production["chloride"];
 
 subject to {
 	production["gas"] + production["chloride"] <= 50;
 	3 * production["gas"] + 4 * production["chloride"] <= 180;
 	production["chloride"] <= 40; 
 }