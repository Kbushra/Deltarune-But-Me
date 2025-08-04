_name = "EzHeal";
desc = "Heals 50HP";
useTarget = "Players";

///@func use(target)
use = function(target)
{
	doHeal(50, target);
}