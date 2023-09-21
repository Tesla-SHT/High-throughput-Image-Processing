// Process multiple images in a folder

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

n=0;//counter for file's index
processFolder(input);

// function to scan folders/subfolders/files to find files with correct suffix
function processFolder(input) {
	list = getFileList(input);
	list = Array.sort(list);
	for (i = 0; i < list.length; i++) {
		if(File.isDirectory(input + File.separator + list[i]))
			processFolder(input + File.separator + list[i]);
		else if(endsWith(list[i], suffix)){
			n=n+1;
			processFile(input, output, list[i],n);
		}
	}
}

function processFile(input, output, file,index) {
	print("Processing: " + input + File.separator + file);
	print("Saving to: " + output);//Just export the result to the log for checking.
	//You can replace the following code by the the content in the macro recoder. 
	open(input + File.separator + file);
	run("32-bit");
	close("");
	setAutoThreshold("Default dark no-reset");
	//run("Threshold...");
	run("Set Measurements...", "display area mean standard modal min integrated limit redirect=None decimal=3");
	run("Measure");	
	
	//Save the result to an excel file
	setResult("File Name", index, file); //You can DIY the result columns
	saveAs("Results", output+File.separator +"Results.xls");
	close("*");
}
