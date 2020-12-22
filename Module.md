# Slack Module

The Ballerina Slack connector allows you to work with Slack `conversations/channels`, users, user groups, files, and messages through the Slack Web API.
It handles the OAuth 2.0 authentication.


## Compatibility
|                     |    Version            |
|:-------------------:|:---------------------:|
| Ballerina Language  | Swan Lake Preview8    |

## Sample

**Creating a simple Slack application and obtaining tokens**

1. Create a new Slack App on [api.slack.com](https://api.slack.com/apps?new_granular_bot_app=1).
2. Type in your app name.
3. Select the workspace you would like to build your app in. You can create a [workspace](https://slack.com/get-started#create) if you don't have one already.
4. Grant your app the required permissions. [Scopes](https://api.slack.com/scopes) allow your application to do operations in your workspace. Click `OAuth & Permissions` on the sidebar to add scopes to your Slack application. 
5. After granting the permissions, click `Install App to Workspace` to install the application in your workspace.
6. Next, click `Allow` to authorize the app for the user permissions. 
7. Copy and save your token. This will be used to communicate with Slack's platform.

**Create the Slack client**

First, execute the below command to import the `ballerinax/slack` module into the Ballerina project.
```ballerina
import ballerinax/slack;
```
Instantiate the `slack:Client` by giving OAuth2 authentication details in the `slack:Configuration`. 

You can define the Slack configuration and create the top-most Slack client as follows. 
```ballerina
slack:Configuration slackConfig = {
    oauth2Config: {
        accessToken: "<token-here>",
        refreshConfig: {
            clientId: "<CLIENT_ID>",
            clientSecret: "<CLIENT_SECRET>",
            refreshToken: "<REFRESH_TOKEN>",
            refreshUrl: "<REFRESH_URL>"
        }
    }
};

// Create the top-most Slack client.
slack:Client slackClient = new(slackConfig);
```

**Slack operations related to `Converations/Channels`**

The `listConversation` remote function can be used to list all the channels in a Slack team. 

```ballerina
slack:Conversations|slack:Error response = slackClient->listConversations();
if (response is slack:Conversations) {    
    io:println("Conversations ", response);
} else {
    io:println("Error ", response.message());
}
```

**Slack operations related to chat messages**

The `postMessage` remote function can be used to send a message to a Slack channel. 

```ballerina
slack:Message messageParams = {
    channelName: "channelName",
    text: "Hello"
};
string|slack:Error postResponse = slackClient->postMessage(messageParams);
if (postResponse is string) {
    io:println("Message posted to channel ", postResponse);
} else {
    io:println("Error occured when posting a message ", postResponse.message());
}
```

**Slack operations related to users**

The `getUserInfo` remote function can be used to get information about a user. 

```ballerina
slack:User|slack:Error response = slackClient->getUserInfo("<userName>");
if (response is slack:User) {    
    io:println("User id ", response.id);
} else {
    io:println("Error ", response.message());
}
```

**Slack operations related to files**

The `uploadFile` remote function can be used to upload or create a file. 

```ballerina
slack:FileInfo|slack:Error response = slackClient->uploadFile("<filePath>", "<channelName>");
if (response is slack:FileInfo) {    
    io:println("File id ", response.id);
} else {
    io:println("Error ", response.message());
}
```
