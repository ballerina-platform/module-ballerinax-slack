## Module Overview - `ballerinax/slack.'listener`

The `ballerinax/slack.'listener` module provides a Listener to grasp event triggers from your Slack App. This functionality is provided by [Slack Event API](https://api.slack.com/apis/connections/events-api). 

## Listener Feature Overview
1. Receive event triggers and event related data from Slack
2. Validate Slack requests using the Verification token issued and automatic response to Slack API when needed.

## Supported Trigger Types
1. "onAppMention" - Subscribe to only the message events that mention your app or bot
2. "onChannelCreated" - A channel was created
3. "onEmojiChanged" - A custom emoji has been added or changed
4. "onFileShared" - A file was shared
5. "onMemberJoinedChannel" - A user joined a public or private channel
6. "onMessage" - A message was sent to a channel
7. "onReactionAdded" - A member has added an emoji reaction to an item
8. "onTeamJoin" - A new member has joined

## Quickstart

### Prerequisites
1. Create your own slack app and enable Event Subscription in your slack app settings. 
2. Subscribe to the events that you are planning to listen and save changes.
3. Obtain verification token from the Basic Information section of your Slack App.
4. Download and install [Ballerina](https://ballerinalang.org/downloads/).
5. Install npm and setup the [ngrok](https://ngrok.com/download).

### Pull the Module
Execute the below command to pull the Slack Listener module from Ballerina Central:
```ballerina
$ ballerina pull ballerinax/slack.'listener
```

### Implementation of the listener

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

* Write a remote function to receive particular event type. Implement your logic within that function.

* "onAppMention", "onChannelCreated", "onEmojiChanged", "onFileShared", "onMemberJoinedChannel", "onMessage",
"onReactionAdded", "onTeamJoin" are the supported event types.

### Register the Request URL
1. Run your ballerina service (similar to below sample) on prefered port.
2. Start ngok on same port using the command ``` ./ngrok http 9090 ```
3. In Event Subscriptions section of your Slack App settings, paste the URL issued by ngrok following with your service path (eg : ```https://365fc542d344.ngrok.io/slack/events```) 
4. Slack Event API will send a url_verification event containing the token and challenge key value pairs.
5. Slack Listener will automatically verify the URL by comparing the token and send the required response back to slack 
6. Check whether your Request URL displayed as verified in your Slack.
7. Subscribe to the events that you are planning to listen and click save changes.

### Receiving events
* After successful verification of Request URL your ballerina service will receive events. 

## Samples

### Slack Listener Sample
* Following sample code is written to receive triggered event data from Slack Event API.
* Name of the remote functions written within the service must be one of the supported trigger type.
   Example: "onAppMention", "onChannelCreated", "onEmojiChanged", "onFileShared", "onMemberJoinedChannel", "onMessage",
   "onReactionAdded", "onTeamJoin"

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

> **NOTE:**
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

## Please check the [Samples directory](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/samples) for more examples.
