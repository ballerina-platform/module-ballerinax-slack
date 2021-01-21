# Ballerina Slack Connector 

Slack Connector provides to modules to access
1. Slack Web API
2. Slack Event API

## Compatibility

|                             |           Version           |
|:---------------------------:|:---------------------------:|
| Ballerina Language          |        Swan Lake Preview8   |


## Module Overview - `ballerinax/slack`

The `ballerinax/slack` module provides a Slack client, which allows you to access the Slack Web API through Ballerina.

The following sections provide you details on how to use the Slack connector.

- [Feature Overview](#feature-overview)
- [Getting Started](#getting-started)
- [Samples](#samples)


## Feature Overview

1. Conducting messaging-related operations. For example, post messages on slack, delete messages, 
send attachments, etc.
2. Executing `conversations/channels`-related operations. For example, create conversations,
join a conversation, add users to a conversation, archive/unarchive conversations, etc.
3. Condcting `users/user groups`-related operations. For example, get user information etc.
4. Performing file-related operations in Slack. For example, upload files, delete files, get file information, etc.

## Getting Started

### Prerequisites
Download and install [Ballerina](https://ballerinalang.org/downloads/).

### Pull the Module
Execute the below command to pull the Slack module from Ballerina Central:
```ballerina
$ ballerina pull ballerinax/slack
```

## Samples

### Slack Client Sample
The Slack Client Connector can be used to interact with the Slack Web API.

```ballerina
import ballerina/log;
import ballerinax/slack;

slack:Configuration slackConfig = {
    oauth2Config: {
        accessToken: "<access-token>"
    }
};

public function main() {
    slack:Client slackClient = new(slackConfig);

    slack:Message messageParams = {
        channelName: "channelName",
        text: "Hello"
    };

    // Post a message to a channel.
    string|slack:Error postResponse = slackClient->postMessage(messageParams);
    if (postResponse is string) {
        log:printInfo("Message sent");
    } else {
        log:printError("Error occured when posting a message", postResponse);
    }

    // List all the conversations.
    slack:Conversations|slack:Error listConvResponse = slackClient->listConversations();
    if (listConvResponse is slack:Error) {
        log:printError("Error occured when listing conversations", listConvResponse);
    } else {
        log:printInfo(listConvResponse);
    }

    // Upload a file to a channel.
    slack:FileInfo|slack:Error fileResponse = slackClient->uploadFile("filePath", "channelName");
    if (fileResponse is slack:Error) {
        log:printError("Error occured when uploading the file ", fileResponse);
    } else {
        log:printInfo("Uploaded file " + fileResponse.id);
    }

    // Get user information.
    slack:User|slack:Error userResponse = slackClient->getUserInfo("userName");
    if (userResponse is slack:Error) {
        log:printError("Error occured when getting user information ", userResponse);
    } else {
        log:printInfo("Found user information of the user ", userResponse.name);
    }
}
```
## Module Overview - `ballerinax/slack.'listener`

The `ballerinax/slack.'listener` module provides a Listener to grasp event triggers from your Slack App. This functionality is provided by Slack Event API. 

The following sections provide you details on how to use the Slack Listener Support..

- [Feature Overview](#feature-overview)
- [Getting Started](#getting-started)
- [Samples](#samples)


## Feature Overview

1. Receive event triggers and event related data from Slack
2. Validate Slack requests using the Verification token issued and automatic response to Slack API when needed.
3. Map raw event data with specific user friendly event records types.


## Getting Started

### Prerequisites
1. Create your own slack app enable event subscription in your slack app settings. 
2. Subscribe to the bot events that you are planning to listen.
3. Download and install [Ballerina](https://ballerinalang.org/downloads/).
4. Install npm and setup the ngrok


### Pull the Module
Execute the below command to pull the Slack module from Ballerina Central:
```ballerina
$ ballerina pull ballerinax/slack
```

### Register the Request URL
1. Run your ballerina service (similar to below sample) on prefered port.
2. Start ngok on same port using the command ``` ./ngrok http 9090 ```
3. Paste the URL issued by ngrok following with your service path (eg : ```https://365fc542d344.ngrok.io/slack/events``` )
4. Slack Event API will send a url_verification event containing the token and challenge key value pairs.
5. Slack Listener will automatically verify the URL by comparing the token and send the required response back to slack 
6. Check whether your Request URL displayed as verified.

### Receiving events
* After successful verification of Request URL your ballerina service will receive event triggers. 
* ballerina/slack.'listener ``` getEventData(caller, request) ``` method 
    - Map raw data received from slack to the matching event type
    - If a received event payload does not map with any defined event type method will return error. However in any such case user can access raw data using the request.

## Samples

### Slack Client Sample
Following sample code is written to receive triggered event data from Slack Event API

```ballerina
import ballerina/http;
import ballerina/log;
import ballerinax/slack.'listener as SlackListener;

string token = config:getAsString("VERIFICATION_TOKEN");

SlackListener:ListenerConfiguration config = {
    verificationToken: token
};

listener SlackListener:Listener slackListener = new(9090, config);

service /slack on slackListener {
    resource function post events(http:Caller caller, http:Request request) returns @untainted error?{
        log:print("Request : " + request.getJsonPayload().toString());

        var event = slackListener.getEventData(caller, request);
        if(event is SlackListener:SlackEvent){

            string eventType = event.'type;
            if(eventType == SlackListener:APP_MENTION){
                log:print("App Mention Event Triggered : " + event.toString());
            }
            else if (eventType == SlackListener:APP_HOME_OPENED){
                log:print("App Home Opened Event Triggered : " + event.toString());
            }
            else if (eventType == SlackListener:MESSAGE){
                log:print("Message Event Triggered : " + event.toString());
            }
        }
        else{
            log:print("Error occured : " + event.toString());
        }
    
    }
}

```