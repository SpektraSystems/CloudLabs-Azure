# Solution 1: Monitoring and Alert Rule

1. Login to **Azure Portal** with your credentials given in environment details.

   <img src="images/new1.jpg"/>
   
2. Open Visual Studio inside your virtual machine and sign in with **Azure Credentials**.

   <img src="images/new2.jpg"/>
   
3. Visual Studio has view called **SQL Server Object Explorer** that can be used to add and delete SQL databases on the SQL server.

   <img src="images/new4.jpg"/>
   
4. Add SQL Server from **SQL Server Object Explorer**

   <img src="images/sqlsrv1.jpg"/>
   
5. Connect to the database server VM (SqlSrv16-xxxxx) make sure to use below username and password to connect your SQL Server Virtual Manchine:

    * Username: **sqladmin**
    * Password: **demopass!123**
 
   <img src="images/new3.jpg"/>
   
6. Once connected create a new database called **tpcc**

   <img src="images/new5.jpg"/>   

7. Add a Performance Counter Metric for:

    * Object: SQLServer:Databases
    * Counter: Active Transactions
    * Instance: tpcc
 
8. First, figure out the correct format for the counter use the run command on the SQL Server in the Azure portal **Run the command**

    ```
    (Get-Counter -ListSet SQLServer:Databases).Paths
    ```
   <img src="images/sqlvm.jpg"/>

9. Once its finished, review the results (scroll up) and copy the output for the `SQLServer:Databases` counter.

    `
    \SQLServer:Databases(*)\Active Transactions
    `

    <img src="images/output.jpg"/>

    Then change it to target just your specific database

    `\SQLServer:Databases(tpcc)\Active Transactions`
    
10. Open CloudShell( from Azure portal ) or navigate to https://shell.azure.com and select bash or Powershell, to send the below guest OS metric to Azure Monitor for the SQL Server.

    <img src="images/1.jpg"/>

11. Next, edit then Run the below command to add the collection of this counter that sends it to Azure Monitor using the Azure monitor data sink for SQL Server.

    > Note: Review PublicConfig.json File: https://github.com/kayodeprinceMS/AzureMonitorHackathon/blob/master/Student/Resources/PublicConfig.json
    Relevant docs: https://docs.microsoft.com/en-us/azure/azure-monitor/platform/diagnostics-extension-windows-install

    ```
    az vm extension set --resource-group myResourceGroup --vm-name myVMname --name IaaSDiagnostics --publisher Microsoft.Azure.Diagnostics --settings PublicConfig.json
    ```
    
   <img src="images/monitor.jpg"/>

12. Once the command shows output, go to metrics and check to make sure you are seeing the new metrics.

   <img src="images/monitor1.jpg"/>

   <img src="images/monitor2.jpg"/>

   <img src="images/monitor3.jpg"/>

   > **Tip**: A bunch of OS metrics are configured already under the scale set as a sample.

13. Download and Install HammerDB tool on the Visual Studio VM from below link:
    
    ```
      www.hammerdb.com
    ```

14. From the Visual Studio Server, download the latest version of **HammerDB**.

   <img src="images/hammer.jpg"/>
   

   <img src="images/hammer1.jpg"/>

15. If you get this Security Warning, go to Internet Options and then **Security \ Security Settings \ Downloads \ File download \ Enable**.

   <img src="images/enable.jpg"/>

16. Click OK. Try again & Click Save and Run the warnings.

   <img src="images/run.jpg"/>
   

   <img src="images/run1.jpg"/>

   > **Tip:** If you end up closing HammerDB you have to go to C:\Program Files\HammerDB-3.1 and run the batch file

17. Use **HammerDB** to create transaction load

18. Double click on SQL Server and click OK, and OK on the confirm popup.

   <img src="images/db1.jpg"/>

19. Drill into SQL Server \ TPC-C \ Schema Build and double click on Options. Modify the Build Options for the following:

      * **SQL Server:** Name of your SQL Server
      * **SQL Server ODBC Driver:** SQL Server
      * **Authentication:** SQL Server Authentication
      * **SQL Server User ID:** sqladmin
      * **SQL Server User Password:** demopass!123
      * **SQL Server Database:** tpcc
      * **Number of Warehouses:** 50
      * **Virtual Users to Build Schema:** 50

   <img src="images/challenge1-step-19.jpg"/>

 > **Note:** Setting the last two at 50 should generate enough load to trip a threshold and run long enough for you to graph

20. Double click on **Build** and Click Yes to kick of a load test.

   <img src="images/db3.jpg"/>

21. When the test is running it should like this.

   <img src="images/db4.jpg"/>

   > **TIP:** If you would like to run a second test you must first delete the database you created and recreate it. HammerDB will not run a test against a database that has data in it.  When you run a test is fills the database with a bunch of sample data.

22. Go Back to **Azure portal** and from **Azure Monitor** create a graph for the **SQL Server Active Transactions and Percent CPU** and pin to your Azure Dashboard.

   <img src="images/matrix.jpg"/>

23. Customize the dashboard once pinned it to a Azure Dashboard.
   <img src="images/matrix1.jpg"/>

   <img src="images/matric2.jpg"/>

24. Dashboard should look something like this.

   <img src="images/matrix2.jpg"/>

25. From **Azure Monitor**, create an Action group, to send email to your address

   <img src="images/ag.jpg"/>

   * For creating Action Group, Click on **Add Action Group**
       
   <img src="images/ag1.jpg"/>


26. Give values as shown below and Click **OK**:

   <img src="images/action1.jpg"/>

   <img src="images/action2.jpg"/>

   <img src="images/action3.jpg"/>

27. Create an Alert if Active Transactions goes over 40 on the SQL Server **tpcc** database.
   <img src="images/alert.jpg"/>

   * Select SQL Server as Resource
   <img src="images/alerts1.jpg"/>

   * Add Conditon if Active Transactions goes over 40 on the SQL Server
   <img src="images/alerts2.jpg"/>

   <img src="images/alert3.jpg"/>

   * Add Action Group that you created in above steps
   <img src="images/alerts3.jpg"/>

   * Give Alert Details and Click Create Alert Rule

        - Alert Name: **SQL Active Transaction over 40**
   <img src="images/alerts4.jpg"/>

   * You will get the alert email at your email address that you provided for action group
   <img src="images/alert7.jpg"/>


28. Create an another Alert Rule for CPU over **75%** on the **Virtual Scale Set** that emails me when you go over the threshold. First create a dashboard to watch the Scale Set CPU

32. Navigate to the folder called `Loadscripts` under the Resources folder in **Student** and copy the **cpuGenLoadwithPS.ps1** script to both instances running in the Scale Set and run them.

   <img src="images/cpu.jpg"/>


   > This may be a bit of a challenge to those not used to working with a scale set.  If your student just grabs the public IP address and then RDP to it.  They will end up on one of the instances but because they are going through the Load Balancer, they cannot control which one.  Or can they?😊


29. If you look at the configuration of the LB it is configured with an inbound NAT rule that will map starting at port 50000 to each instance in the Scale Set.  So if they RDP using the PIP:50000 for instance 1 and PIP:50001 for instance 2.

   <img src="images/temp0.jpg"/>

* For Example:

   <img src="images/vm.jpg"/>

30. Jump on to both VMs in the Scale Set, Open the PowerShell ISE, Copy the script in the window and run it. You may need to run it more then once to really add the pressure. This script will pin each core on the VM no matter how many you have.

   <img src="images/vm1.jpg"/>

31. The trick to getting the alert to fire is to pin both instances at the same time as the CPU metric is an aggregate of the scale set. If you just max the CPU on one server to 100% the Scale Set is only at 50% and till not trip the alert threshold of 75%. Also, if they run the script and then setup the Alert Rule then to back to run another test to trip the alert, they have scaled out to a third instance and not realized it. They may need to jump on that box and max it out as well.
