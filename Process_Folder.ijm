// Define input and output directories, file suffix, and keyword using user-defined parameters
#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix
#@ String (label = "Keyword", value = "keyword") keyword

// Initialize a counter for processed files
n = 0;

// Start processing the input folder
processFolder(input);

// Function to scan folders/subfolders/files to find files with the correct suffix and keyword
function processFolder(input) {
    // Get a list of files in the input directory
    list = getFileList(input);
    // Iterate through the list of files
    for (i = 0; i < list.length; i++) {
        // Check if the current item is a directory
        if (File.isDirectory(input + File.separator + list[i]))
            // Recursively process subfolders
            processFolder(input + File.separator + list[i]);
        else if (endsWith(list[i], suffix) && (indexOf(list[i], keyword) >= 0)) {
            // If the file has the correct suffix and contains the keyword, process it
            processFile(input, output, list[i], n);
            // Increment the counter
            n = n + 1;
        }
    }
}

// Function to process a single file
function processFile(input, output, file, index) {

    print("Processing: " + input + File.separator + file);
    print("Saving to: " + output);
    open(input + File.separator + file);
    // You can simply copy the commands in recoder
    run("32-bit");
    close("");
    setAutoThreshold("Default dark no-reset");
    //run("Threshold...");
    run("Set Measurements...", "display area mean standard modal min integrated limit redirect=None decimal=3");
    run("Measure");
    setResult("File Name", index, file);
    saveAs("Results", output + File.separator + "Results.xls");
    close("*");
}
