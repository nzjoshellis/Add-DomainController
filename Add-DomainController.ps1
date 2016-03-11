################################################################
# SCRIPT: Add-DomainController
# AUTHOR: Josh Ellis - Josh@JoshEllis.NZ
# Website: JoshEllis.NZ
# VERSION: 1.0
# DATE: 12/03/2016
# DESCRIPTION: Promotes a Server to a Domain Controller
################################################################

[CmdletBinding()]
Param(
[Parameter(Mandatory=$True,Position=1)]
[string]$DomainName,
[Parameter(Mandatory=$True,Position=2)]
[string]$ADRestorePassword
     )

# Variables
$DatabasePath = "C:\ADDS\NTDS"
$SYSVOLPath = "C:\ADDS\SYSVOL"
$LogPath = "C:\ADDS\Logs"
$Creds = Get-Credential -Message "Domain Admin Credentials:"
$RestorePassword = ConvertTo-SecureString -String $ADRestorePassword -AsPlainText -Force

# Install Required Windows Features
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# Promote DC
Install-ADDSDomainController -DomainName $DomainName `
                             -Credential $Creds `
                             -SafeModeAdministratorPassword $RestorePassword `
                             -DatabasePath $LogPath `
                             -LogPath $DatabasePath `
                             -SysvolPath $SYSVOLPath `
                             -NoRebootOnCompletion:$false `
                             -Force:$true
