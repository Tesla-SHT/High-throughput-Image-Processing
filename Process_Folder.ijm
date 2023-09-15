// Macro template to process multiple images in a folder

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

// See also Process_Folder.py for a version of this code
// in the Python scripting language.

processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	print(list.length);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		else if(endsWith(list[i], suffix))
			processFile(input, output, list[i]);
	}
}

function processFile(input, output, file) {
	// Do the processing here by adding your own code.
	
	// Leave the print statements until things work, then remove them.
	print("Processing: " + input + File.separator + file);
	print("Saving to: " + output);
	open(input + File.separator + file);
	run("32-bit");
	close("");
	setAutoThreshold("Default dark no-reset");
	//run("Threshold...");
	run("Set Measurements...", "display area mean standard modal min integrated limit redirect=None decimal=3");
	run("Measure");	
	saveAs("Results", output+File.separator +"Results.xls");
	close("*");
}