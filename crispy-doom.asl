state("crispy-doom")
{
    int map: "crispy-doom.exe", 0x19F11C;
    int menuvalue: "crispy-doom.exe", 0x19E560;
    int playerHealth: "crispy-doom.exe", 0x19EAAC;
    float levelTime: "crispy-doom.exe", 0x138BB70;
}

init
{
    byte[] exeMD5HashBytes = new byte[0];
	using (var md5 = System.Security.Cryptography.MD5.Create())
	{
		using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
		{
			exeMD5HashBytes = md5.ComputeHash(s);
		}
	}
	var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);
	//print("MD5Hash: " + MD5Hash.ToString());

	if (MD5Hash == "7ED6381BE83340DF7C4D4EF67353EC18")
	{
		version = "v5.10.3";
		print("Detected game version: " + version + " - MD5Hash: " + MD5Hash);
	}

    	else
	{
		version = "UNDETECTED";
		print("UNDETECTED GAME VERSION - MD5Hash: " + MD5Hash);
	}

    vars.timerRunning = 0;
	vars.splitsCurrent = 0;
	vars.splitsTemp = 0;
	vars.splitsTotal = 0;
}

start
{
    if(current.map == 1 && current.menuvalue == 0 && vars.timerRunning == 0 && current.playerHealth != 0)
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
    if(current.map > old.map)
    {
        vars.splitsTemp = vars.splitsTotal;
        return true;
    }
}

reset
{
    if(current.map < old.map)
    {
        vars.timerRunning = 0;
        return true;
    }
    if(current.playerHealth == 0)
    {
        vars.timerRunning = 0;
        return true;
    }
    if(current.map == 1 && current.levelTime < old.levelTime)
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
    if(version.Contains("UNDETECTED")){
        return false;
    }
}
