CD C:\LabFiles

Install-Module -Name "Az" -AllowClobber

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SpektraSystems/CloudLabs-Azure/master/azure-synapse-analytics-workshop-400/artifacts/setup/01.Setup-Storage.ps1" -OutFile "C:\LabFiles\01.Setup-Storage.ps1"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SpektraSystems/CloudLabs-Azure/master/azure-synapse-analytics-workshop-400/artifacts/setup/51.ValidateStorageData.ps1" -OutFile "C:\LabFiles\51.ValidateStorageData.ps1"

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/SpektraSystems/CloudLabs-Azure/master/azure-synapse-analytics-workshop-400/artifacts/setup/azcopy.exe" -OutFile "C:\LabFiles\azcopy.exe"
