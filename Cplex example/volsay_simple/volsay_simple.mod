/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 10:38:14 AM
 *********************************************/
dvar float+ Gas;
dvar float+ Chloride;

maximize 
	40 * Gas + 50 * Chloride;

subject to{
	ctMaxTotal:
		Gas + Chloride <= 50;
	ctMaxTotal1:
		3 * Gas + 4 * Chloride <= 180;
	ctMaxChloride:
		Chloride <= 40;
}