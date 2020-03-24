# Monitoring and Alert Rule Challenge	

1. Create an empty database called “tpcc” on the SQL ServerNote: Use SQL Auth with the username being sqladmin and password being whatever you used during deployment<br/>
2. Using AZ CLI, Powershell or ARM template, send the below guest OS metric to Azure Monitor for the SQL Server<br/>
3. Add a Performance Counter Metric for<br/>
  * Object: SQLServer:Databases<br/>
  * Counter: Active Transactions<br/>
  * Instance:tpcc<br/>
   * Hint: https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/metrics-store-custom-guestos-resource-manager-vm<br/>
3. Download and Install HammerDB tool on the Visual Studio VM (instructions are in your Student\Guides\Day-1 folder for setting up and using Hammerdb.<br/>
  * www.hammerdb.com<br/>
4. Use HammerDB to create transaction load<br/>
5. From Azure Monitor, create a graph for the SQL Server Active Transactions and Percent CPU and pin to your Azure Dashboard<br/>
6. From Azure Monitor, create an Action group, to send email to your address<br/>
7. Create an Alert if Active Transactions goes over 40 on the SQL Server tpcc database.<br/>
8. Create an Alert Rule for CPU over 75% on the Virtual Scale Set that emails me when you go over the threshold.<br/>
  * Note: In the Student\Resources\Loadscripts folder you will find a CPU load script to use.<br/>
  
#### First team to send me both alerts wins the challenge!! Good luck!

Solution : [Challenge 1: Monitoring and Alert Rule](https://github.com/SpektraSystems/CloudLabs-Azure/tree/master/azure-monitoring/Instructions/Challenge%201:%20Monitoring%20and%20Alert%20Rule.md)
