state("crispy-doom")
{
    int levelnum: "crispy-doom.exe", 0x19F11C;
    int menuvalue: "crispy-doom.exe", 0x19E560;
    int playerHealth: "crispy-doom.exe", 0x19EAAC;
    int gameState: "crispy-doom.exe", 0x19F120;
    int levelTime: "crispy-doom.exe", 0x11EBB70; //just test
    int demoPlaying: "crispy-doom.exe", 0x154EA28;
}

init
{
    vars.timerRunning = 0;
	vars.splitsCurrent = 0;
	vars.splitsTemp = 0;
	vars.splitsTotal = 0;
}

start
{
    if(current.levelnum == 1 && current.menuvalue == 0 && vars.timerRunning == 0 && current.playerHealth != 0 && current.demoPlaying == 0)
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
    if(current.levelnum < old.levelnum)
    {
        vars.timerRunning = 0;
        return true;
    }
    if(current.playerHealth == 0)
    {
        vars.timerRunning = 0;
        return true;
    }
    if(current.levelnum == 1 && current.levelTime < old.levelTime)
    {
        vars.timerRunning = 0;
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

update
{
	vars.splitsCurrent = current.levelTime / 35;

	if(current.levelnum == 1)
		vars.splitsTotal = current.levelTime/35;
	if(current.levelnum != 1 && current.gameState == 0)
		vars.splitsTotal = vars.splitsTemp + current.levelTime / 35;
	
}