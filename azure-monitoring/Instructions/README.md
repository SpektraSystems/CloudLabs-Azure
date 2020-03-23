# Azure Monitoring Workshop

   <img src="images/architecture.jpg"/><br/>

## Contents
* Challenge 1: Monitoring and Alert Rule<br/>
* Challenge 2: Monitoring and Alert Rule Automation<br/>
* Challenge 3: Azure Monitor for Containers<br/>
* Challenge 4: Application Insights<br/>
* Challenge 5: Log Analytics Query<br/>
* Challenge 6: Dashboard and Analytics<br/>
* Challenge 6a: Workbooks

## Workshop Setup
* Deploy Infra using Bash Cloud Shell and Azure CLI with an ARM Template<br/>
* Setup Azure CLI<br/>
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest<br/>
* Install Visual Studio Code and Extensions (depending on your tool of choice)<br/>
* Azure Resource Manager Tools - https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools<br/>
* Azure Account and Sign-In (adds the Azure Cloud Shell for Bash) - https://marketplace.visualstudio.com/items?itemName=ms-vscode.azure-account
Azure CLI Tools –
https://marketplace.visualstudio.com/items?itemName=ms-vscode.azurecli<br/>
* Download Azure Monitoring Workshop Setup Guide and follow the instructions to deploy.<br/>
https://github.com/rkuehfus/pre-ready-2019-H1/blob/master/Student/Guides/Deployment%20Setup%20Guide.docx?raw=true<br/>

## Guidance
Biggest issues I have seen when deploying the workshop are around compute quotas, changing the region to one that does not support the Azure Monitor preview, not having contributor role membership to the subscription and local machine issues.  If you run into a student who cannot seem to get her or his computer working with the Azure CLI, have them use the Azure Cloud Shell.  Remember to copy up the ARM template and parameters JSON files before kicking off the deployment.  
I highly recommend your students make sure they have an Azure Subscription they have contributor role access to before day one of the hack.<br/>
