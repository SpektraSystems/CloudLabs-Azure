# Challenge 6: Dashboard and Analytics

* Deploy Grafana using Web App for Container
https://github.com/grafana/azure-monitor-datasource/blob/master/README.md
* Hint: http://docs.grafana.org/installation/docker/

1. Create a Web App for Linux and configure as recommended below:<br/>
<img src="images/web.jpg"/><br/>
* Create a new App service plan and select B1 Basic. It’s under Dev/Test<br/>
<img src="images/web1.jpg"/><br/>
* Select Container and specify Docker Hub, Public and Grafana/Grafana for the image tags (this should deploy the latest version by default)<br/>
<img src="images/web3.jpg"/><br/>
* Should look like this when complete:<br/>
<img src="images/web4.jpg"/><br/>
* Click Create<br/>

2. After the Web App deploys, we need to configure some settings to enable Azure Monitor Plugin<br/>
3. From the Azure Portal navigate to your newly created App Service, Configurstions, Application Settings<br/>
4. Under **Always On**, change the value to On.<br/>
<img src="images/app.jpg"/><br/>
5. Under **Application Settings**, click on **Show Values**<br/>
<img src="images/app1.jpg"/><br/>
6. Change the value for **WEBSITES_ENABLE_APP_SERVICE_STORAGE** to true (from false)<br/>
<img src="images/app2.jpg"/><br/>
7. Click **Add** new Setting and add the following:<br/>
<img src="images/app3.jpg"/><br/>
<img src="images/app4.jpg"/><br/>
8. Click **Save**<br/>
<img src="images/app5.jpg"/><br/>
``
Note: For the Application settings to take effect you may need to restart your Web App
``
9. To **Login** to Grafana<br/>
10. Click on **Overview** and copy the **URL** for your Web App<br/>
<img src="images/app6.jpg"/><br/>
11. Navigate to the URL in your browser. The username is **admin** lowercase and the password is whatever you configured in Application Settings. Notice the version of Grafana as you need 5.2.0 or newer if you are querying **Azure Log Analytics**<br/>
<img src="images/app7.jpg"/><br/>
12. Once logged into **Grafana** you should notice Azure Monitor is installed<br/>
13. Configure the **Azure Monitor Data Source** for Azure Monitor, Log Analytics and Application Insights<br/>
<img src="images/app8.jpg"/><br/>
14. Configure Azure Monitor data source<br/>
<img src="images/app9.jpg"/><br/>
15. Fill out the Azure Monitor API Details<br/>
<img src="images/app10.jpg"/><br/>
16. From your Environment Details copy the **Tenant Id**, **Application/Client Id**, **Application Secret Key** properties to find the Directory ID<br/>
<img src="images/app11.jpg"/><br/>
18. Click **Save & Test** and you should see a message like below.<br/>
<img src="images/app12.jpg"/><br/>
19. To configure **Application Insights**, find your **API Id** and generate a key<br/>
<img src="images/app13.jpg"/><br/>
20. Copy the **Application ID** and paste in Grafana. Click on **Create API Key**<br/>
<img src="images/app14.jpg"/><br/>
<img src="images/app15.jpg"/><br/>
21. Copy the key and paste in the **Grafana Application Insights Details**. **Note:** You cannot retrieve this key again.<br/>
<img src="images/app16.jpg"/><br/>
22. Click **Save & Test**. Should like this now.<br/>
23. Create a **CPU Chart** with a Grafana variable used to select Computer Name<br/>
24. Create a new dashboard.<br/>
<img src="images/app17.jpg"/><br/>
25. Add **Graph**<br/>
<img src="images/app18.jpg"/><br/>
<img src="images/app19.jpg"/><br/>
26. Edit the **Panel Title**<br/>
<img src="images/app21.jpg"/><br/>
27. Under General change to the name to something like **Computer CPU**.<br/>
<img src="images/app20.jpg"/><br/>
28. Under Metrics, make sure service is Azure Log Analytics, your workspace is selected, and build out a Log Analytics query (answer query below for your reference).<br/>
Sample query:
```
Perf
| where $__timeFilter(TimeGenerated)
| where CounterName == "% Processor Time" and InstanceName == "_Total"
| summarize percentile(CounterValue,50) by bin(TimeGenerated, $__interval), Computer
| order by TimeGenerated asc
```

<img src="images/grfa17.jpg"/><br/>
29. Click **Run** to test<br/>
30. Now let’s make a few changes. Click on **Axes** and change the Unit to percent and **Y-Max** to 100. Run it <br/>
<img src="images/grfa16.jpg"/><br/>
31. Let’s save it by click on the disk in the upper right side.<br/>
<img src="images/grfa13.jpg"/><br/>
<img src="images/grfa12.jpg"/><br/>
32. Should look something like this:<br/>
<img src="images/grfa11.jpg"/><br/>

 #### Advanced features:
 
* Variables<br/>
* Some query values can be selected through **UI** dropdowns, and updated in the query.<br/>
* For example, a **Computer** variable can be defined, and then a dropdown will appear on the dashboard, showing a list of possible values:<br/>
<img src="images/grfa10.jpg"/><br/>
* Now let’s add a variable that lets us select computers in the chart. Click on the gear in the upper right corner.<br/>
<img src="images/grfa9.jpg"/><br/>
* Click on **Add** Variable<br/>
<img src="images/grfa8.jpg"/><br/>
33. Configure the **Variable** to look like the screen below.<br/>
<img src="images/grfa7.jpg"/><br/>
``
Note: In my case I make sure to specify the Workspace name as I have many workspaces and wanted to make sure we only returned values that would work in our chart. Click Add
``
34. Make sure to **Save** your dashboard<br/>
<img src="images/grfa5.jpg"/><br/>
35. Now go back and edit your **Computer CPU** chart to update the query to use the new variable.<br/>
<img src="images/grfa4.jpg"/><br/>
36. Sample update Computer CPU query to support variable **$ComputerName**<br/>
```
Perf
| where $__timeFilter(TimeGenerated) and Computer in ($ComputerName)
| where (CounterName == "% Processor Time" and InstanceName == "_Total") or CounterName == "% Used Memory"
| summarize AVGPROCESSOR = avg(CounterValue) by bin(TimeGenerated, $__interval), Computer
| order by TimeGenerated asc
```

<img src="images/grfa3.jpg"/><br/>
38. Make sure to **Save**<br/>
<img src="images/grfa2.jpg"/><br/>
39. Try it out!<br/>
<img src="images/grfa.jpg"/><br/>
40. Try creating a variable that accepts percentiles (50, 90 and 95).<br/>

 #### Annotations:
 
* Another cool Grafana feature is annotations – which marks points in time that you can overlay on top of charts.<br/>
* Below, you can see the same chart shown above, with an annotation of **Heartbeats**. Hovering on a specific annotation shows informative text about it.<br/>
* **Configuration** is very similar to Variables:<br/>
* Click the dashboard **Settings** button (on the top right area), select **Annotations**, and then **+New**.<br/>
* This page shows up, where you can define the data source (aka “Service”) and query to run in order to get the list of values (in this case a list of computer heartbeats).<br/>
``
Note:** that the output of the query should include a date-time value, a Text field with interesting info (in this case we used the computer name) and possibly tags (here we just used “test”).
``
* Add an Annotation to your chart overlaying Computer Heartbeat<br/>
      <img src="images/grfa1.jpg"/><br/>
* FYI… Annotations provide a way to mark points on the graph with rich events. When you hover over an annotation you can get event description and event tags. The text field can include links to other systems with more detail.<br/>
* Navigate to settings from your dashboard (the gear in the upper right), click on Annotations, Add Annotation Query<br/>
<img src="images/grfa.jpg"/><br/>

**HINT:** Use the sample Kusto/Data explorer queries to create more dashboard scenarios.<br/>`
* First Team to email me a screenshot with your chart wins the challenge. Good luck!
