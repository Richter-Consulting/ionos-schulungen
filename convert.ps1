# Get all mmd file
$mmdFiles = Get-ChildItem -Path . -Filter "*.mmd" -Recurse
foreach ($file in $mmdFiles) {
    $pngFileName = Join-Path -Path $file.DirectoryName -ChildPath ($file.BaseName + ".png")
    $svgFileName = Join-Path -Path $file.DirectoryName -ChildPath ($file.BaseName + ".svg")
    mmdc -i $file.FullName -o $pngFileName -s 4 -b transparent
    mmdc -i $file.FullName -o $svgFileName -s 4 -b transparent
}