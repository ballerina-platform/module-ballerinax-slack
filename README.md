## Module Overview

The `ballerinax/slack` module provides a slack client that allows you to access the Slack API through Ballerina.

The following sections provide you details on how to use the FTP connector.

- [Compatibility](#compatibility)
- [Feature Overview](#feature-overview)
- [Getting Started](#getting-started)
- [Samples](#samples)

## Compatibility

|                             |           Version           |
|:---------------------------:|:---------------------------:|
| Ballerina Language          |            1.1.4            |

## Feature Overview

### Slack Clients
There are basically 5 clients provided by Ballerina to interact with different API groups in Slack Web API. 
1. **slack:Client** - This client is the top most client in the slack module. This can be used to get the relevant client associated with the operation
that you wish to execute.
2. **slack:ChatClient** - Chat client can be used in messaging related operations. For example: post messages on slack, delete messages,
send attachments.
3. **slack:ConversationsClient** - This client can be used in conversations/channels related operations. For example: create conversations,
join a conversation, add users to a conversation, archive/unarchive conversations etc.
4. **slack:UsersClient** - This client can be used in users/user groups related operations. For example: get user information etc.
5. **self.filesClient** - This client can be used in file related operations in slack.

## Getting Started

### Prerequisites
Download and install [Ballerina](https://ballerinalang.org/downloads/).

### Pull the Module
You can pull the FTP module from Ballerina Central using the command:
```ballerina
$ ballerina pull ballerinax/slack
```

## Samples

### Slack Client Sample
The Slack Client Connector can be used to interact with slack API.

```ballerina
import ballerina/log;
import ballerinax/slack;

slack:Configuration slackConfig = {
    oAuth2Config: {
        accessToken: "<access-token>"
    }
};

public function main() {
    slack:Client slackClient = new(slackConfig);
    slack:ConversationClient conv = slackClient.getConversationsClient();
    slack:ChatClient chat = slackClient.getChatClient();
    slack:FileClient file = slackClient.getFileClient();
    slack:UserClient user = slackClient.getUserClient();

    // Post a message to a channel.
    var postResponse = chat->postMessage("channelName", "Hello Channel");
    if (postResponse is string) {
        log:printInfo("Message sent");
    } else {
        log:printError("Error occured when posting a message", postResponse);
    }

    // List all the conversations.
    var listConvResponse = conv->listConversations();
    if (listConvResponse is error) {
        log:printError("Error occured when listing conversations", listConvResponse);
    } else {
        log:printInfo(listConvResponse);
    }

    // Upload a file to a channel
    var fileResponse = file->uploadFile("filePath", "channelName");
    if (fileResponse is error) {
        log:printError("Error occured when uploading the file ", fileResponse);
    } else {
        log:printInfo("Uploaded file " + fileResponse.id);
    }

    // Get user information.
    var userResponse = user->getUserInfo("userName");
    if (userResponse is error) {
        log:printError("Error occured when getting user information ", userResponse);
    } else {
        log:printInfo("Found user information of the user " + userResponse.name);
    }
}
```