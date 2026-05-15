#This Script is for Monitotring Systems Memory spikes 
#Follow It Step by Step 

#1. Define the Threshold (For Example I have used 90%)
$Threshold = 80

# 2. Get Memory Stats
#Total RAM
$TotalRAM = $ComputerSystem.TotalVisibleMemorySize
#Free RAM
$FreeRAM = $ComputerSystem.FreePhysicalMemory
#Calculation for RAM Usage
$UsedPercent = [Math]::Round(((($TotalRAM - $FreeRAM) / $TotalRAM) * 100), 2)

Write-Host "Current RAM Usage: $UsedPercent%" -ForegroundColor Cyan

# 3. Logic: Check if usage exceeds threshold
if ($UsedPercent -gt $Threshold) {
    Write-Host "ALERT: High memory usage detected!" -ForegroundColor Red
    
    # Identify the Top 3 "Memory USing Service"
    $TopProcesses = Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 3
    
    # Log the findings to a file
    $LogPath = "Path"
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    "--- ALERT at $Timestamp ---" | Out-File $LogPath -Append
    "Usage: $UsedPercent%" | Out-File $LogPath -Append
    $TopProcesses | Out-File $LogPath -Append
    
    Write-Host "Top processes logged to $LogPath" -ForegroundColor Yellow
} 
else {
    Write-Host "System health is optimal." -ForegroundColor Green
}
