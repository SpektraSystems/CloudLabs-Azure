# Challenge 4: Application Insights 

**Note:** User Access Administrator role is required to complete the Container Insights Challenge<br/>
1. In Visual Studio, Install the Application Insights SDK in the eShopOnWeb Web Project in the Solution<br/>
2. From the Visual Studio Server, navigate to **C:\eshoponweb\eShopOnWeb-master** and double-click on eShopOnWeb.sln<br/>
<img src="images/vs.jpg"/><br/>
3. If this is the first time you are opening Visual Studio please log in or create an account and log in.<br/>
4. Select Web<br/>
<img src="images/11.jpg"/><br/>
5. Right-click on **Web** in **Solutions Explorer** and select properties. Under Debug unselect the checkbox for **Enable SSL**.<br/>
 <img src="images/21.jpg"/><br/>
6. Click Save<br/>
7. Click on **IIS Express** to test the eShopOnWeb application<br/>
<img src="images/vs21.jpg"/><br/>
8. You should see the **eShop** app open locally. Close it and let’s add the **Application Insights SDK**<br/>
<img src="images/vs4.jpg"/><br/>
9. Stop the app and add the updated **Application Insights NuGet package** with latest version<br/>
``
Note: Make sure to only at this package. Do not update everything.
``
10. Go to **Tools**, **NuGet Package Manager**, **Manage NuGet Packages for Solution**<br/>
<img src="images/vs12.jpg"/><br/>
11. Check off the **Microsoft.ApplicationInsights** package and click **Install**<br/>
<img src="images/vs13.jpg"/><br/>
12. Click **OK**<br/>
<img src="images/vs131.jpg"/><br/>
13. Click **I Accept**. When finished run the **eShopOnWeb** application again to make sure it’s working<br/>
<img src="images/vs132.jpg"/><br/>
14. On the right hand side, find Web and right click, go to **Add** and select **Application Insights Telemetry**<br/>
<img src="images/vs5.jpg"/><br/>
15. Configure dependency as **Azure Application Insight** and click **Next**<br/>
<img src="images/vs61.jpg"/><br/>
16. Select your **subscription**, **Resource** (name of your App Insights) and click **Next**<br/>
<img src="images/vs71.jpg"/><br/>
17. Configure Azure Application Insight and Click **Next**.<br/>
<img src="images/vs81.jpg"/><br/>
18. Click on Finish to Run the **eShopOnWeb** Web project and check out the App Insights tooling<br/>
<img src="images/91.jpg"/><br/>
<img src="images/101.jpg"/><br/>
19. Test the application by running it and verify it’s working.<br/>
<img src="images/111.jpg"/><br/>
20. While its running you can navigate to Application Insights and view the telemetry while you are interacting with eShop running on the local machine. Add something to the shopping cart, log in and check out.<br/>
21. Publish eShopOnWeb Web project to AKS<br/>
22. Change over to **Azure Dev Spaces** from **IIS Express** and run the **Web project (F5)**<br/>
<img src="images/1.jpg"/><br/>
23. You can always edit some text in the site to verify that indeed the container is being update. Make sure when you run the project the browser is pointing to your URL for the container not the local host. You may need to stop it again, save the project and run it again if this happens<br/>
24. Generate some load and check out the results<br/>
25. From your laptop or the Visual Studio Server copy the code in the **LoadScripts** folder and modify it to your URL<br/>
```
for ($i = 0 ; $i -lt 100; $i++)
{
Invoke-WebRequest -uri http:// mon19webscalesetlb.eastus.cloudapp.azure.com/
}
```
26. Run the code to generate some load on your **eShopOnWeb** site<br/>
<img src="images/vs16.jpg"/><br/>
27. To trip the exception:
* Open your **eShop** site in your browser and **login** to the site<br/>
<img src="images/vs17.jpg"/><br/>
* Try to change your **password**<br/>
<img src="images/vs18.jpg"/><br/>
<img src="images/vs19.jpg"/><br/>
* Find the exception in **App Insights**<br/>
<img src="images/vs20.jpg"/><br/>
<img src="images/vs21.jpg"/><br/>
28. Create **Alerts** based on Availability and exceptions in azure Monitor.<br/>
Create Alert Rule **Server Exceptions count over 0**.<br/>
<img src="images/vs22.jpg"/><br/>
29. First Team to email me an alert of the exception and a screenshot with your scaleset scale out based on the App Insights metric wins the challenge. Good luck
