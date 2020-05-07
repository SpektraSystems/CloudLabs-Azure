CD C:\

Remove-Item C:\azure-synapse-analytics-workshop-400-master.zip -Force
Remove-Item C:\LabFiles\L400Setup -Force -Recurse
New-Item -ItemType Directory -Force -Path C:\LabFiles\L400Setup

$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile("https://github.com/SollianceNet/azure-synapse-analytics-workshop-400/archive/master.zip","C:\azure-synapse-analytics-workshop-400-master-2.zip")

#unziping folder
function Expand-ZIPFile($file, $destination)
{
  $shell = new-object -com shell.application
  $zip = $shell.NameSpace($file)
  foreach($item in $zip.items())
  {
    $shell.Namespace($destination).copyhere($item)
  }
}
Expand-ZIPFile -File "C:\azure-synapse-analytics-workshop-400-master-2.zip" -Destination "C:\LabFiles\L400Setup"
CD C:\LabFiles\L400Setup\azure-synapse-analytics-workshop-400-master
