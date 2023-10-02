# Mean-Fluorescence-Intensity
### Introduction
Our project involves validating antibody-cell connections in cell experiments by observing confocal fluorescence intensity. Considering that confocal analysis is a widely used technique in current research, and standardization of confocal data image processing often involves repetitive selection steps to calculate average fluorescence intensity. Consequently, we have developed a software specifically designed for high-throughput analysis of confocal image fluorescence intensity, inspired by the tedious data processing in wet lab experiments. This script provides the high throughput processing of TIF images using macro language in Fiji.

With our program, we can directly perform automatic normalization and statistical analysis of fluorescence intensity for all images in a given folder, significantly reducing repetitive workload and streamlining the process.

Although our starting point was a quantitative analysis of antibodies bound to the cell, actually, the study of fluorescence intensity can also be used to quantify protein expression levels, examine changes in cellular processes, and compare signal intensities between different samples or experimental conditions.
This is one of the software made by westlake-china team in the iGEM competition. The script provides high throughput processing of TIF images using macro language in Fiji.

### Startup
1. Download Fiji via https://imagej.net/software/fiji/downloads.
2. Open Process_Folder.ijm in the Fiji app and click the "run" button at the bottom of the window.
3. Choose the input directory containing the images and the output directory for the resulting data, which is an Excel file.

### Code Procedure
1. This code block is used for the input interface
```Java
  #@ File (label = "Input directory", style = "directory") input
  #@ File (label = "Output directory", style = "directory") output
  #@ String (label = "File suffix", value = ".tif") suffix
  #@ String (label = "Keyword", value = "keyword") keyword
```
![image](https://github.com/Tesla-SHT/Mean-Fluorescence-Intensity/assets/109467147/293f3c51-431c-4573-bb6b-197a4545c7a9)
2. After initialization, we will first start file processing, that is, finding every file in the specific folder (having subfolders) with the correct suffix and keyword.
```Java
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
```
