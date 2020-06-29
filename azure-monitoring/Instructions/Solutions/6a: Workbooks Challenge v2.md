# Challenge 6a: Workbooks

> Workbook documentation is available here: https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks

1. Navigate to your Application Insights resource in the Portal.

2. Click on Workbooks New.

<img src="images/book.jpg"/>

3. Click Edit in the New Workbook section to describe the upcoming content in the workbook. Text is edited using Markdown syntax.

<img src="images/workbooksa2.jpg"/>

4. Use Add text to describe the upcoming table.

5. Use Add parameters to create the time selector.

6. Use Add query to retrieve data from pageViews.

7. Use Column Settings to change labels of column headers and use Bar and Threshold visualizations.

<img src="images/workbooksa3.jpg"/>

Query used for section Browser Statistics:

```
pageViews
| summarize pageSamples = count(itemCount), pageTimeAvg = avg(duration), pageTimeMax = max(duration) by name
| sort by pageSamples desc
```

<img src="images/workbooksa4.jpg"/>

Query used for Request Failures
```
requests
| where success == false
| summarize total_count=sum(itemCount), pageDurationAvg=avg(duration) by name, resultCode
```

8. Use Add Metric to create a metric chart.

<img src="images/workbooksa5.jpg"/>

9. Change your Resource Type to Virtual Machine.

<img src="images/workbooksa6.jpg"/>

<img src="images/workbooksa7.jpg"/>

10. Change the Resource Type to Log Analytics.
11. Change your workspace to the LA workspace with your AKS container logs.

<img src="images/workbooksa8.jpg"/>

Query used for section Disk Used Percentage:

```
InsightsMetrics
| where Namespace == "container.azm.ms/disk" 
| where Name == "used_percent"
| project TimeGenerated, Computer, Val 
| summarize avg(Val) by Computer, bin(TimeGenerated, 1m)
| render timechart
```
Save your workbook.
