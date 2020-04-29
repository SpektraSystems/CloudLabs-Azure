. C:\LabFiles\AzureCreds.ps1

$userName = $AzureUserName
$password = $AzurePassword

$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $userName, $SecurePassword

Connect-AzAccount -Credential $cred | Out-Null

$rgName = (Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like "*L400*" }).ResourceGroupName
$storageAccounts = Get-AzResource -ResourceGroupName $rgName -ResourceType "Microsoft.Storage/storageAccounts"
$storageName = $storageAccounts | Where-Object { $_.Name -like 'asadatalake*' }
$storage = Get-AzStorageAccount -ResourceGroupName $rgName -Name $storageName.Name
$storageContext = $storage.Context

$containerName = "wwi-02"
$resources = $null
$resources = Get-AzStorageBlob -Context $storageContext -Container $containerName | Where-Object { $_.Length -ne 0 } | Where-Object { $_.BlobType -ne "PageBlob" }
$resources.Count # We expect 104736 files.

Logout-AzAccount | Out-Null
