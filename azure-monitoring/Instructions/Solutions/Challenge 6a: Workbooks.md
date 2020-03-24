## Challenge 6a: Workbooks

Workbook documentation is available here: https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks<br/>
1. Navigate to your **Application Insights** resource in the Azure Portal<br/>
2. Click on Workbooks **New**<br/>
      <img src="images/book.jpg"/><br/>
3. Click **Edit** in the New Workbook section to describe the upcoming content in the workbook. Text is edited using Markdown syntax.<br/>
      <img src="images/book2.jpg"/><br/>
4. Use **Add text** to describe the upcoming table<br/>
      <img src="images/book3.jpg"/><br/>
5. Use **Add parameters** to create the time selector<br/>
      <img src="images/book1.jpg"/><br/>
6. Use **Add query** to retrieve data from pageViews<br/>
      <img src="images/book4.jpg"/><br/>
7. Use **Column** Settings to change labels of column headers and use Bar and Threshold visualizations.
 * Query used for section Browser Statistics
```
pageViews
| summarize pageSamples = count(itemCount), pageTimeAvg = avg(duration), pageTimeMax = max(duration) by name
| sort by pageSamples desc
```
 * Query used for Request Failures
```
requests
| where success == false
| summarize total_count=sum(itemCount), pageDurationAvg=avg(duration) by name, resultCode
```
8. Use **Add Metric** to create a metric chart<br/>
      <img src="images/book5.jpg"/><br/>
9. Change your Resource Type to **Virtual Machine** and check all **aks** virtual machine<br/>
      <img src="images/book6.jpg"/><br/>
      <img src="images/book7.jpg"/><br/>
10. Change the Resource Type to **Log Analytics**<br/>
      <img src="images/book8.jpg"/><br/>
11. Change your workspace to the **Log Analytics workspace** with your AKS container logs<br/>
      <img src="images/book9.jpg"/><br/>
 * Query used for section Disk Used Percentage<br/>
```
InsightsMetrics
| where Namespace == "container.azm.ms/disk" 
| where Name == "used_percent"
| project TimeGenerated, Computer, Val 
| summarize avg(Val) by Computer, bin(TimeGenerated, 1m)
| render timechart
```
12. **Save** your workbook<br/>
