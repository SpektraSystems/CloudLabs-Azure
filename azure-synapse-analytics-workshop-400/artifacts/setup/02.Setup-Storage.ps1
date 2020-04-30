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

$srcContext = $null
$srcUrl = $null
$rgLocation = (Get-AzResourceGroup -Name $rgName).Location
          
if($rgLocation -like "eastus")
{
    $srcUrl = "https://synapse400datalake.blob.core.windows.net/wwi-02?sv=2019-10-10&ss=b&srt=sco&sp=rl&se=2021-01-02T04:13:35Z&st=2020-04-29T19:13:35Z&spr=https&sig=yuCcqF655FZ5rOu4aIDjPlLskl%2F5%2BJClOQrzvSd8c%2FI%3D"
    $srcContext = New-AzStorageContext -StorageAccountName "synapse400datalake" -SasToken "?sv=2019-10-10&ss=b&srt=sco&sp=rl&se=2021-01-02T04:13:35Z&st=2020-04-29T19:13:35Z&spr=https&sig=yuCcqF655FZ5rOu4aIDjPlLskl%2F5%2BJClOQrzvSd8c%2FI%3D"
}
elseif($rgLocation -like "westus2")
{
    $srcUrl = "https://synapse400westus2.blob.core.windows.net/wwi-02?sv=2019-10-10&ss=b&srt=sco&sp=rl&se=2021-01-02T04:15:39Z&st=2020-04-29T19:15:39Z&spr=https&sig=%2BtcDkuKYuA7omgwoNVtTB0bgiFS1Qy9xfdWeMlM5zZs%3D"
    $srcContext = New-AzStorageContext -StorageAccountName "synapse400westus2" -SasToken "?sv=2019-10-10&ss=b&srt=sco&sp=rl&se=2021-01-02T04:15:39Z&st=2020-04-29T19:15:39Z&spr=https&sig=%2BtcDkuKYuA7omgwoNVtTB0bgiFS1Qy9xfdWeMlM5zZs%3D"
}
else # Check for NorthEurope
{
    $srcUrl = "https://synapse400northeurope.blob.core.windows.net/wwi-02?sv=2019-10-10&ss=b&srt=sco&sp=rl&se=2021-01-02T04:16:29Z&st=2020-04-29T19:16:29Z&spr=https&sig=lpGzyrrE%2B60DWTO1y4gAWL5I0m3c5IcKofOE9tn8RFs%3D"
    $srcContext = New-AzStorageContext -StorageAccountName "synapse400northeurope" -SasToken "?sv=2019-10-10&ss=b&srt=sco&sp=rl&se=2021-01-02T04:16:29Z&st=2020-04-29T19:16:29Z&spr=https&sig=lpGzyrrE%2B60DWTO1y4gAWL5I0m3c5IcKofOE9tn8RFs%3D"
}
           
            
$destContext = $storage.Context
$containerName = "wwi-02"
$resources = $null
#$resources = Get-AzStorageBlob -Context $srcContext -Container $containerName | Where-Object { $_.Length -ne 0 } | Where-Object { $_.BlobType -ne "PageBlob" }
#$resources.Count

New-AzStorageContainer -Context $destContext -Name $containerName -ErrorAction Ignore

#foreach($resource in $resources)
#{
#    $resourceName = $resource.Name

#    $destBlob = $null
#    $destBlob = Get-AzStorageBlob -Context $destContext -Container $containerName -Blob $resourceName -ErrorAction Ignore
#    if (($destBlob -eq $null) -or ($destBlob.Length -ne $resource.Length))
#    {
#        #$resourceName
#        Start-AzStorageBlobCopy -SrcBlob $resourceName -DestBlob $resource.Name -SrcContainer $containerName -DestContainer $containerName -Context $srcContext -DestContext $destContext -Force
#        $copyState = ""
#        while ($copyState -ne "Success")
#        {
#            $stateObj = Get-AzStorageBlobCopyState -Blob $resourceName -Container $containerName -Context $destContext
#            $copyState= $stateObj.Status
#            #$stateObj
#            sleep -Seconds 1
#        }
#    }
#}

$startTime = Get-Date
$endTime = $startTime.AddDays(2)
$destSASToken = New-AzStorageContainerSASToken  -Context $destContext -Container "wwi-02" -Permission rwd -StartTime $startTime -ExpiryTime $endTime
$destUrl = $destContext.BlobEndPoint + "wwi-02" + $destSASToken

C:\LabFiles\azcopy.exe copy $srcUrl $destUrl --recursive

Logout-AzAccount | Out-Null
