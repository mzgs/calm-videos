# Read the JSON file into a variable
$json = Get-Content -Path "items.json" -Raw | ConvertFrom-Json

# Read the colors.txt file into a hashtable
$colors = @{}
Get-Content -Path "colors.txt" | ForEach-Object {
    $filename, $color = $_ -split " - "
    $colors[$filename] = $color
}

# Update the color value and title in each JSON object
$json | ForEach-Object {
    $filename = $_.image -split "/" | Select-Object -Last 1
    $filename = $filename.Replace("%20", " ")
    if ($colors.ContainsKey($filename)) {
        $_.color = "#" + $colors[$filename]
    } else {
        $color = $filename -replace "\..+$", ""
        $_.color = "#" + $color
    }
    $_.title = ($filename -split "\.")[0]
}

# Save the updated JSON to a file
$json | ConvertTo-Json -Depth 100 | Set-Content -Path "output.json"
