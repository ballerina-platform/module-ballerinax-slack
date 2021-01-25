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
4. Install npm and setup the [ngrok](https://ngrok.com/download).


### Pull the Module
Execute the below command to pull the Slack Listener module from Ballerina Central:
```ballerina
$ ballerina pull ballerinax/slack.'listener
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
int port = check 'int:fromString(config:getAsString("PORT"));

SlackListener:ListenerConfiguration config = {
    verificationToken: token
};

listener SlackListener:SlackEventListener slackListener = new(port, config);

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
