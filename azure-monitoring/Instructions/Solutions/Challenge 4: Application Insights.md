# Solution 4: Application Insights 

   > **Note:** User Access Administrator role is required to complete the Container Insights Challenge

1. In Visual Studio, Install the Application Insights SDK in the eShopOnWeb Web Project in the Solution

2. From the Visual Studio Server, navigate to **C:\eshoponweb\eShopOnWeb-master** and double-click on eShopOnWeb.sln

    <img src="images/vs.jpg"/>

3. If this is the first time you are opening Visual Studio please log in or create an account and log in.

4. Select Web

    <img src="images/web1.jpg"/>

5. Right-click on **Web** in **Solutions Explorer** and select properties. Under Debug unselect the checkbox for **Enable SSL**.

    <img src="images/21.jpg"/>

6. Click Save

7. Click on **IIS Express** to test the eShopOnWeb application

    <img src="images/vs21.jpg"/>

8. You should see the **eShop** app open locally. Close it and let’s add the **Application Insights SDK**

    <img src="images/vs4.jpg"/>

9. Stop the app and add the updated **Application Insights NuGet package** with latest version

    > **Note**: Make sure to only at this package. Do not update everything.

10. Go to **Tools**, **NuGet Package Manager**, **Manage NuGet Packages for Solution**

    <img src="images/vs12.jpg"/>

11. Check off the **Microsoft.ApplicationInsights** package and click **Install**

    <img src="images/vs13.jpg"/>

12. Click **OK**

    <img src="images/vs131.jpg"/>

13. Click **I Accept**. When finished run the **eShopOnWeb** application again to make sure it’s working

    <img src="images/vs132.jpg"/>

14. On the right hand side, find Web and right click, go to **Add** and select **Application Insights Telemetry**

    <img src="images/vs5.jpg"/>

15. Configure dependency as **Azure Application Insight** and click **Next**

    <img src="images/vs61.jpg"/>

16. Select your **subscription**, **Resource** (name of your App Insights) and click **Next**

    <img src="images/vs71.jpg"/>

17. Configure Azure Application Insight and Click **Next**.

    <img src="images/vs81.jpg"/>

18. Click on Finish to Run the **eShopOnWeb** Web project and check out the App Insights tooling

    <img src="images/91.jpg"/>

    <img src="images/101.jpg"/>

19. Test the application by running it and verify it’s working.

    <img src="images/111.jpg"/>

20. While its running you can navigate to Application Insights and view the telemetry while you are interacting with eShop running on the local machine. Add something to the shopping cart, log in and check out.

21. Publish eShopOnWeb Web project to AKS

22. Change over to **Azure Dev Spaces** from **IIS Express** and run the **Web project (F5)**

    <img src="images/challenge3-step-7.jpg"/>

23. You can always edit some text in the site to verify that indeed the container is being update. Make sure when you run the project the browser is pointing to your URL for the container not the local host. You may need to stop it again, save the project and run it again if this happens

24. Generate some load and check out the results

25. From your laptop or the Visual Studio Server copy the code in the **LoadScripts** folder and modify it to your URL

    ```
    for ($i = 0 ; $i -lt 100; $i++)
    {
    Invoke-WebRequest -uri http:// mon19webscalesetlb.eastus.cloudapp.azure.com/
    }
    ```
26. Run the code to generate some load on your **eShopOnWeb** site

    <img src="images/vs16.jpg"/>

27. To trip the exception:

    * Open your **eShop** site in your browser and **login** to the site

    <img src="images/vs17.jpg"/>

    * Try to change your **password**

    <img src="images/vs18.jpg"/>

    <img src="images/vs19.jpg"/>

    * Find the exception in **App Insights**

    <img src="images/vs201.jpg"/>

    <img src="images/vs202.jpg"/>

28. Create **Alerts** based on Availability and exceptions in azure Monitor. Create Alert Rule **Server Exceptions count over 0**.

    <img src="images/vs22.jpg"/>
