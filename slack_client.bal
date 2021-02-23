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

public client class Client {
    private map<string> channelIdMap = {};
    private http:Client slackClient;

    public function init(Configuration config) returns error? {
        http:ClientSecureSocket? socketConfig = config?.secureSocketConfig;

        self.slackClient =  check new (BASE_URL, {
            auth: config.bearerTokenConfig,
            secureSocket: socketConfig
        });
    }

    //Conversation specific functions

    # The `Client.createConversation()` function can be used to create a conversation.
    #
    # + name - Name of the conversation(channel) to be created
    # + isPrivate - `true` if a private channel, `false` if a public channel
    # + return - an error if it is a failure or the `Channel` record if it is a success
    remote function createConversation(string name, boolean isPrivate = false) returns @tainted Channel|error {
        string url = CREATE_CONVERSATION_PATH + name + IS_PRIVATE_CONVERSATION + isPrivate.toString();
        return createChannel(self.slackClient, url);
    }

    # The `Client.archiveConversation()` function can be used to archive a conversation.
    #
    # + channelName - Name of the conversation to archive
    # + return - an error if it is a failure or `nil` if it is a success
    remote function archiveConversation(string channelName) returns @tainted error? {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        return archiveConversation(self.slackClient, <@untainted>resolvedChannelId);
    }

    # The `Client.unArchiveConversation()` function can be used to unarchive a conversation.
    #
    # + channelName - Name of the conversation to unarchive
    # + return - an error if it is a failure or `nil` if it is a success
    remote function unArchiveConversation(string channelName) returns @tainted error? {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        return unArchiveConversation(self.slackClient, <@untainted>resolvedChannelId);
    }

    # The `Client.renameConversation()` function can be used to rename a conversation.
    #
    # + channelName - Name of the conversation/channel
    # + newName - 	New name for the conversation.
    # + return - an error if it is a failure or the `Channel` record if it is a success
    remote function renameConversation(string channelName, string newName) returns @tainted Channel|error {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        return renameConversation(self.slackClient, <@untainted>resolvedChannelId, newName);
    }

    # The `Client.listConversations()` function can be used to list all the channels in a slack team.
    #
    # + return - an error if it is a failure or the `Conversations` record if it is a success
    remote function listConversations() returns @tainted Conversations|error {
        http:Client convClient = self.slackClient;
        http:Response response = <http:Response> check convClient->get(LIST_CONVERSATIONS_PATH);
        json payload = check response.getJsonPayload();
        return mapConversationInfo(payload);
    }

    # The `Client.leaveConversation()` function can be used to leave a conversation.
    #
    # + channelName - Name of the conversation 
    # + return - an error if it is a failure or 'nil' if it is a success
    remote function leaveConversation(string channelName) returns @tainted error? {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        return leaveConversation(self.slackClient, <@untainted>resolvedChannelId);
    }

    # The `Client.getConversationInfo()` function can be used to get information of a conversation.
    #
    # + channelName - Name of the conversation
    # + includeLocale - Set this to `true` to receive the locale for this conversation. Defaults to `false`
    # + memberCount - Set to `true` to include the member count for the specified conversation. Defaults to `false`
    # + return - an error if it is a failure or the `Channel` record if it is a success
    remote function getConversationInfo(string channelName, boolean includeLocale = false, boolean memberCount = false) 
                                        returns @tainted Channel|error {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        return getConversationInfo(self.slackClient, <@untainted>resolvedChannelId);
    }

    # The `Client.removeUserFromConversation()` function can be used to remove a user from a conversation.
    #
    # + channelName - Name of the conversation 
    # + user - Name of the user to be removed
    # + return - an error if it is a failure or `nil` if it is a success
    remote function removeUserFromConversation(string channelName, string user) returns @tainted error? {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        string userId = check getUserId(self.slackClient, user);
        return removeUserFromConversation(self.slackClient, <@untainted>userId, <@untainted>resolvedChannelId);
    }

    # The `Client.joinConversation()` function can be used to join an existing conversation.
    #
    # + channelName - Name of the conversation 
    # + return - an error if it is a failure or 'nil' if it is a success
    remote function joinConversation(string channelName) returns @tainted error? {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        return joinConversation(self.slackClient, <@untainted>resolvedChannelId);
    }

    # The `Client.inviteUsersToConversation()` function can be used to invite users to a channel.
    #
    # + channelName - Name of the conversation 
    # + users - An array of user names
    # + return - an error if it is a failure or the `Channel` record if it is a success
    remote function inviteUsersToConversation(string channelName, string[] users) returns @tainted Channel|error {
        string channelId = EMPTY_STRING;
        string resolvedChannelId = check self.resolveChannelId(channelName);
        channelId = resolvedChannelId;
        string userIds = check getUserIds(self.slackClient, users);
        return inviteUsersToConversation(<@untainted>self.slackClient, <@untainted>channelId, <@untainted>userIds);
    }

    //user specific functions

    # The `Client.getUserInfo()` function can be used to get information about a user.
    #
    # + user - Name of the user
    # + return - an error if it is a failure or the 'User' record if it is a success
    remote function getUserInfo(string user) returns @tainted User|error {
        string userId = check getUserId(self.slackClient, user);
        return getUserInfo(self.slackClient, <@untainted>userId);
    }

    # The `Client.listConversations()` function can be used to list conversations the calling user may access.
    #
    # + excludeArchived - Set to `true` to exclude archived channels from the list
    # + noOfItems - Maximum number of items to return 
    # + types - A comma-separated list of any combination of public_channel, private_channel, mpim, im
    # + user - Name of the user
    # + return - an error if it is a failure or the `Conversations` record if it is a success
    remote function listUserConversations(boolean excludeArchived = false, int? noOfItems = (), string? types = (), 
                                          string? user = ()) returns @tainted Conversations|error {
        string resolvedUserId = EMPTY_STRING;
        if (user is string) {
            resolvedUserId = check getUserId(self.slackClient, user);
        }
        return listConversationsOfUser(self.slackClient, <@untainted>resolvedUserId, excludeArchived, noOfItems, types);
    }

    //chat specific functions

    # The `Client.postMessage()` function can be used to send a message to a channel.
    #
    # + message - Message parameters to be posted on Slack
    # + return - Thread ID of the posted message or an error
    remote function postMessage(Message message) returns @tainted string|error {
        string resolvedChannelId = check self.resolveChannelId(message.channelName);
        return postMessage(self.slackClient, resolvedChannelId, message);
    }

    # The `Client.updateMessage()` function can be used to update a message.
    #
    # + message - Message parameters to be updated on Slack
    # + return - The thread ID of the posted message or an error
    remote function updateMessage(Message message) returns @tainted string|error {
        string resolvedChannelId = check self.resolveChannelId(message.channelName);
        return updateMessage(self.slackClient, resolvedChannelId, message);
    }

    # The `Client.deleteMessage()` function can be used to delete a message.
    #
    # + channelName - Name of the conversation/channel
    # + threadTs - Timestamp of the message to be deleted
    # + return - an error if it is a failure or 'nil' if it is a success
    remote function deleteMessage(string channelName, string threadTs) returns @tainted error? {
        string resolvedChannelId = check self.resolveChannelId(channelName);
        return deleteMessage(self.slackClient, <@untainted>resolvedChannelId, threadTs);
    }

    //file specific function

    # The `Client.deleteFile()` function can be used to delete a file.
    #
    # + fileId - ID of the file to be deleted
    # + return - an error if it is a failure or 'nil' if it is a success
    remote function deleteFile(string fileId) returns @tainted error? {
        return deleteFile(self.slackClient, <@untainted>fileId);
    }

    # The `Client.getFileInfo()` function can be used to get information of a file.
    #
    # + fileId - ID of the file
    # + return - an error` if it is a failure or the 'FileInfo' record if it is a success
    remote function getFileInfo(string fileId) returns @tainted FileInfo|error {
        return getFileInfo(self.slackClient, <@untainted>fileId);
    }

    # The `Client.listFiles()` function can be used to list files.
    #
    # + channelName - Name of the channel
    # + count - Number of items to return per page
    # + tsFrom - Filter files created after this timestamp (inclusive)
    # + tsTo - Filter files created before this timestamp (inclusive)
    # + types - Type to filter files (ex: types=spaces,snippets)
    # + user - User name to filter files created by a single user
    # + return - an error if it is a failure or the 'FilesList' record if it is a success
    remote function listFiles(string? channelName = (), int? count = (), string? tsFrom = (), string? tsTo = (), 
                              string? types = (), string? user = ()) returns @tainted FileInfo[]|error {
        string channelId = EMPTY_STRING;
        string userId = EMPTY_STRING;
        if (channelName is string) {
            channelId = check self.resolveChannelId(channelName);
        }
        if (user is string) {
            userId = check getUserId(self.slackClient, user);
        }
        return listFiles(self.slackClient, <@untainted>channelId, count, tsFrom, tsTo, types, <@untainted>userId);
    }

    # The `Client.uploadFile()` function can be used to upload or create a file.
    #
    # + filePath - Name of the conversation/channel
    # + channelName - Channel name 
    # + title - Title of the file
    # + initialComment - The message text introducing the file
    # + threadTs - Thread ID of the conversation, if replying to a thread
    # + return - an error if it is a failure or the 'File' record if it is a success
    remote function uploadFile(string filePath, string? channelName = (), string? title = (), 
                               string? initialComment = (), string? threadTs = ()) returns @tainted FileInfo|error {
        if (channelName is string) {
            string resolvedChannelId = check self.resolveChannelId(channelName);
            return 
            uploadFile(filePath, self.slackClient, <@untainted>resolvedChannelId, title, initialComment, threadTs);
        }
        return uploadFile(filePath, self.slackClient, channelName, title, initialComment, threadTs);
    }

    private function resolveChannelId(string channelName) returns @tainted string|error {
        if (self.channelIdMap.hasKey(channelName)) {
            return self.channelIdMap.get(channelName);
        }
        string channelId = check getChannelId(self.slackClient, channelName);
        self.channelIdMap[channelName] = channelId;
        return channelId;
    }
}
