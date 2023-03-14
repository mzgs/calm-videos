$folderPath = "C:\Users\mustafa\Desktop\calm_videos\vertical"  

 
$outputFile = "output.json"
$files = Get-ChildItem $folderPath | Where-Object { ! $_.PSIsContainer }
$jsonArray = @()

foreach ($file in $files) {
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    $encodedFileName = [System.Uri]::EscapeDataString($fileName)
    $jsonObject = @{
        "title" = $fileName
        "image" = "https://github.com/mzgs/calm-videos/raw/main/images/$encodedFileName.jpg"
        "video" = "https://github.com/mzgs/calm-videos/raw/main/videos/$encodedFileName.mp4"
        "color" = "#9AAD5B"
        "is_premium" = $true
        "tags" = @("NATURE")
    }
    $jsonArray += $jsonObject
}

$jsonString = ConvertTo-Json $jsonArray -Depth 100
Set-Content -Path $outputFile -Value $jsonString
