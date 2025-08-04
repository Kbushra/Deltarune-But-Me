_name = "DFNerf";
desc = "-1 DF\nPermanent";
useTarget = "Enemies";

///@func use(target)
use = function(target)
{
	target.df -= 1;
	if target.df < 1 { target.df = 1; }
}