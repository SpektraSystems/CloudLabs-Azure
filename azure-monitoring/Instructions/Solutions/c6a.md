## Workbooks

* Create workbook that combines browser, web server and infrastructure performance data for your `eshoponweb` app on the `AKS` cluster including:
   1. Web page performance as observed from the client-side browser using `Page View` records.
     * Visualizations: `Time Selector`, `Table` with columns for `Page Titles`, `Page Views` with `Bar` underneath, `Average Page Time` with `Thresholds` and `Maximum Page time` with `Bar` underneath.
   2. Request failures reported by the web server using `Request` records.
     * Visualization: `Table` with columns for `Request Name`, `HTTP Return Code`, `Failure Count` with `Heatmap` and `Page Time` with Heatmap.
   3. Server response time as observed from the `server-side` using Request metrics.
     * Visualization: `Line Chart` of `Average` and `Max Server Response Time`.
   4. `Infrastructure performance` as observed from the nodes in the `AKS` cluster on which the application is deployed using `Average` and `Maximum CPU` usage metrics.
     * Visualization: `Line Chart` of `Average CPU` usage percentage by AKS cluster node.
   5. Infrastructure performance from `AKS` nodes showing disk used percentage based on `Log Analytics` records.
     * Visualization: `Line Chart` of `Average Disk` used percentage by `AKS` cluster node.
https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks

## Solution: [Challenge 6a: Workbooks](#solution-workbooks)

#### Solution: Workbooks

Workbook documentation is available here: https://docs.microsoft.com/en-us/azure/azure-monitor/app/usage-workbooks
 
1. Navigate to your **Application Insights** resource in the Azure Portal
 
2. Click on Workbooks **New**
 
      <img src="images/book.jpg"/>
 
3. Click **Edit** in the New Workbook section to describe the upcoming content in the workbook. Text is edited using Markdown syntax.
 
      <img src="images/book2.jpg"/>
 
4. Use **Add text** to describe the upcoming table
 
      <img src="images/book3.jpg"/>
 
5. Use **Add parameters** to create the time selector
 
      <img src="images/book1.jpg"/>
 
6. Use **Add query** to retrieve data from pageViews
 
      <img src="images/book4.jpg"/>
 
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

8. Use **Add Metric** to create a metric chart
 
      <img src="images/book5.jpg"/>
 
9. Change your Resource Type to **Virtual Machine** and check all **aks** virtual machine
 
      <img src="images/book6.jpg"/>
 
      <img src="images/book7.jpg"/>
 
10. Change the Resource Type to **Log Analytics**
 
      <img src="images/book8.jpg"/>
 
11. Change your workspace to the **Log Analytics workspace** with your AKS container logs
 
      <img src="images/book9.jpg"/>
 
 * Query used for section Disk Used Percentage
 
    ```
    InsightsMetrics
    | where Namespace == "container.azm.ms/disk" 
    | where Name == "used_percent"
    | project TimeGenerated, Computer, Val 
    | summarize avg(Val) by Computer, bin(TimeGenerated, 1m)
    | render timechart
    ```
    
12. **Save** your workbook with Name myWorkBook
 
