# High-throughput Image Processing
### Background
Although our starting point was a quantitative analysis of antibodies bound to the cell, actually, the study of fluorescence intensity can also be used to quantify protein expression levels, examine changes in cellular processes, and compare signal intensities between different samples or experimental conditions.  Our project involves validating antibody-cell connections in cell experiments by observing confocal fluorescence intensity. Considering that confocal analysis is a widely used technique in current research, and standardization of confocal data image processing often involves repetitive selection steps to calculate average fluorescence intensity.

### Introduction
We have developed a script specifically designed for high-throughput analysis of confocal image fluorescence intensity, inspired by the tedious data processing in wet lab experiments. This script provides the high throughput processing of TIF images using macro language in Fiji.  With our program, we can directly perform automatic normalization and statistical analysis of fluorescence intensity for all images in a given folder, significantly reducing repetitive workload and streamlining the process. Actually, you can change the core codes with different functions in this high-throughput frame.

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
<div align=center>
<img src = "https://github.com/Tesla-SHT/Mean-Fluorescence-Intensity/assets/109467147/293f3c51-431c-4573-bb6b-197a4545c7a9" alt = "input interface" style = "padding-left:25%; width:50%;"/>
</div>

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

3. Now we can just process every single image and measure their Mean Fluorescence Intensity! (Of course, you can DIY everything just using the recorder in ImageJ.
```Java
function processFile(input, output, file, index) {

    print("Processing: " + input + File.separator + file);
    print("Saving to: " + output);
    open(input + File.separator + file);
    // You can simply copy the commands from the recorder to replace the following code
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
```

4. Methods of DIY
- Firstly, you should open the recorder to see what you will do in the form of Macro.
<div align=center>
<img src = "https://github.com/Tesla-SHT/Mean-Fluorescence-Intensity/assets/109467147/f9c54063-6c32-406b-b942-70e3596fd37e" alt = "input interface" style = "padding-left:25%; width:50%;"/>
</div>
- Remember to choose Macro language.
<div align=center>
<img src = "https://github.com/Tesla-SHT/Mean-Fluorescence-Intensity/assets/109467147/8050016f-0719-4c85-ab8d-d394bc7639a1" alt = "input interface" style = "padding-left:25%; width:50%;"/>
</div>
- Now you can perform your measurement and every step will be recorded!

