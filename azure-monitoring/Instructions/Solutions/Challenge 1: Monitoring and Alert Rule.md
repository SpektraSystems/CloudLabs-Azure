# Challenge 1: Monitoring and Alert Rule

1. Navigate to https://github.com/kayodeprinceMS/AzureMonitorHackathon and download the **repository** as a zip file to your local disk<br/>
   <img src="images/downlaods.jpg"/><br/>
2. **Unzip** the contents to a local folder on your machine<br/>
   <img src="images/downlaods1.jpg"/><br/>
3. Navigate to the location where you unzipped the files and open the **.\AzureMonitorHackathon-master\Student\Resources** folder in Visual Studio or Visual Studio code<br/>
```
Download Visual Studio Code: https://code.visualstudio.com/download (If you don't have visual studio code and visual studio in you local disk)
```
   <img src="images/downlaods2.jpg"/><br/>
4. Login to **Azure Portal** with your credentials given in environment details.<br/>
   <img src="images/new1.jpg"/><br/>
5. Open Visual Studio inside your virtual machine and sign in with **Azure Credentials**.<br/>
   <img src="images/new2.jpg"/><br/>
6. Visual Studio has view called **SQL Server Object Explorer** that can be used to add and delete SQL databases on the SQL server.<br/>
   <img src="images/new4.jpg"/><br/>
7. Add SQL Server from **SQL Server Object Explorer**<br/>
   <img src="images/sqlsrv1.jpg"/><br/>
8. Connect to the database server VM (xxxxxSqlSrv16) make sure to use below username and password to connect your SQL Server Virtual Manchine:<br/>
 * Username: **sqladmin**<br/>
 * Password: **demopass!123**<br/>
   <img src="images/new3.jpg"/><br/>
9. Once connected create a new database called **tpcc**<br/>
   <img src="images/new5.jpg"/><br/>
10. Using Azure CLI or Powershell, send the below guest OS metric to Azure Monitor for the SQL Server.<br/>
11. Add a Performance Counter Metric for:<br/>
 * Object: SQLServer:Databases<br/>
 * Counter: Active Transactions<br/>
 * Instance: tpcc<br/>
12. First, figure out the correct format for the counter use the run command on the SQL Server in the Azure portal<br/>
**Run the command**<br/>
```
(Get-Counter -ListSet SQLServer:Databases).Paths
```
   <img src="images/sqlvm.jpg"/><br/>
13. Once its finished, review the results (scroll up) and copy the output for the `SQLServer:Databases` counter.<br/>
`
\SQLServer:Databases(*)\Active Transactions
`

   <img src="images/output.jpg"/><br/>
Then change it to target just your specific database<br/>
`\SQLServer:Databases(tpcc)\Active Transactions`<br/>
14. Next, edit then Run the below command to add the collection of this counter that sends it to Azure Monitor using the Azure monitor data sink for SQL Server.<br/>
```
Review PublicConfig.json File: https://github.com/kayodeprinceMS/AzureMonitorHackathon/blob/master/Student/Resources/PublicConfig.json
Relevant docs: https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostics-extension-windows-install
```
```
az vm extension set --resource-group myResourceGroup --vm-name myVMname --name IaaSDiagnostics --publisher Microsoft.Azure.Diagnostics --settings PublicConfig.json
```
   <img src="images/monitor.jpg"/><br/>
15. Once the command shows output, go to metrics and check to make sure you are seeing the new metrics.<br/>
   <img src="images/monitor1.jpg"/><br/>
   <img src="images/monitor2.jpg"/><br/>
   <img src="images/monitor3.jpg"/><br/>
**Tip**: A bunch of OS metrics are configured already under the scale set as a sample.<br/>
16. Download and Install HammerDB tool on the Visual Studio VM from below link:<br/>
www.hammerdb.com<br/>
17. From the Visual Studio Server, download the latest version of **HammerDB**.<br/>
   <img src="images/hammer.jpg"/><br/>
   <img src="images/hammer1.jpg"/><br/>
18. If you get this Security Warning, go to Internet Options and then **Security \ Security Settings \ Downloads \ File download \ Enable**.<br/>
   <img src="images/enable.jpg"/><br/>
19. Click OK. Try again & Click Save and Run the warnings.<br/>
   <img src="images/run.jpg"/><br/>
   <img src="images/run1.jpg"/><br/>
**Tip:** If you end up closing HammerDB you have to go to C:\Program Files\HammerDB-3.1 and run the batch file<br/>
20. Use **HammerDB** to create transaction load<br/>
21. Double click on SQL Server and click OK, and OK on the confirm popup.
   <img src="images/db1.jpg"/><br/>
22. Drill into SQL Server \ TPC-C \ Schema Build and double click on Options. Modify the Build Options for the following:<br/>
* **SQL Server:** Name of your SQL Server<br/>
* **SQL Server ODBC Driver:** SQL Server<br/>
* **Authentication:** SQL Server Authentication<br/>
* **SQL Server User ID:** sqladmin<br/>
* **SQL Server User Password:** demopass!123<br/>
* **SQL Server Database:** tpcc<br/>
* **Number of Warehouses:** 50<br/>
* **Virtual Users to Build Schema:** 50<br/>

<img src="images/db2.jpg"/><br/>
**Note:** Setting the last two at 50 should generate enough load to trip a threshold and run long enough for you to graph<br/>
23. Double click on **Build** and Click Yes to kick of a load test.<br/>
   <img src="images/db3.jpg"/><br/>
24. When the test is running it should like this.<br/>
   <img src="images/db4.jpg"/><br/>
**TIP:** If you would like to run a second test you must first delete the database you created and recreate it. HammerDB will not run a test against a database that has data in it.  When you run a test is fills the database with a bunch of sample data.<br/>
25. Go Back to **Azure portal** and from **Azure Monitor** create a graph for the **SQL Server Active Transactions and Percent CPU** and pin to your Azure Dashboard.<br/>
   <img src="images/matrix.jpg"/><br/>
26. Customize the dashboard once pinned it to a Azure Dashboard.
   <img src="images/matrix1.jpg"/><br/>
   <img src="images/matric2.jpg"/><br/>
27. Dashboard should look something like this.<br/>
   <img src="images/matrix2.jpg"/><br/>
28. From **Azure Monitor**, create an Action group, to send email to your address<br/>
   <img src="images/ag.jpg"/><br/>
  * For creating Action Group, Click on **Add Action Group**<br/>
   <img src="images/ag1.jpg"/><br/>

29. Give values as shown below and Click **OK**:<br/>
   <img src="images/action1.jpg"/><br/>
   <img src="images/action2.jpg"/><br/>
   <img src="images/action3.jpg"/><br/>
30. Create an Alert if Active Transactions goes over 40 on the SQL Server **tpcc** database.<br/>
   <img src="images/alert.jpg"/><br/>
  * Select SQL Server as Resource<br/>
   <img src="images/alerts1.jpg"/><br/>
  * Add Conditon if Active Transactions goes over 40 on the SQL Server<br/>
   <img src="images/alerts2.jpg"/><br/>
   <img src="images/alert3.jpg"/><br/>
  * Add Action Group that you created in above steps<br/>
   <img src="images/alerts3.jpg"/><br/>
  * Give Alert Details and Click Create Alert Rule<br/>
  - Alert Name: **SQL Active Transaction over 40**
   <img src="images/alerts4.jpg"/><br/>
  * You will get the alert email at your email address that you provided for action group<br/>
   <img src="images/alert7.jpg"/><br/>

31. Create an another Alert Rule for CPU over **75%** on the **Virtual Scale Set** that emails me when you go over the threshold. First create a dashboard to watch the Scale Set CPU<br/>
32. Navigate to the folder called `Loadscripts` under the Resources folder in **Student** and copy the **cpuGenLoadwithPS.ps1** script to both instances running in the Scale Set and run them.<br/>
   <img src="images/cpu.jpg"/><br/>
``
This may be a bit of a challenge to those not used to working with a scale set.  If your student just grabs the public IP address and then RDP to it.  They will end up on one of the instances but because they are going through the Load Balancer, they cannot control which one.  Or can they?😊
``<br/>
33. If you look at the configuration of the LB it is configured with an inbound NAT rule that will map starting at port 50000 to each instance in the Scale Set.  So if they RDP using the PIP:50000 for instance 1 and PIP:50001 for instance 2.<br/>
   <img src="images/temp0.jpg"/><br/>
* For Example:<br/>
   <img src="images/vm.jpg"/><br/>
34. Jump on to both VMs in the Scale Set, Open the PowerShell ISE, Copy the script in the window and run it. You may need to run it more then once to really add the pressure. This script will pin each core on the VM no matter how many you have.<br/>
   <img src="images/vm1.jpg"/><br/>
35. The trick to getting the alert to fire is to pin both instances at the same time as the CPU metric is an aggregate of the scale set. If you just max the CPU on one server to 100% the Scale Set is only at 50% and till not trip the alert threshold of 75%. Also, if they run the script and then setup the Alert Rule then to back to run another test to trip the alert, they have scaled out to a third instance and not realized it. They may need to jump on that box and max it out as well.<br/>
* First team to send me both alerts wins the challenge!!<br/>
* Good luck!
