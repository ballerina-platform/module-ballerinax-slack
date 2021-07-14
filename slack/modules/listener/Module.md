## Overview

The `ballerinax/slack.'listener` module provides a Listener to grasp event triggers from your Slack App. This functionality is provided by [Slack Event API](https://api.slack.com/apis/connections/events-api). 

### Supported Trigger Types
1. "onAppMention" - Subscribe to only the message events that mention your app or bot
2. "onChannelCreated" - A channel was created
3. "onEmojiChanged" - A custom emoji has been added or changed
4. "onFileShared" - A file was shared
5. "onMemberJoinedChannel" - A user joined a public or private channel
6. "onMessage" - A message was sent to a channel
7. "onReactionAdded" - A member has added an emoji reaction to an item
8. "onTeamJoin" - A new member has joined

## Configuring connector
### Prerequisites
- Slack Account

### Subscribe to events and obtain verification token
1. Visit https://api.slack.com/apps, create your own slack app and enable Event Subscription in your slack app settings. 
2. Subscribe to the events that you are planning to listen and save changes.
3. Obtain verification token from the Basic Information section of your Slack App.

## Quickstart

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
1. Run your ballerina service (similar to above sample) on prefered port.
2. Start ngrok on same port using the command ``` ./ngrok http 9090 ```
3. In Event Subscriptions section of your Slack App settings, paste the URL issued by ngrok following with your service path (eg : ```https://365fc542d344.ngrok.io/slack/events```) ("/slack/events" should be added after thr ngrok URL).
4. Slack Event API will send a url_verification event containing the token and challenge key value pairs.
5. Slack Listener will automatically verify the URL by comparing the token and send the required response back to slack 
6. Check whether your Request URL displayed as verified in your Slack.
7. Subscribe to the events that you are planning to listen and click save changes.

### Receiving events
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

## [You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/samples)
