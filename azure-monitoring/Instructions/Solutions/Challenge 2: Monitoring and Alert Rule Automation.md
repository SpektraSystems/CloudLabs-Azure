# Challenge 2: Monitoring and Alert Rule Automation

1. Update the parameters file and deployment script for the **GenerateAlertRules.json** template located in the **AlertTemplates** folder<br/>
<img src="images/temp.jpg"/><br/>
2. Add the names of your **VMs** and **ResouceId** for your Action Group<br/>
3. To find the **ResourceId** for your Action group navigate to the **Resource Group** where you are stored the action group and make sure to check off **Show hidden types**<br/>
<img src="images/temp1.jpg"/><br/>
4. Click on your Action Group and copy the **ResourceId**<br/>
<img src="images/temp2.jpg"/><br/>
5. Then update the **deployAlertRules.parameters.json** file as it shows below<br/>
<img src="images/temp3.jpg"/><br/>
6. Save the parameters file and update the **deployAlertRulesTemplate.ps1** file with the name of your **Resource Group** (and save it).<br/>
7. Deploy the **GenerateAlertRules.json** template using the **PowerShell** script given below:(deployAlertRulesTemplate.ps1).<br/>
<img src="images/temp4.jpg"/><br/>
8. Verify you have new **Monitor Alert Rules** in the Portal or from the command line (sample command is in the deployment script)<br/>
<img src="images/temp5.jpg"/><br/>
9. Modify the **GenerateAlertsRules.json** to include “Disk Write Operations/Sec” and set a threshold of 10<br/>
**Tip:** Go here to view the list of metrics available by resource type - https://docs.microsoft.com/en-us/azure/monitoring-and-diagnostics/monitoring-supported-metrics#microsoftcomputevirtualmachines

**Use this link to see the ARM schema-** https://docs.microsoft.com/en-us/rest/api/monitor/metricalerts/update

<img src="images/temp7.jpg"/><br/>
10. Rerun your template and verify your new Alert Rules are created for each of your VMs.<br/>
<img src="images/temp6.jpg"/><br/>
11. Create a new **Action Rule** that suppress alerts from the scale set and virtual machines on **Saturday** and **Sunday**.<br/>
12. In Azure Monitor, Click on Manage actions under Alert<br/>
<img src="images/ag.jpg"/><br/>
13. Navigate to Action rules (preview)<br/>
<img src="images/ag5.jpg"/><br/>
<img src="images/ag6.jpg"/><br/>
14. Under Scope, click on Select a resource and make sure you have your subscription selected. Then search for the name of the resource group that was created in the deployment of the workshop. Select your resource group when it comes up. Click **Done**<br/>
<img src="images/ag4.jpg"/><br/>
15. Under Filter Criteria, click on filters and select Resource type **Equals** Virtual Machines and Virtual Machine scales sets.<br/>
<img src="images/ag7.jpg"/><br/>
16. Under **Suppression Config**, click on **Configure Suppression** and configure the screen like the screen shot below.<br/>
<img src="images/ag8.jpg"/><br/>
17. Add an Action Rule Name and Description, check off enable action Rule.<br/>
<img src="images/ag9.jpg"/><br/>
18. First team to me a screenshot of the new Alert Rules and New Action Rule wins the challenge!!<br/>
19. Good luck!
