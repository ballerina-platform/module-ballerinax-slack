// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/oauth2;

public client class Client {
    private map<string> channelIdMap = {};
    private http:Client slackClient;
    private ConversationClient conversationClient;
    private UserClient userClient;
    private FileClient fileClient;
    private ChatClient chatClient;

    public function init(Configuration config) {
        oauth2:OutboundOAuth2Provider oauth2Provider = new(config.oauth2Config);
        http:BearerAuthHandler oauth2Handler = new(oauth2Provider);
        http:ProxyConfig? proxyConfig = config?.proxyConfig;
        http:ClientConfiguration clientConfig = {
            auth: {
                authHandler: oauth2Handler
            },
            http1Settings: {
                proxy: proxyConfig
            }
        };
        self.slackClient = new(BASE_URL, config = clientConfig);
        self.conversationClient = new(self.slackClient, self.channelIdMap);
        self.userClient = new(self.slackClient);
        self.fileClient = new(self.slackClient, self.channelIdMap);
        self.chatClient = new(self.slackClient, self.channelIdMap);        
    } 

    # The `Client.getConversationClient()` function can be used to retrieve the conversation client.
    #
    # + return - The conversation client
    public isolated function getConversationClient() returns ConversationClient {
        return self.conversationClient;
    }

    # The `Client.getFileClient()` function can be used to retrieve the file client.
    #
    # + return - The file client
    public isolated function getFileClient() returns FileClient {
        return self.fileClient;
    }

    # The `Client.getChatClient()` function can be used to retrieve the chat client.
    #
    # + return - The chat client
    public isolated function getChatClient() returns ChatClient {
        return self.chatClient;
    }

    # The `Client.getUserClient()` function can be used to retrieve the user client.
    #
    # + return - The user client
    public isolated function getUserClient() returns UserClient {
        return self.userClient;
    }
}

public client class ConversationClient {

    private http:Client conversationClient;
    private map<string> idMap;

    isolated function init(http:Client slackClient, map<string> channelIdMap) {
        self.conversationClient = slackClient;  
        self.idMap = channelIdMap;
    }

    # The `ConversationClient.createConversation()` function can be used to create a conversation.
    #
    # + name - Name of the conversation(channel) to be created
    # + isPrivate - `true` if a private channel, `false` if a public channel
    # + return - A `slack:Error` if it is a failure or the `Channel` record if it is a success
    remote function createConversation(string name, boolean isPrivate = false) returns @tainted Channel|Error {
        string url = CREATE_CONVERSATION_PATH + name + IS_PRIVATE_CONVERSATION + isPrivate.toString();
        return createChannel(self.conversationClient, url);
    }

    # The `ConversationClient.archiveConversation()` function can be used to archive a conversation.
    #
    # + channelName - Name of the conversation to archive
    # + return - A `slack:Error` if it is a failure or `nil` if it is a success
    remote function archiveConversation(string channelName) returns @tainted Error? {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        return archiveConversation(self.conversationClient, <@untainted> resolvedChannelId);
    }

    # The `ConversationClient.unArchiveConversation()` function can be used to unarchive a conversation.
    #
    # + channelName - Name of the conversation to unarchive
    # + return - A `slack:Error` if it is a failure or `nil` if it is a success
    remote function unArchiveConversation(string channelName) returns @tainted Error? {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        return unArchiveConversation(self.conversationClient, <@untainted> resolvedChannelId);
    }

    # The `ConversationClient.renameConversation()` function can be used to rename a conversation.
    #
    # + channelName - Name of the conversation/channel
    # + newName - 	New name for the conversation.
    # + return - A `slack:Error` if it is a failure or the `Channel` record if it is a success
    remote function renameConversation(string channelName, string newName) returns @tainted Channel|Error {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        return renameConversation(self.conversationClient, <@untainted> resolvedChannelId, newName);
    }

    # The `ConversationClient.listConversations()` function can be used to list all the channels in a slack team.
    #
    # + return - A `slack:Error` if it is a failure or the `Conversations` record if it is a success
    remote function listConversations() returns @tainted Conversations|Error {
        http:Client convClient = self.conversationClient;
        http:Response|http:PayloadType|error response = convClient->get(LIST_CONVERSATIONS_PATH);
        if (response is error) {
           return setResError(response);  
        }
        http:Response httpResp = <http:Response> response;
        json|error jsonPayload = httpResp.getJsonPayload();
        if (jsonPayload is error) {
            return setJsonResError(jsonPayload);
        }
        json payload = <json> jsonPayload;
        return mapConversationInfo(payload);
    }

    # The `ConversationClient.leaveConversation()` function can be used to leave a conversation.
    #
    # + channelName - Name of the conversation 
    # + return - A 'slack:Error' if it is a failure or 'nil' if it is a success
    remote function leaveConversation(string channelName) returns @tainted Error? {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        return leaveConversation(self.conversationClient, <@untainted> resolvedChannelId);
    }

    # The `ConversationClient.getConversationInfo()` function can be used to get information of a conversation.
    #
    # + channelName - Name of the conversation
    # + includeLocale - Set this to `true` to receive the locale for this conversation. Defaults to `false`
    # + memberCount - Set to `true` to include the member count for the specified conversation. Defaults to `false`
    # + return - A `slack:Error` if it is a failure or the `Channel` record if it is a success
    remote function getConversationInfo(string channelName, boolean includeLocale = false, 
                                    boolean memberCount = false) returns @tainted Channel|Error {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        return getConversationInfo(self.conversationClient, <@untainted> resolvedChannelId);
    }

    # The `ConversationClient.removeUserFromConversation()` function can be used to remove a user from a conversation.
    #
    # + channelName - Name of the conversation 
    # + user - Name of the user to be removed
    # + return - A `slack:Error` if it is a failure or `nil` if it is a success
    remote function removeUserFromConversation(string channelName, string user) returns @tainted Error? {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        string userId = check getUserId(self.conversationClient, user); 
        return removeUserFromConversation(self.conversationClient, <@untainted> userId, <@untainted> resolvedChannelId);
    }

    # The `ConversationClient.joinConversation()` function can be used to join an existing conversation.
    #
    # + channelName - Name of the conversation 
    # + return - A 'slack:Error' if it is a failure or 'nil' if it is a success
    remote function joinConversation(string channelName) returns @tainted Error? {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        return joinConversation(self.conversationClient, <@untainted> resolvedChannelId);
    }

    # The `ConversationClient.inviteUsersToConversation()` function can be used to invite users to a channel.
    #
    # + channelName - Name of the conversation 
    # + users - An array of user names
    # + return - A `slack:Error` if it is a failure or the `Channel` record if it is a success
    remote function inviteUsersToConversation(string channelName, string[] users) 
                                returns @tainted Channel|Error {
        string channelId = EMPTY_STRING;
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        channelId = resolvedChannelId;
        string userIds = check getUserIds(self.conversationClient, users);
        return inviteUsersToConversation(<@untainted> self.conversationClient, <@untainted> channelId, 
                                            <@untainted> userIds);
    }

    private function resolveChannelId(map<string> channelMap, string channelName) returns @tainted string|Error {
        if (channelMap.hasKey(channelName)) {
            return channelMap.get(channelName);
        } 
        string channelId = check getChannelId(self.conversationClient, channelName);
        self.idMap[channelName] = channelId;
        return channelId;
    }
}

public client class UserClient {

    private http:Client userClient;

    isolated function init(http:Client slackClient) {
        self.userClient = slackClient;
    }

    # The `UserClient.getUserInfo()` function can be used to get information about a user.
    #
    # + user - Name of the user
    # + return - A 'slack:Error' if it is a failure or the 'User' record if it is a success
    remote function getUserInfo(string user) returns @tainted User|Error {
        string userId = check getUserId(self.userClient, user);
        return getUserInfo(self.userClient, <@untainted> userId); 
    }

    # The `UserClient.listConversations()` function can be used to list conversations the calling user may access.
    #
    # + excludeArchived - Set to `true` to exclude archived channels from the list
    # + noOfItems - Maximum number of items to return 
    # + types - A comma-separated list of any combination of public_channel, private_channel, mpim, im
    # + user - Name of the user
    # + return - A `slack:Error` if it is a failure or the `Conversations` record if it is a success
    remote function listConversations(boolean excludeArchived = false, int? noOfItems = (), string? types = (),
                                 string? user = ()) returns @tainted Conversations|Error {
        string resolvedUserId = EMPTY_STRING;
        if (user is string) {
            resolvedUserId = check getUserId(self.userClient, user);
        } 
        return listConversationsOfUser(self.userClient, <@untainted> resolvedUserId, excludeArchived, 
                                            noOfItems, types);
    }
}

public client class ChatClient {

    private http:Client chatClient;
    private string channelId = EMPTY_STRING;
    private map<string> idMap;

    isolated function init(http:Client slackClient, map<string> channelIdMap) {
        self.chatClient = slackClient;
        self.idMap = channelIdMap;
    }

    # The `ChatClient.postMessage()` function can be used to send a message to a channel.
    #
    # + message - Message parameters to be posted on Slack
    # + return - Thread ID of the posted message or a `slack:Error` 
    remote function postMessage(Message message) returns @tainted string|Error {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, message.channelName);
        return postMessage(self.chatClient, resolvedChannelId, message);
    }

    # The `ChatClient.updateMessage()` function can be used to update a message.
    #
    # + message - Message parameters to be updated on Slack
    # + return - The thread ID of the posted message or a `slack:Error`
    remote function updateMessage(Message message) returns @tainted string|Error {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, message.channelName);
        return updateMessage(self.chatClient, resolvedChannelId, message);
    }

    # The `ChatClient.deleteMessage()` function can be used to delete a message.
    #
    # + channelName - Name of the conversation/channel
    # + threadTs - Timestamp of the message to be deleted
    # + return - A `slack:Error` if it is a failure or 'nil' if it is a success
    remote function deleteMessage(string channelName, string threadTs) returns @tainted Error? {
        string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
        return deleteMessage(self.chatClient, <@untainted> resolvedChannelId, threadTs);
    }

    private function resolveChannelId(map<string> channelMap, string channelName) returns @tainted string|Error {
        if (channelMap.hasKey(channelName)) {
            return channelMap.get(channelName);
        } 
        string channelId = check getChannelId(self.chatClient, channelName);
        self.idMap[channelName] = channelId;
        return channelId;
    }
}

public client class FileClient {

    private http:Client fileClient;
    private map<string> idMap;

    isolated function init(http:Client slackClient, map<string> channelIdMap) {
        self.fileClient = slackClient;
        self.idMap = channelIdMap;
    }

    # The `FileClient.deleteFile()` function can be used to delete a file.
    #
    # + fileId - ID of the file to be deleted
    # + return - A `slack:Error` if it is a failure or 'nil' if it is a success
    remote function deleteFile(string fileId) returns @tainted Error? {
        return deleteFile(self.fileClient, <@untainted> fileId);
    }

    # The `FileClient.getFileInfo()` function can be used to get information of a file.
    #
    # + fileId - ID of the file
    # + return - A `slack:Error` if it is a failure or the 'FileInfo' record if it is a success
    remote function getFileInfo(string fileId) returns @tainted FileInfo|Error {
        return getFileInfo(self.fileClient, <@untainted> fileId);
    }

    # The `FileClient.listFiles()` function can be used to list files.
    #
    # + channelName - Name of the channel
    # + count - Number of items to return per page
    # + tsFrom - Filter files created after this timestamp (inclusive)
    # + tsTo - Filter files created before this timestamp (inclusive)
    # + types - Type to filter files (ex: types=spaces,snippets)
    # + user - User name to filter files created by a single user
    # + return - A `slack:Error` if it is a failure or the 'FilesList' record if it is a success
    remote function listFiles(string? channelName = (), int? count = (), string? tsFrom = (), string? tsTo = (), 
                string? types = (), string? user = ()) returns @tainted FileInfo[]|Error {
        string channelId = EMPTY_STRING;
        string userId = EMPTY_STRING;
        if (channelName is string) {
            channelId = check self.resolveChannelId(self.idMap, channelName);
        } 
        if (user is string) {
            userId = check getUserId(self.fileClient, user);
        }
        return listFiles(self.fileClient, <@untainted> channelId, count, tsFrom, tsTo, types, <@untainted> userId);         
    }

    # The `FileClient.uploadFile()` function can be used to upload or create a file.
    #
    # + filePath - Name of the conversation/channel
    # + channelName - Channel name 
    # + title - Title of the file
    # + initialComment - The message text introducing the file
    # + threadTs - Thread ID of the conversation, if replying to a thread
    # + return - A `slack:Error` if it is a failure or the 'File' record if it is a success
    remote function uploadFile(string filePath, string? channelName = (), string? title = (), 
                            string? initialComment = (), string? threadTs = ()) returns @tainted FileInfo|Error {
        if (channelName is string) {
            string resolvedChannelId = check self.resolveChannelId(self.idMap, channelName);
            return uploadFile(filePath, self.fileClient, <@untainted> resolvedChannelId, title, 
                        initialComment, threadTs);
        }
        return uploadFile(filePath, self.fileClient, channelName, title, initialComment, threadTs); 
    }

    private function resolveChannelId(map<string> channelMap, string channelName) returns @tainted string|Error {
        if (channelMap.hasKey(channelName)) {
            return channelMap.get(channelName);
        }
        string channelId = check getChannelId(self.fileClient, channelName);
        self.idMap[channelName] = channelId;
        return channelId;            
    }
}
