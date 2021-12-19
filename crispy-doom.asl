state("crispy-doom")
{
    int levelnum: "crispy-doom.exe", 0x19F11C;
    int menuvalue: "crispy-doom.exe", 0x19E560;
    int playerHealth: "crispy-doom.exe", 0x19EEAC;
}

init
{
    vars.split = 0;
    vars.timerRunning = 0;
	vars.splitsCurrent = 0;
	vars.splitsTemp = 0;
	vars.splitsTotal = 0;
}

start
{
    if(current.levelnum == 1 && current.menuvalue == 0 && vars.timerRunning == 0)
    {
        vars.timerRunning = 1;
        vars.splitsCurrent = 0;
		vars.splitsTemp = 0;
		vars.splitsTotal = 0;
        return true;
    }
}

split
{
    if(current.levelnum > old.levelnum)
    {
        vars.splitsTemp = vars.splitsTotal;
        return true;
    }
}

reset
{
    if(current.levelnum < old.levelnum){
        return true;
    }
    if(current.levelnum == 0){
        return true;
    }
}

isLoading
{
    if(current.menuvalue == 1){
        return true;
    } else{
        return false;
    }
}