startup
{
	var result = MessageBox.Show(timer.Form,
		"This autosplitter script is obsolete.\n"
		+ "Please disable this script in LiveSplit and use my new autosplitter for Ultimate DOOM.\n"
		+ "\nClick OK to open the mod's website.",
		"Crispy-DOOM autosplitter script",
		MessageBoxButtons.OKCancel,
		MessageBoxIcon.Information);

	if (result == DialogResult.OK)
	{
		Process.Start("https://github.com/rogender/LiveSplit.Ultimate-DOOM/blob/main/README.md");
	}
}
