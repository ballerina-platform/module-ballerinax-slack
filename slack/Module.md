## Overview
This module allows you to access the Slack Web API through Ballerina. This module provides the capability
to query information and perform some actions in a Slack workspace.

## Prerequisites
Before using this connector in your Ballerina application, complete the following:

* Create a Slack account.
    1. Visit https://slack.com/get-started#/createnew and create a Slack account.
* Obtain Slack User OAuth Token.
    1. Visit https://api.slack.com/apps and create a Slack App.
    2. In the `Add features and functionality` section, Click `Permissions`.
    3. Go to the `Scopes` section and add necessary OAuth scopes in `User Token Scopes` section. ("channels:history", "channels:read", "channels:write", "chat:write", "emoji:read", files:read", "files:write", "groups:read", "reactions:read", "users:read", "users:read.email")
    4. Go back to `Basic Information` section of your Slack App. Then go to `Install your app` section and install the app to the workspace by clicking `Install to Workspace` button.
    5. Get your User OAuth token from the `OAuth & Permissions` section of your Slack App.

## Quickstart

To use the Slack connector in your Ballerina application, update the .bal file as follows:

### Step 1: Import connector
Import the `ballerinax/slack` module as shown below.
```ballerina
import ballerinax/slack;
```

### Step 2: Create a new connector instance
Create a `slack:ConnectionConfig` using your `Slack User Oauth Token` and initialize the connector with it.
```ballerina
slack:ConnectionConfig slackConfig = {
    auth: {
        token: "SLACK_USER_OAUTH_TOKEN"
    }
};

slack:Client slackClient = check new(slackConfig);
```

### Step 3: Invoke connector operation
1. Now you can use the operations available within the connector. Note that they are in the form of remote operations.

Following is an example on how to post a message using the connector.

```ballerina
public function main() returns error? {
    slack:Message messageParams = {
        channelName: "channelName",
        text: "Hello"
    };

    string threadTs = slackClient->postMessage(messageParams);
}
```
2. Use `bal run` command to compile and run the Ballerina program. 

**[You can find a list of samples here](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/samples)**
