## Challenge 3: Azure Monitor for Containers

1. From your Visual Studio Server, deploy the eShoponWeb application to AKS using Dev Spaces<br/>
**Hint:** https://docs.microsoft.com/en-us/azure/dev-spaces/get-started-netcore-visualstudio<br/>
2. Make sure that Http Application Routing is enabled.<br/>
**Note:**
- To enable Http Application Routing on an existing cluster, use the command: az aks enable-addons -n {cluster_name} -g {rg_name} --addons http_application_routing<br/>
```
az aks enable-addons -n 169844aksdemo -g ODL-monitor-169844 --addons http_application_routing
```
   <img src="images/aks.jpg"/><br/>
3. Connect to your Visual Studio Server.<br/>
4. Navigate to **c:\eshoponweb\eShopOnWeb-master**<br/>
   <img src="images/eshop.jpg"/><br/>
5. Double-click on **eShopOnWeb.sln** solution file and select Visual Studio 2019 when prompted.<br/>
6. Sign in to **Visual Studio**<br/>
7. Once Visual Studio opens and settles down. Change the project over to **Web** and select **Azure Dev Spaces**.<br/>
   <img src="images/1.jpg"/><br/>
8. The Azure Dev Spaces login screen will appear. Make sure to select your **Subscription** and **Azure Kubernetes Service** cluster that was created during the setup.<br/>
   <img src="images/eshop2.jpg"/><br/>
9. It’s important you check off the **Publicly Accessible** checkbox.<br/>
10. Click **OK**.<br/>
   <img src="images/eshop1.jpg"/><br/>
11. Click **OK**.<br/>
   <img src="images/eshop3.jpg"/><br/>
12. Click in the lower left to see the progress.<br/>
   <img src="images/eshop4.jpg"/><br/>
13. Don’t worry about seeing the message about the unreachable code.<br/>
   <img src="images/eshop5.jpg"/><br/>
**Note:** The initial creation of the container takes a while.<br/>
14. When its complete Visual Studio will open the URL for you in the default browser.<br/>
15. Copy the URL and test it from your local machine.<br/>
   <img src="images/eshop7.jpg"/><br/>
**Note:** The URL can also be found in the Output section if you scroll up.<br/>
17. You can stop the project running in **Visual Studio (Shift+F5)**. The container will stay deployed.<br/>
18. From Azure Monitor, locate the container running the eShoponWeb application<br/>
   <img src="images/eshop8.jpg"/><br/>
19. From the **Kubernetes** service you created click on **Insights** or you can navigate to Azure Monitor, click on Containers, and select your cluster. Or generate an exception in the eShoponWeb application<br/>
   <img src="images/eshop9.jpg"/><br/>
 **OR**<br/>
   <img src="images/eshop10.jpg"/><br/>
(Hint: Try to change your password)<br/>
20. **Login** into your webapp. Enter the user and password provided on the page.<br/>
   <img src="images/eshop11.jpg"/><br/>
21. Click on **My account**<br/>
   <img src="images/eshop12.jpg"/><br/>
22. Click on **Password**<br/>
   <img src="images/eshop13.jpg"/><br/>
``Notice an exception is thrown``<br/>
23. Frome Azure go to **Kubernetes Service**, under **Insight** Click on the **Web** container and View container live logs.<br/>
   <img src="images/eshop14.jpg"/><br/>
24. Trip the password exception again once the **Status** has gone from **Unk** to **Ok****.<br/>
   <img src="images/eshop15.jpg"/><br/>
25. First person to send me a screen shot of the live log with the exception message wins the challenge
   <img src="images/eshop17.jpg"/><br/>
