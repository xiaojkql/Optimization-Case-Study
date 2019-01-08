/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 25, 2018 at 2:48:43 PM
 *********************************************/
{string} Products = ...;
{string} Resources = ...;

tuple productData{
	float Demand;
	float insideCost;
	float outsideCost;
	float consumpation[Resources];
}; // ���ݽṹ����һ�����ݶ����ж������ʱ��������tuple��������

productData Product[Products] = ...;
float Capacity[Resources] = ...;

dvar float+ inside[Products];
dvar float+ outside[Products];

execute CPX_PARAM{
	cplex.preind = 0;
	cplex.simdisplay = 2;
}

minimize
  sum(p in Products)
    (Product[p].insideCost * inside[p] + Product[p].outsideCost * outside[p]);
    
subject to {
	forall(r in Resources)
		ctCapacity:
			sum(p in Products)
			  Product[p].consumpation[r] * inside[p] <= Capacity[r];
	
	forall(p in Products)
	  ctDemand:	
	  	inside[p] + outside[p] >= Product[p].Demand;
}

tuple R {float x; float y;};
{R} Result = {<inside[p],outside[p]> | p in Products}; // ������һ������Ϊ R �ļ���
execute{writeln("Result = ",Result);}

execute{
	for(p in Products)
		writeln("inside[",p,"].reducedCost = ",inside[p].reducedCost);
}


