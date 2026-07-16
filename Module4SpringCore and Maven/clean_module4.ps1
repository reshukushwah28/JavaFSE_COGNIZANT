$ErrorActionPreference = 'Stop'
$modulePath = 'c:\MyProjects\Cognizant Practice HandsOn\src\Module4SpringCore and Maven'
$files = Get-ChildItem -Path $modulePath -Recurse -File -Include *.java, *.xml, *.md, *.properties, *.pom
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    # Remove // line comments
    $content = $content -replace '(?m)//.*$', ''
    # Remove block comments /* ... */ including JavaDoc /** ... */
    $content = $content -replace '/\*.*?\*/', ''
    # Remove XML comments <!-- ... -->
    $content = $content -replace '<!--.*?-->', ''
    # Replace example data
    $content = $content -replace 'Clean Code', 'Sample Title'
    $content = $content -replace 'Robert C. Martin', 'Sample Author'
    $content = $content -replace '"Clean Code"', '"Sample Title"'
    $content = $content -replace '"Robert C. Martin"', '"Sample Author"'
    # Write back
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    Write-Host "Processed $($file.FullName)"
}
