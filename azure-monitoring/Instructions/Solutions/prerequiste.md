# Pre-requisites

1. Open a browser on the provided VM and Navigate to Azure Portal( https://portal.azure.com ) and login with the credentials provided under Azure Crendentials on Environment Details tab on the right.
 
    <img src="images/i1.jpg"/>
 
    Then launch the CloudShell by clicking on the icon next to the search bar at the top of the Azure portal and Select Bash when the prompt comes up.
 
    Select Show advanced settings and proceed as shown in the below images:
 
    <img src="images/2.jpg"/>
 
 
    <img src="images/3.jpg"/>
 
2. Run below commands for connecting to cluster using below command:
 

    ```
    az aks get-credentials --name 170531aksdemo --resource-group ODL-monitor-170531
    ```

    > Replace the 170531aksdemo and ODL-monitor-170531 with your resource group and aks cluster name
 

    ```
    kubectl get nodes
    ```

    <img src="images/5.jpg"/>
 

4. Navigate to https://github.com/kayodeprinceMS/AzureMonitorHackathon and download the repository as a zip file to your local disk
 
    <img src="images/downlaods.jpg"/>
 
5. **Unzip** the contents to a local folder on your machine
 
       <img src="images/downlaods1.jpg"/>
 
6. Navigate to the location where you unzipped the files and open the **.\AzureMonitorHackathon-master\Student\Resources** folder in Visual Studio or Visual Studio code
 
7. Once you download the repository, upload **PublicConfig.json** and **LogReaderRBAC.yaml** files which are under Resources folder cloud shell:
 
    <img src="images/6.jpg"/>
 
8. Deploy the cluster role bindings
 

    ```
    kubectl create -f LogReaderRBAC.yaml
    ```

    <img src="images/7.jpg"/>
 
9. Run below command to host the web app to aks cluster:
 

    ```
    mkdir ~/clouddrive/source/ReadyAzureMonitoringWorkshop -p
    cd ~/clouddrive/source/ReadyAzureMonitoringWorkshop
    git clone https://github.com/rkuehfus/pre-ready-2019-H1.git
    code .
    ```

    <img src="images/8.jpg"/>
 
