state("crispy-doom")
{
    int levelnum: "crispy-doom.exe", 0x19F11C;
    int menuvalue: "crispy-doom.exe", 0x1A07D0;
}

init
{
    vars.split = 0;
}

start
{
    if(current.levelnum == 1 && current.menuvalue == 0){
        vars.timerRunning = 1;
        return true;
        
    }
}

split
{
    if(current.levelnum > old.levelnum){
        return true;
    }
}

reset
{
    if(current.levelnum < old.levelnum && current.levelnum == 0){
        return true;
    }
}

isLoading //it is working... finally
{
    if(current.menuvalue == 1){
        return true;
    } else{
        return false;
    }
}