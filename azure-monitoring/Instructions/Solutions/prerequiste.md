Prerequisite 

1. Open azure portal then go to cloud shell and follow the steps:<br/>
<img src="images/1.jpg"/><br/>
<img src="images/2.jpg"/><br/>
<img src="images/3.jpg"/><br/>
<img src="images/4.jpg"/><br/>
2. Run below commands for connecting to cluster using below command:<br/>
``
az aks get-credentials --name 170531aksdemo --resource-group ODL-monitor-170531
``
Replace the 170531aksdemo and ODL-monitor-170531 with your resource group and aks cluster name<br/>
``
kubectl get nodes 
``
<img src="images/5.jpg"/><br/>
4. Navigate to https://github.com/kayodeprinceMS/AzureMonitorHackathon and download the repository as a zip file to your local disk<br/>
<img src="images/downlaods.jpg"/><br/>
5. **Unzip** the contents to a local folder on your machine<br/>
   <img src="images/downlaods1.jpg"/><br/>
6. Navigate to the location where you unzipped the files and open the **.\AzureMonitorHackathon-master\Student\Resources** folder in Visual Studio or Visual Studio code<br/>
7. Once you download the repository, upload **PublicConfig.json** and **LogReaderRBAC.yaml** files which are under Resources folder cloud shell:<br/>
<img src="images/6.jpg"/><br/>
8. Deploy the cluster role bindings<br/>
``
kubectl create -f LogReaderRBAC.yaml
``
<img src="images/7.jpg"/><br/>
9. Run below command to host the web app to aks cluster:<br/>
```
mkdir ~/clouddrive/source/ReadyAzureMonitoringWorkshop -p
cd ~/clouddrive/source/ReadyAzureMonitoringWorkshop
git clone https://github.com/rkuehfus/pre-ready-2019-H1.git
code .
```
<img src="images/8.jpg"/><br/>
