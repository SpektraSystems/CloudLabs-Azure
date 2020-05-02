. C:\LabFiles\AzureCreds.ps1

$userName = $AzureUserName
$password = $AzurePassword

$securePassword = $password | ConvertTo-SecureString -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $userName, $SecurePassword

Connect-AzAccount -Credential $cred | Out-Null

$resourceGroupName = (Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -like "*L400*" }).ResourceGroupName
$uniqueId =  (Get-AzResourceGroup -Name $resourceGroupName).Tags["DeploymentId"]
$subscriptionId = (Get-AzContext).Subscription.Id
$tenantId = (Get-AzContext).Tenant.Id
$keyVaultName = "asakeyvault$($uniqueId)"
$workspaceName = "asaworkspace$($uniqueId)"
$amlWorkspaceName = "amlworkspace$($uniqueId)"
$blobStorageAccountName = "asastore$($uniqueId)"
$dataLakeAccountName = "asadatalake$($uniqueId)"

# Invoice the Template deployment
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
  -TemplateUri "https://raw.githubusercontent.com/manesh-r/azure-synapse-analytics-workshop-400/master/artifacts/environment-setup/automation/00-asa-workspace-core.json" `
  -uniqueSuffix $uniqueId -sqlAdministratorLoginPassword $AzureSQLPassword
  
$userPrincipalName = (Get-AzContext).Account.Id
$userObjectId = (Get-AzADUser -UserPrincipalName (Get-AzContext).Account.Id).Id
$workspaceId  = (Get-AzADServicePrincipal -DisplayName $workspaceName).Id
$amlWorkspaceId  = (Get-AzADServicePrincipal -DisplayName $amlWorkspaceName).Id

Set-AzKeyVaultAccessPolicy -VaultName  $keyVaultName -UserPrincipalName $userPrincipalName -PermissionsToSecrets get,list,set,delete -PassThr
Set-AzKeyVaultAccessPolicy -VaultName  $keyVaultName -ObjectId $workspaceId -PermissionsToSecrets get,list -PassThr
Set-AzKeyVaultAccessPolicy -VaultName  $keyVaultName -ObjectId $amlWorkspaceId -PermissionsToKeys get,list,update,create,import,delete,recover,backup,restore,decrypt,encrypt,wrapkey,unwrapkey,verify,sign `
        -PermissionsToCertificates Get,List,Update,Create,Import,Delete,Recover,Backup,Restore,ManageContacts,ManageIssuers,GetIssuers,ListIssuers,SetIssuers,DeleteIssuers `
        -PermissionsToSecrets get,list,set,delete,recover,backup,restore -PassThr


$policies = (Get-AzKeyVault -VaultName $keyVaultName -ResourceGroupName $resourceGroupName).AccessPolicies
foreach($policy in $policies)
{
    $policy.DisplayName
    "CERT: " + $policy.PermissionsToCertificatesStr
    "KEYS: " + $policy.PermissionsToKeysStr
    "SECRETS: " + $policy.PermissionsToSecretsStr
}

$secretvalue = ConvertTo-SecureString 'G1KSwXmdOfQvZcdYUwTA' -AsPlainText -Force
Set-AzKeyVaultSecret -VaultName $keyVaultName -Name 'SQL-USER-ASA' -SecretValue $secretvalue

New-AzRoleAssignment -ResourceGroupName $resourceGroupName -ResourceName $blobStorageAccountName -ErrorAction Ignore `
 -ResourceType "Microsoft.Storage/storageAccounts" -SignInName $userPrincipalName -RoleDefinitionName "Storage Blob Data Contributor"
New-AzRoleAssignment -ResourceGroupName $resourceGroupName -ResourceName $dataLakeAccountName -ErrorAction Ignore `
 -ResourceType "Microsoft.Storage/storageAccounts" -SignInName $userPrincipalName -RoleDefinitionName "Storage Blob Data Contributor"
 
 # Add proctor AAD Group as Owner
 New-AzRoleAssignment -ResourceGroupName $resourceGroupName -ErrorAction Ignore `
  -ObjectId "37548b2e-e5ab-4d2b-b0da-4d812f56c30e" -RoleDefinitionName Owner

Logout-AzAccount
