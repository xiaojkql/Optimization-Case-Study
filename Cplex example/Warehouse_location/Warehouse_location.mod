/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 6:30:28 PM
 *********************************************/
int Fixed = ...;
{string} Warehouses = ...;
int NbStores = ...;
range Stores = 0..NbStores;
int Capacity[Warehouses] = ...;
int SupplyCost[Stores][Warehouses] = ...;
dvar boolean Open[Warehouses];
dvar boolean Supply[Stores][Warehouses];

minimize
  sum(w in Warehouses)
    Fixed * Open[w] +
  sum(w in Warehouses, s in Stores)
    SupplyCost[s][w] * Supply[s][w];
    
subject to {
	forall(s in Stores)
	  ctEachStoreHasOneWarehouse:
	  	sum(w in Warehouses)
	  	  Supply[s][w] == 1; //写和的等式约束的语法
	
	forall(w in Warehouses, s in Stores)
	  ctUseOpenWarehouses:
	  	Supply[s][w] <= Open[w]; //保证未开的店没有给任何一个提供供应
	
	forall(w in Warehouses)
	  ctMaxUseofWarehouses:
	  	sum(s in Stores)
	  	  Supply[s][w] <= Capacity[w];
}

{int} Storesof[w in Warehouses] = {s | s in Stores : Supply[s][w] == 1};
execute DISPLAY_RESULTS{
	writeln("Open = ",Open);
	writeln("Storesof=",Storesof);
}

