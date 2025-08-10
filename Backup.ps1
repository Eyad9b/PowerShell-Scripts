
#This script automatically copies files from a source folder to a backup folder 
#It’s useful for:
# Creating regular backups of important files.
# Preventing data loss in case of accidental deletion or system failure.

# set the source folder path
$source = "PATH"

# set Backup folder path
$backup = "D:\Backup-folder"

# check backup folder

if (-not(Test-Path -path $backup)){
    #if not exist, create it 
    New-item -ItemType Directory -path $backup
}

#copy all files and subfolders from source to backup

Copy-Item -Path "$source\*" -Destination $backup -Recurse -Force

#print confirmation message with date
Write-Output "Backup completed successfully on $(Get-Date)"