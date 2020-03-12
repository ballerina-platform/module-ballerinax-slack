# Module Slack

Ballerina Slack connector allows you to work with slack conversations/channels, users, user groups, files and messages through the Slack Web API.
It handles OAuth 2.0 authentication.

There are basically 5 clients provided by Ballerina to interact with different API groups in Slack Web API.
1. **slack:Client** - This client is the top most client in the slack module. This can be used to get the relevant client associated with the operation
that you wish to execute.
2. **slack:ChatClient** - Chat client can be used in messaging related operations. For example: post messages on slack, delete messages,
send attachments.
3. **slack:ConversationsClient** - This client can be used in conversations/channels related operations. For example: create conversations,
join a conversation, add users to a conversation, archive/unarchive conversations etc.
4. **slack:UsersClient** - This client can be used in users/user groups related operations. For example: get user information etc.
5. **self.filesClient** - This client can be used in file related operations in slack.

## Compatibility
|                     |    Version     |
|:-------------------:|:--------------:|
| Ballerina Language  | 1.1.4          |

## Sample

**Creating a simple slack application and obtaining tokens**

1. Create a new Slack App on [api.slack.com](https://api.slack.com/apps?new_granular_bot_app=1).
2. Type in your app name.
3. Select the workspace you'd like to build your app on. You can create a work space [here](https://slack.com/get-started#create) if you don't have one already.
4. Give your app permission. [Scopes](https://api.slack.com/scopes) allow your application to do operations in your workspace. Navigate to `OAuth & Permissions` on the sidebar to add scopes to your slack application. 
5. After giving permission, install the application in your workspace by clicking `Install App to Workspace`.
6. Next, authorize the app for the user permissions. Click `Allow` button.
7. Copy and save your token. This will be used to communicate with slack's platform.

**Create Slack client**

First, import the `ballerinax/slack` module into the Ballerina project.
```ballerina
import ballerinax/slack;
```
Instantiate the `slack:Client` by giving OAuth2 authentication details in the `slack:Configuration`. 

You can define the Slack configuration and create the top most Slack client as mentioned below. 
```ballerina
slack:Configuration slackConfig = {
    oAuth2Config: {
        accessToken: "<token-here>",
        refreshConfig: {
            clientId: "<CLIENT_ID>",
            clientSecret: "<CLIENT_SECRET>",
            refreshToken: "<REFRESH_TOKEN>",
            refreshUrl: "<REFRESH_URL>"
        }
    }
};

// Create the top most Slack client.
slack:Client slackClient = new(slackConfig);
```

**Slack operations related to Converations/Channels**

The `listConversation` remote function can be used to list all channels in a slack team. 

```ballerina
slack:ConversationClient conv = slackClient.getConversationClient();
var response = conv->listConversations();
if (response is Conversations) {    
    io:println("Conversations " + response);
} else {
    io:println(response.detail()?.message.toString());
}
```

**Slack operations related to chat messages**

The `postMessage` remote function can be used to send a message to a slack channel. 

```ballerina
slack:ChatClient chatClient = slackClient.getChatClient();
var response = chatClient->postMessage(channelName, "Hello Channel");
if (response is string) {    
    io:println("Message posted to channel " + response);
} else {
    io:println(response.detail()?.message.toString());
}
```

**Slack operations related to users**

The `getUserInfo` remote function can be used to get information about a user. 

```ballerina
slack:UserClient userClient = slackClient.getUserClient();
var response = userClient->getUserInfo(userName);
if (response is User) {    
    io:println("User id " + response.id);
} else {
    io:println(response.detail()?.message.toString());
}
```

**Slack operations related to files**

The `uploadFile` remote function can be used to upload or create a file. 

```ballerina
slack:FileClient fileClient = slackClient.getFileClient();
var response = fileClient->uploadFile(filePath, channelName);
if (response is FileInfo) {    
    io:println("File id " + response.id);
} else {
    io:println(response.detail()?.message.toString());
}
```