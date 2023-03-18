
Add-Type -AssemblyName System.Drawing

$folderPath = "C:\Users\mustafa\Desktop\calm_videos\thumbs"
 

# Get all the image files in the folder
$imageFiles = Get-ChildItem -Path $folderPath   -File

# Initialize an empty array to store the output lines
$outputLines = @($imageFiles.Count)


# Loop through each image file and detect its dominant color
foreach ($imageFile in $imageFiles) {
     
    Write-Output "file processing" 
    # Load the image file
    $image = New-Object System.Drawing.Bitmap($imageFile.FullName)

    # Get the width and height of the image
    $width = $image.Width
    $height = $image.Height

    # Initialize an empty dictionary to store the color counts
    $colorCounts = @{}

    # Loop through each pixel of the image and count the occurrences of each color
    for ($x = 0; $x -lt $width; $x++) {
        for ($y = 0; $y -lt $height; $y++) {
            $color = $image.GetPixel($x, $y)
            $hexColor = "{0:x2}{1:x2}{2:x2}" -f $color.R, $color.G, $color.B
            if ($colorCounts.ContainsKey($hexColor)) {
                $colorCounts[$hexColor] += 1
            }
            else {
                $colorCounts[$hexColor] = 1
            }
        }
    }

    # Get the color with the highest count
    $dominantColor = $colorCounts.GetEnumerator() | Sort-Object -Property Value -Descending | Select-Object -First 1

    # Build the output line and add it to the output array
    $outputLine = "$($imageFile.Name) - $($dominantColor.Key)"
    $outputLines += $outputLine

    # Dispose of the image object
    $image.Dispose()
}

 

 

$outputLines | Out-File -FilePath "colors.txt"

# Print a message when the script has finished running
Write-Host "Finished processing images."
