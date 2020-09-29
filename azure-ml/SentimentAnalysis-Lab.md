# Sentiment Analysis

The purpose of this lab is to show how you can apply in real-time a machine learning
model on streaming data. This use case will apply sentiment analysis on an incoming
stream of Twitter tweets.

## Solution design

The high level solution design of this lab looks like this.

![](images/sentimentanalysis/image--000.png)

• Two Logic Apps are capturing tweets that contain #happy or #sad

• These tweets are ingested into Event Hubs

• Azure Stream Analytics performs the sentiment analysis against an Azure Mache
Learning web service

• Azure Stream Analytics also calculates the average value over a specific time
window

• The results are outputted to Power BI, where they can be easily visualized

## Getting started

Launch the lab and Sign-in to [Azure Portal](portal.azure.com) using the Azure credentials provided in the lab details page. 

Click on Resource groups in the Dashboard to see the resourse groups that you have access. You can see a resource group named *sentiment-analysis-XXXXX*. You will be using this resourse group for this lab.  

## Ingest tweets

### Create an Event Hub

First of all, we need a messaging service that can handle huge amounts of streaming
data. Azure Event Hubs is a great service that offers all features to build a realtime data
ingestion pipeline.

• Sign in to the [Azure portal](https://login.microsoftonline.com/organizations/oauth2/v2.0/authorize?client_id=c44b4083-3bb0-49c1-b47d-974e53cbdf3c&response_type=code%20id_token&scope=https%3A%2F%2Fmanagement.core.windows.net%2F%2Fuser_impersonation%20openid%20email%20profile&state=OpenIdConnect.AuthenticationProperties%3DG-CudUDi8KW-XgKNmi4ZG5wXoDitdjCzpCwqMsrQATL1077wWP4onUPNzPiXTi7Z4C3dQ2aOo16kAtxI7FftyrkiEopsXjs-_cNSJF3QlBF7Pj5xmh_Cb1ZltyN0dQGpZqgAr6_lp2cyeDrOfvRCfXuX75pQgQupLRNbeg4zxQyKDPNOynjvNv-PU8hpY2c0HhSnLsMgm_46exx4kIuSh-jGo0bDn2mdasCZpNmFug6f8xd0KDoTaTsEgW7zEVmZKAfeRk0A2beK4s2rupezfQPcR3y7FQo7RijXveovxESvSWvONQh6LjYlzIdY9bG6XwFzEGJLftP6I83RTow0o5XtABb3yZXmiPr5schm-I5kFEZTetKZrUkWni7y1TMS&response_mode=form_post&nonce=637368226324609634.ZDU3NzZkY2UtYWI0OC00MzQzLWI1MDQtYjVlYTUyMjI3NGEyNTcwYmU4OGMtNmU5ZS00YjlhLWJlY2MtMDdmYzk5NTVlODYy&redirect_uri=https%3A%2F%2Fportal.azure.com%2Fsignin%2Findex%2F&site_id=501430&client-request-id=779c199b-1cd0-4069-9e44-b5675cc5074e&x-client-SKU=ID_NET45&x-client-ver=5.3.0.0) by using the credentials for your Azure subscription.

• In the upper-left corner of Azure portal, select + Create a resource.

![](images/sentimentanalysis/image--001.png)

• Use the search bar to find Event Hubs

• Select Event Hubs

• Click Create

![](images/sentimentanalysis/image--002.png)

• Provide the following information to configure your new eventhub.

**Resource group** : Use an existing resource group (sentiment-analysis-XXXXX) in your subscription. A resource group holds related resources for an Azure solution.

**Namespace** : Enter a unique name that identifies your event hub namespace. Names must be unique across the resource group. *{prefix}-sentiment-analysis-ingestion*

**Subscription** : Select the Azure subscription that you want to use.

**Location** : Select the location closest to your users and the data resources to create your workspace.

**Pricing Tier** : Basic

**Throughput Units** : 1

![](images/sentimentanalysis/image--003.png)

• Click Next:Features

• Leave Defaults

• Click Next:Tags

• Click Next:Review+Create

• If the validation is successful, click create

![](images/sentimentanalysis/image--004.png)

• To view the new workspace, select Go to resource.

![](images/sentimentanalysis/image--005.png)

• Click on +Event Hub

![](images/sentimentanalysis/image--006.png)

• Create a new EventHub ingestion-eventHubs. A partition count of 2 and 1 day of
message retention is sufficient. No need to enable the capture feature.

![](images/sentimentanalysis/image--007.png)

Click Create

## Create an access policy

Each client that reads from the Event Hub needs to be assigned to a particular consumer
group. It's a good practice to give each consumer group a separate access policy, so you
can revoke each one of them separately.

• Navigate to the previously created Event Hub by selecting the event hub.

![](images/sentimentanalysis/image--008.png)

• Click on Shared access policies (under settings)

![](images/sentimentanalysis/image--009.png)

• Add here a new policy, that gives read access to Azure Stream Analytics

![](images/sentimentanalysis/image--010.png)

• Click Create

• Click on the created access policy and copy the connection string with primary
key. You'll need this later in this lab.

![](images/sentimentanalysis/image--011.png)

## Create a Logic App

In order to provide a simplified way to ingest tweets, we will use Azure Logic Apps.

• Go to the resource group you created earlier (you can search the resource group
in search bar on the portal page)

• Click on +Add

![](images/sentimentanalysis/image--012.png)

• Search for Logic app.

![](images/sentimentanalysis/image--013.png)

• Click Create

• Create a Logic App, named *{prefix}-sentiment-analysis-ingestion-happy*, choose
the same region as previously.

![](images/sentimentanalysis/image--014.png)

• Click Review+Create

• Click Create.

• Once deployed, click on “Go to resource”

• Choose to start from *Blank Logic App*.

![](images/sentimentanalysis/image--015.png)

## Add a trigger that receives specific tweets

This Logic App must fire each time a tweet contains a certain key word.

• Search for twitter in the search connector and trigger window

![](images/sentimentanalysis/image--016.png)

• Select Twitter

• Select When a new tweet is posted and authenticate with your Twitter account, by
clicking Signin.

![](images/sentimentanalysis/image--017.png)

• Click Authorize app in popup window

![](images/sentimentanalysis/image--018.png)

• Provide *#happy* as the hashtag to search for and poll every second.

![](images/sentimentanalysis/image--019.png)

## Send the tweets to Event Hubs

This Logic App has to send the captured tweets to Event Hubs.

• Below the trigger, click on New step to add an action to send to Event Hubs via
the Send event action.

• Search for event hub in search connector and action window

![](images/sentimentanalysis/image--020.png)

• Select event hub -> Send event

![](images/sentimentanalysis/image--021.png)

• Connect the action to the previously created Event Hub namespace and provide
connection name

![](images/sentimentanalysis/image--022.png)

• Select the event hub policy and click create

![](images/sentimentanalysis/image--023.png)

• In the parameter drop-down select content

![](images/sentimentanalysis/image--024.png)

• Select the eventhub and add the following JSON structure:

                 {
                   "text" : "@{triggerBody()['TweetText']}",
                    "hashtag" : "#happy",
                    "time" : "@{utcNow()}"
                 }
                 
• This should result in the following Logic App:

![](images/sentimentanalysis/image--025.png)

• Click Save

![](mages/Images/images:sentimentanalytics:*.png/image--026.png)

• Go to the Overview blade and click Refresh. After a while, you should see
successful Logic App runs. All tweets that contain #happy are from now on being
ingested into your Event Hub.

![](images/sentimentanalysis/image--027.png)

![](images/sentimentanalysis/image--028.png)

### Repeat the above steps to create another Logic App that ingests tweets that contain *#sad*.

## Create a web service that performs sentiment analysis

In this step, we will create an Azure Machine Learning (AML) web service that performs
the sentiment analysis.

• Navigate to the Azure AI Gallery [experiment for sentiment analysis](https://gallery.azure.ai/Experiment/Predictive-Mini-Twitter-sentiment-analysis-Experiment-1).

• Click on *Open in studio*.

![](images/sentimentanalysis/image--029.png)

• Select and/or create a AML Studio workspace. Click OK if you get a warning
about upgrading the experiment to a later version.

![](images/sentimentanalysis/image--030.png)

• Run the experiment, via the command at the bottom of the page, in order to
train the model. This can take several minutes

![](images/sentimentanalysis/image--031.png)

• Next, you can click Deploy web service. After a while, you get redirected to the
overview page of the created web service. Copy already the API key, as you will
need this later in the lab.

![](images/sentimentanalysis/image--032.png)

**• Via the *Test* button, you can easily provide a value to be analyzed:**

![](images/sentimentanalysis/image--033.png)

• At the bottom of the page, the result appears

![](images/sentimentanalysis/image--034.png)

### • Click now on the *REQUEST/RESPONSE* link, to go to the *API Help Page*, where you need to copy the web service URL for later usage

![](images/sentimentanalysis/image--035.png)


# Process tweets in realtime

## Create an Azure Stream Analytics Job

We need an Azure Stream Analytics Job to process the incoming stream of tweets in
realtime.

• Go to the resource group you created earlier (you can search the resource group
in search bar on the portal page)

• Click on +Add

![](images/sentimentanalysis/image--036.png)

• Search for stream analytics job.

• Click create

![](images/sentimentanalysis/image--037.png)

• Create a Stream Analytics Job, named *{prefix}-sentiment-analysis-asa*. Select the
resource group you created and identical location as the previously created
services. Keep *Cloud* as the hosting environment and set the *Streaming* units to 1.
The latter will save you some costs.

![](images/sentimentanalysis/image--038.png)

• Click Create

• Click on Go to resource

## Configure the Event Hubs Input

Let's now create a new *Input*, which should refer to the Event Hub that we created.

• Go to the *Inputs* blade and click *Add stream input*. Choose *Event Hub*

![](images/sentimentanalysis/image--039.png)

![](images/sentimentanalysis/image--040.png)

• In case you created the Event Hub yourself, you can use the Select Event Hub from
your subscription option. If not, provide the settings manually. You can retrieve all
these settings from the Event Hubs connection string.

![](images/sentimentanalysis/image--041.png)

• Click Save

## Create AML Web Service function

To be able to connect to the AML web service, we must create a new *Function*.

• Go to the *Funtions* blade and click *Add*. Choose *Azure ML Studio*.

![](images/sentimentanalysis/image--042.png)

• Provide the function alias *getSentiment*. Provide the settings manually by
specifying the *Url* and *API Key* that you copied previously.

![](images/sentimentanalysis/image--043.png)

## Configure the Power BI output

We need to send the result to Power BI, which means creating an *Output*.

• Go to the *Outputs* blade and click *Add*. Choose Power BI.

![](images/sentimentanalysis/image--044.png)

• Click on Authorize if it prompts you to authenticate

![](images/sentimentanalysis/image--045.png)

• Provide the output alias *powerbi*. Specify a meaningful *Dataset name* and *Table
name*. These names will be used to create automatically a data set in Power BI

![](images/sentimentanalysis/image--046.png)


## Configure the query

Now, we must write a query that calls the AML function to get the sentiment score for
each tweet and aggregates the results per 10 seconds.

• Go to the *Query* blade and paste the following SQL statement in the query
window.

       --Create a temp table that contains the sentiment score (via the getSentiment
         function)
         WITH
         scoredData AS (
         SELECT time, hashtag, getSentiment(text) as result
         FROM twitterfeed
         )
       --Select average score over a window of 10 seconds and send it to Power BI
         SELECT
              System.TimeStamp as time,
              hashtag,
              AVG(result.[Score]) as score
         INTO
              powerbi
         FROM
              scoredData
         GROUP BY
              hashtag, TumblingWindow(second,10) 
              
              
 ![](images/sentimentanalysis/image--047.png)
 
 • Click *Save*.
 
 ## Start and monitor the job
 
 • Go to the *Overview* blade and start the job from now.
 
 ![](images/sentimentanalysis/image--048.png)
 
 • Click Start
 
 • It takes a while before the job is completed up and running, but after 5 minutes,
you should see that the first events are getting processed.

![](images/sentimentanalysis/image--049.png)

## Visualize results in Power BI

In your Power BI namespace, you should see under the *Datasets* tab, that a data set has
been automatically created by Azure Stream Analytics.

![](images/sentimentanalysis/image--050.png)

• In the *Actions* of your data set, choose *Create report*.

![]images/sentimentanalysis/image--051.png)

• Select the *Line chart* as the chart type. Take time as the *Axis*, *hashtag* as
the *Legend* and *score* as the *Values*.

![](images/sentimentanalysis/image--052.png)

• Make the chart itself bigger, so it nicely fits your screen. You should see the
results by now. Normally, *#happy* should have a significantly better sentiment
score, compared to *#sad*.

![](images/sentimentanalysis/image--053.jpg)

• Save the report and give it a meaningful name.
 
 
 
 



































