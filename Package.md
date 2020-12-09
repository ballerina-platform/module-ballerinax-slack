## Module Overview

The `ballerinax/slack` module provides a Slack client, which allows you to access the Slack API through Ballerina.

The following sections provide you details on how to use the Slack connector.

- [Compatibility](#compatibility)
- [Feature Overview](#feature-overview)
- [Getting Started](#getting-started)
- [Samples](#samples)

## Compatibility

|                             |           Version           |
|:---------------------------:|:---------------------------:|
| Ballerina Language          |        Swan Lake Preview7   |

## Feature Overview

### Slack Clients
There are 5 clients provided by Ballerina to interact with different API groups of the Slack Web API. 
1. **slack:Client** - This client is the top-most client in the Slack module. This can be used to get the relevant client associated with the operation
that you wish to execute.
2. **slack:ChatClient** - The Chat client can be used in messaging-related operations. For example, post messages on slack, delete messages, 
send attachments, etc.
3. **slack:ConversationClient** - This client can be used in `conversations/channels`-related operations. For example, create conversations,
join a conversation, add users to a conversation, archive/unarchive conversations, etc.
4. **slack:UserClient** - This client can be used in `users/user groups`-related operations. For example, get user information etc.
5. **slack.FileClient** - This client can be used in file-related operations in Slack. For example, upload files, delete files, get file information, etc.

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
    slack:ConversationClient convClient = slackClient.getConversationClient();
    slack:ChatClient chatClient = slackClient.getChatClient();
    slack:FileClient fileClient = slackClient.getFileClient();
    slack:UserClient userClient = slackClient.getUserClient();

    slack:Message messageParams = {
        channelName: "channelName",
        text: "Hello"
    };

    // Post a message to a channel.
    string|slack:Error postResponse = chatClient->postMessage(messageParams);
    if (postResponse is string) {
        log:printInfo("Message sent");
    } else {
        log:printError("Error occured when posting a message", postResponse);
    }

    // List all the conversations.
    slack:Conversations|slack:Error listConvResponse = convClient->listConversations();
    if (listConvResponse is slack:Error) {
        log:printError("Error occured when listing conversations", listConvResponse);
    } else {
        log:printInfo(listConvResponse);
    }

    // Upload a file to a channel.
    slack:FileInfo|slack:Error fileResponse = fileClient->uploadFile("filePath", "channelName");
    if (fileResponse is slack:Error) {
        log:printError("Error occured when uploading the file ", fileResponse);
    } else {
        log:printInfo("Uploaded file " + fileResponse.id);
    }

    // Get user information.
    slack:User|slack:Error userResponse = userClient->getUserInfo("userName");
    if (userResponse is slack:Error) {
        log:printError("Error occured when getting user information ", userResponse);
    } else {
        log:printInfo("Found user information of the user ", userResponse.name);
    }
}
```
