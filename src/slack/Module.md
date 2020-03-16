# Slack Module

The Ballerina Slack connector allows you to work with Slack `conversations/channels`, users, user groups, files, and messages through the Slack Web API.
It handles the OAuth 2.0 authentication.

There are 5 clients provided by Ballerina to interact with different API groups in the Slack Web API.
1. **slack:Client** - This client is the top-most client in the Slack module. This can be used to get the relevant client associated with the operation
that you wish to execute.
2. **slack:ChatClient** - Chat client can be used in messaging-related operations. For example,  post messages on slack, delete messages,
send attachments, etc.
3. **slack:ConversationClient** - This client can be used in `conversations/channels`-related operations. For example, create conversations,
join a conversation, add users to a conversation, archive/unarchive conversations, etc.
4. **slack:UserClient** - This client can be used in `users/user groups`-related operations. For example, get user information etc.
5. **slack.FileClient** - This client can be used in file-related operations in Slack. For example, upload files, delete files, get file information, etc.

## Compatibility
|                     |    Version     |
|:-------------------:|:--------------:|
| Ballerina Language  | 1.2.0          |

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
slack:ConversationClient conv = slackClient.getConversationClient();
Conversations|error response = conv->listConversations();
if (response is Conversations) {    
    io:println("Conversations " + response);
} else {
    io:println("Error" + response.detail()?.message.toString());
}
```

**Slack operations related to chat messages**

The `postMessage` remote function can be used to send a message to a Slack channel. 

```ballerina
slack:ChatClient chatClient = slackClient.getChatClient();
string|error response = chatClient->postMessage(channelName, "Hello Channel");
if (response is string) {    
    io:println("Message posted to channel " + response);
} else {
    io:println("Error" + response.detail()?.message.toString());
}
```

**Slack operations related to users**

The `getUserInfo` remote function can be used to get information about a user. 

```ballerina
slack:UserClient userClient = slackClient.getUserClient();
User|error response = userClient->getUserInfo(userName);
if (response is User) {    
    io:println("User id " + response.id);
} else {
    io:println("Error" + response.detail()?.message.toString());
}
```

**Slack operations related to files**

The `uploadFile` remote function can be used to upload or create a file. 

```ballerina
slack:FileClient fileClient = slackClient.getFileClient();
FileInfo|error response = fileClient->uploadFile(filePath, channelName);
if (response is FileInfo) {    
    io:println("File id " + response.id);
} else {
    io:println("Error" + response.detail()?.message.toString());
}
```
