# Set threshold for Disk
$diskThreshold = 10GB

#cpu threshold (percentage)
$cpuThreshold = 80

#Ram threshold (percentage)
$RamThreshold = 80

# First check the Disk space

#Get information from C drive 
$drive = Get-PSDrive -Name C

#Get info about free space
$freeSpace = $drive.Free

# check if the free space is lower than threShold

if ($freeSpace -lt $diskThreshold)
{
    Write-Output "warning: Low Disk space "
}
else
{
    Write-Output "C: drive has sufficient free space"
}

#CPU usage
#Retrieve the "\Processor(_Total)\% Processor Time"
#Get-Counter is a PowerShell cmdlet that retrieves performance counters from Windows
#"Processor(_Total)\\% Processor Time" path to the performance counter
$cpuUsage = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

#Round CPU usage to 2 decimal places

$cpuUsage = [math]::Round($cpuUsage, 2)

#compare with threshold
if($cpuUsage -gt $cpuThreshold)
{
    Write-Output "WARNING: high CPU usage detected "
}
else {
   Write-Output "Ok"
}

#RAM usage 

#Get system memoryinformation
$os = Get-CimInstance Win32_OperatingSystem

#Calculate total and free memory in MB

$totalMemory = [math]::Round($os.TotalVisibleMemorySize / 1KB, 2)
$freeMemory = [math]::Round($os.FreePhysicalMemory/ 1KB, 2)

#calculate used  memory in percentage 

$usedMemoryPercentage = [math]::Round((($totalMemory - $freeMemory) /$totalMemory) * 100,2)

#compare with threshold

if ($usedMemoryPercentage -gt $RamThreshold)
{
    Write-Output "WARNING: High usage detected"
} 
else{
    Write-Output "OK"
}