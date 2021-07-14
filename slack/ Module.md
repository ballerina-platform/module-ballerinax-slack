## Overview
The Ballerina Slack Connector allows you to access the Slack Web API and Slack Events API through Ballerina. This 
connector can be used to implement some of the most common use cases of Slack. This connector provides the capability
to query information from and perform some actions in a Slack workspace. This connector also allows you to listen to
Slack Events.

## Configuring connector
### Prerequisites
- Slack Account
### Obtaining Slack User Oauth Token
1. Visit https://api.slack.com/apps and create a Slack App.
2. In the "Add features and functionality" section, Click permissions.
3. Go to the Scopes section and add necessary OAuth scopes for User Token. ("channels:history", "channels:read", "channels:write", "chat:write", "emoji:read", files:read", "files:write", "groups:read", "reactions:read", "users:read", "users:read.email")
4. Install the app to the workspace.
5. Get your User OAuth token from the OAuth & Permissions section of your Slack App.

## Quickstart

### Post a message in a Slack Channel
#### Step 1: Import Slack module
First, import the ballerinax/slack module into the Ballerina project.
```ballerina
import ballerinax/slack;
```

#### Step 2: Configure the connection credentials.
You can now make the connection configuration using the Slack User Oauth Token.
```ballerina
slack:Configuration slackConfig = {
    bearerTokenConfig: {
        token: "SLACK_USER_OAUTH_TOKEN"
    }
};

slack:Client slackClient = check new(slackConfig);
```

#### Step 3: Post a message in Slack Channel
You can provide the "channelName" and "text" as shown below and post the message.
```ballerina
slack:Message messageParams = {
    channelName: "channelName",
    text: "Hello"
};

string response = slackClient->postMessage(messageParams);
```

## Snippets
Snippets of some operations.

- List Channels
```ballerina
slack:Conversations response = check slackClient->listConversations();
```

- Get Channel Information
```ballerina
slack:Channel response = check slackClient->getConversationInfo("channelName");
```

## [You can find more samples here](https://github.com/ballerina-platform/module-ballerinax-slack/tree/master/samples)
