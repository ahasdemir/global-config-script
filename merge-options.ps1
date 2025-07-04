param(
    [string]$SourceFile,
    [string]$DestFile
)

# Function to merge options.txt files
function Merge-OptionsFile {
    param($Source, $Dest)
    
    if (-not (Test-Path $Source)) {
        Write-Host "Source file does not exist: $Source"
        return $false
    }
    
    # Read source file (new settings)
    $sourceLines = Get-Content $Source -ErrorAction SilentlyContinue
    if (-not $sourceLines) {
        Write-Host "Could not read source file: $Source"
        return $false
    }
    
    # If destination doesn't exist, just copy the source
    if (-not (Test-Path $Dest)) {
        Copy-Item $Source $Dest
        Write-Host "Destination file didn't exist, copied source to: $Dest"
        return $true
    }
    
    # Read destination file (existing settings)
    $destLines = Get-Content $Dest -ErrorAction SilentlyContinue
    if (-not $destLines) {
        $destLines = @()
    }
    
    # Create hashtable for existing settings
    $existingSettings = @{}
    foreach ($line in $destLines) {
        if ($line -match '^([^:]+):(.*)$') {
            $existingSettings[$matches[1]] = $matches[2]
        }
    }
    
    # Define excluded settings that should not be transferred
    $excludedSettings = @("resourcePacks", "incompatibleResourcePacks")
    
    # Process source file and update/add settings
    $updatedCount = 0
    $addedCount = 0
    $excludedCount = 0
    
    foreach ($line in $sourceLines) {
        if ($line -match '^([^:]+):(.*)$') {
            $key = $matches[1]
            $value = $matches[2]
            
            # Skip excluded settings
            if ($excludedSettings -contains $key) {
                $excludedCount++
                Write-Host "Excluded: $key (not transferred)"
                continue
            }
            
            if ($existingSettings.ContainsKey($key)) {
                if ($existingSettings[$key] -ne $value) {
                    $existingSettings[$key] = $value
                    $updatedCount++
                    Write-Host "Updated: $key = $value"
                }
            } else {
                $existingSettings[$key] = $value
                $addedCount++
                Write-Host "Added: $key = $value"
            }
        }
    }
    
    # Write merged settings back to destination
    $outputLines = @()
    foreach ($key in $existingSettings.Keys | Sort-Object) {
        $value = $existingSettings[$key]
        $outputLines += "${key}:${value}"
    }
    
    try {
        $outputLines | Out-File -FilePath $Dest -Encoding UTF8
        Write-Host "Merge completed successfully!"
        Write-Host "Added $addedCount new settings, updated $updatedCount existing settings, excluded $excludedCount settings"
        return $true
    } catch {
        Write-Host "Failed to write to destination file: $Dest"
        Write-Host "Error: $($_.Exception.Message)"
        return $false
    }
}

# Execute the merge
$result = Merge-OptionsFile -Source $SourceFile -Dest $DestFile
if (-not $result) {
    exit 1
}
