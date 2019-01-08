/*********************************************
 * OPL 12.8.0.0 Model
 * Author: Lenovo
 * Creation Date: Sep 24, 2018 at 9:20:51 AM
 *********************************************/
dvar float+ Gas;
dvar float+ Chloride;

int i = 3;
int size = i * i;
int Max0 = maxint;
{string} Tasks = {"masnory","carpentry","plumbing",
					"ceiling","roofing","painting",
					"windows","facade","garden","mving"};
					
range Rows = 1..10;
int n = 8;
range Colums = n+1..2*n+1;
dvar int g in Rows;

range float X = 1.0..100.0;
dvar float x in X;

int a[1..4] = [10,20,30,40];
float b[1..4] = [1.0,2.3,4.5,6.3];
string s[1..4] = ["a","b","d","c"];

range R = 1..4;
{string} Days = {"Monday","Tuesday","Wesday","Thirsday"};
int c[Days] = [1,2,3,4];

int a_m[1..2][1..3] = ...;
int b_m[Days][1..3] = ...;

// array initialization expression
int A[Colums];

tuple Point {
		int x;
		int y;
};

Point point[i in 1..3] = <i,i+1>;
Point p = <2,3>;
{Point} points = {<1,2>,<3,4>};
tuple Rectangle {
		Point ll;
		Point ur;
};

int p_x = p.x;

// iteration index
//forall(j in Colums){
//};

maximize
  40 * Gas + 50 * Chloride;
 

subject to{
	ctMaxTotal:
		Gas + Chloride <= 50;
	ctMaxTotal2:
		3 * Gas + 4 * Chloride <= 180;
	ctMaxTotal3:
		Chloride <= 40;
}