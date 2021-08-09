## Overview

The `ballerinax/slack.'listener` module provides a Listener to grasp events triggered from your Slack App. This functionality is provided by [Slack Events API](https://api.slack.com/apis/connections/events-api). 

## Supported trigger types
1. "onAppMention" - Subscribe to only the message events that mention your app or bot
2. "onChannelCreated" - A channel was created
3. "onEmojiChanged" - A custom emoji has been added or changed
4. "onFileShared" - A file was shared
5. "onMemberJoinedChannel" - A user joined a public or private channel
6. "onMessage" - A message was sent to a channel
7. "onReactionAdded" - A member has added an emoji reaction to an item
8. "onTeamJoin" - A new member has joined

## Prerequisites
Before using this connector in your Ballerina application, complete the following:

* Create a Slack account.
* Subscribe to events and obtain verification token
    1. Visit https://api.slack.com/apps, create your own Slack App and enable Event Subscription by going to `Event Subscriptions` section in your Slack App. 
    2. Add events that you are planning to listen in the `Subscribe to events on behalf of users` section and save changes.
    3. Obtain `Verification Token` from the `Basic Information` section of your Slack App.

## Quickstart
To use the Slack listener in your Ballerina application, update the .bal file as follows:

### Step 1: Import listener
Import the `ballerinax/slack.'listener` module as shown below.
```ballerina
import ballerinax/slack.'listener as slack;
```

### Step 2: Create a new listener instance
Create a `slack:ListenerConfiguration` using your `Slack Verification Token`, port and initialize the listener with it.
```ballerina
slack:ListenerConfiguration configuration = {
    port: 9090,
    verificationToken: "VERIFICATION_TOKEN"
};

listener slack:Listener slackListener = new (configuration);
```

### Step 3: Implement a listener remote function
* Now you can implement a listener remote function supported by this connector.

* `onMessage`, `onChannelCreated`, `onEmojiChanged`, `onFileShared`, `onMemberJoinedChannel`, `onAppMention`,
`onReactionAdded`, `onTeamJoin` are the supported remote functions.

* Write a remote function to receive a particular event type. Implement your logic within that function as shown in the below sample.

* Following is a simple sample for using Slack listener
```ballerina
import ballerina/log;
import ballerinax/slack.'listener as slack;

slack:ListenerConfiguration configuration = {
    port: 9090,
    verificationToken: "VERIFICATION_TOKEN"
};

listener slack:Listener slackListener = new (configuration);

service /slack on slackListener {
    isolated remote function onMessage(slack:MessageEvent eventInfo) returns error? {
        log:printInfo("New Message");
        log:printInfo(eventInfo.toString());
    }
}
```

* Register the request URL
    1. Run your ballerina service (similar to above sample) on prefered port.
    2. Start ngrok on same port using the command ``` ./ngrok http 9090 ```
    3. In `Event Subscriptions` section of your Slack App settings, paste the URL issued by ngrok following with your service path (eg : ```https://365fc542d344.ngrok.io/slack/events```) (`'/slack/events'` should be added after thr ngrok URL).
    4. Slack Event API will send a url_verification event containing the token and challenge key value pairs.
    5. Slack Listener will automatically verify the URL by comparing the token and send the required response back to slack 
    6. Check whether your request URL displayed as `verified` in `Event Subscriptions` section of your Slack App. 
    7. Subscribe to the events that you are planning to listen and click `Save Changes` button.

* Receiving events
    * After successful verification of Request URL your ballerina service will receive events. 

**NOTE:**
If the user's logic inside any remote method of the connector listener throws an error, connector internal logic will 
covert that error into a HTTP 500 error response and respond to the webhook (so that event may get redelivered), 
otherwise it will respond with HTTP 200 OK. Due to this architecture, if the user logic in listener remote operations
includes heavy processing, the user may face HTTP timeout issues for webhook responses. In such cases, it is advised to
process events asynchronously as shown below.

```ballerina
import ballerinax/slack.'listener as slack;
slack:ListenerConfiguration configuration = {
    port: 9090,
    verificationToken: "VERIFICATION_TOKEN"
};
listener slack:Listener slackListener = new (configuration);
service /slack on slackListener {
    remote function onMessage(slack:MessageEvent eventInfo) returns error? {
        _ = @strand { thread: "any" } start userLogic(eventInfo);
    }
}
function userLogic(slack:MessageEvent eventInfo) returns error? {
    // Write your logic here
}
```

**[You can find a list of samples here](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/samples)**
