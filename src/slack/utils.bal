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
import ballerina/mime;
import ballerina/stringutils;

function getChannelId(http:Client slackClient, string channelName) returns @tainted string|Error {
    http:Response|error response = slackClient->get(LIST_CONVERSATIONS_PATH);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var channelList = resp.getJsonPayload();
    if (channelList is error) {
        return setJsonResError(channelList);
    }
    map<json> channelListJson = <map<json>> channelList;
    var checkOkResp = check checkOk(channelListJson);
    var channels = channelListJson.channels;
    if (channels is error) {
        return setJsonResError(channels);
    }
    json[] channelsArr = <json[]> channels;
    foreach var ch in channelsArr {
        if (ch.name == channelName) {
            return (ch.id).toString();
        }
    }
    return Error(message = "Channel " + channelName + " does not exist");
}

function archiveConversation(http:Client slackClient, string channelId) returns @tainted Error? {
    string url = ARCHIVE_CHANNEL_PATH + channelId;
    return handleArchiveResponse(slackClient, url);
}

function unArchiveConversation(http:Client slackClient, string channelId) returns @tainted Error? {
    string url = UNARCHIVE_CHANNEL_PATH + channelId;
    return handleArchiveResponse(slackClient, url);
}

function handleArchiveResponse(http:Client slackClient, string url) returns @tainted Error? {
    http:Response|error response = slackClient->post(url, EMPTY_STRING);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var jsonResponse = resp.getJsonPayload();
    if (jsonResponse is error) {
        return setJsonResError(jsonResponse);
    }
    json jsonResp = <json> jsonResponse;
    var checkOk = check checkOk(jsonResp);       
}

function getUserIds(http:Client slackClient, string[] users) returns @tainted string|Error {
    string usersList = EMPTY_STRING;
    http:Response|error response = slackClient->get(LIST_USERS_PATH);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var payload = resp.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    }
    map<json> jsonPayload = <map<json>> payload;
    var checkOk = check checkOk(jsonPayload);
    var members = jsonPayload.members;
    if (members is error) {
        return setJsonResError(members);
    }
    json[] memberList = <json[]> members;
    foreach var user in users {
        foreach var member in memberList {
            if (member.name == user) {
                usersList = usersList + (member.id).toString() + ",";
            }
        }
    } 
    if (usersList == EMPTY_STRING) {
        return Error(message = "Unable to find user ids of the given users");
    }
    return usersList;
}

function getUserId(http:Client slackClient, string user) returns @tainted string|Error {
    http:Response|error response = slackClient->get(LIST_USERS_PATH);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var payload = resp.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    }
    map<json> jsonPayload = <map<json>> payload;
    var checkOk = check checkOk(jsonPayload);
    var members = jsonPayload.members;
    if (members is error) {
        return setJsonResError(members);
    }
    json[] memArr = <json[]> members;
    foreach var member in memArr {
        if (member.name == user) {
            return (member.id).toString();
        }
    } 
    return Error(message = "Unable to find the user id for the user " + user);    
}

function listConversationsOfUser(http:Client slackClient, string user, boolean excludeArchived, int? noOfItems = (), 
                                    string? types = ()) returns @tainted Conversations|Error {
    string url = LIST_USER_CONVERSATIONS_PATH + EXCLUDE_ARCHIVED + excludeArchived.toString();
    if (noOfItems is int) {
        url = url + LIMIT + noOfItems.toString();
    }
    if (types is string) {
        url = url + TYPES + types;
    }
    if (user != EMPTY_STRING) {
        url = url + USER_ARG + user;
    }
    http:Response|error response = slackClient->get(url);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    json|error payload = resp.getJsonPayload();
    if (payload is error) {
        return setJsonResError(payload);
    }
    json jsonPayload = <json> payload;
    var checkOk = check checkOk(jsonPayload);
    return mapConversationInfo(jsonPayload);      
}

function removeUserFromConversation(http:Client slackClient, string user, string channelId) returns @tainted Error? {
    string url = KICK_USER_FROM_CHANNEL_PATH + channelId + USER_ARG + user;
    return handleOkResp(slackClient, url);
}

function inviteUsersToConversation(http:Client slackClient, string channelId, string users) 
                                        returns @tainted Error|Channel {
    string url = INVITE_USERS_TO_CHANNEL_PATH + channelId + USER_IDS_ARG + users;
    http:Response|error response = slackClient->post(url, EMPTY_STRING);
    if (response is error) {
        return setResError(response);
    } 
    http:Response resp = <http:Response> response;
    var jsonResponse = resp.getJsonPayload();
    if (jsonResponse is error) {
        return setJsonResError(jsonResponse);
    }
    json jsonPayload = <json> jsonResponse;
    var checkOk = check checkOk(jsonPayload);
    return mapChannelInfo(resp);
}

function getConversationInfo(http:Client slackClient, string channelId, boolean? includeLocale = false,
                                 boolean? memberCount = false) returns @tainted Channel|Error {
    string url = GET_CONVERSATION_INFO_PATH + channelId + INCLUDE_LOCALE + includeLocale.toString() + 
                    INCLUDE_NUM_MEMBERS + memberCount.toString();
    http:Response|error response = slackClient->get(url);
    if (response is error) {
        return setResError(response);
    } else {
        return mapChannelInfo(response);
    }
}

function postMessage(http:Client slackClient, string channelId, string message, string? threadTs = ()) 
                        returns @tainted string|Error {
    string url = POST_MESSAGE_PATH + channelId + TEXT_TYPE_ARG + message;
    if (!(threadTs is ())) {
        url = url + THREAD_TS_ARG + threadTs;
    }
    return handlePostMessage(slackClient, url);
}

function updateMessage(http:Client slackClient, string channelId, string message, string threadTs) 
                        returns @tainted string|Error {
    string url = UPDATE_MESSAGE_PATH + channelId + TEXT_TYPE_ARG + message + THREAD_TS_ARG_FOR_UPDATING + threadTs;
    return handlePostMessage(slackClient, url);
}

function handlePostMessage(http:Client slackClient, string url) returns @tainted string|Error {
    http:Response|error response = slackClient->post(<@untained> url, EMPTY_STRING);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var jsonResponse = resp.getJsonPayload();
    if (jsonResponse is error) {
        return setJsonResError(jsonResponse);
    }
    json jsonPayload = <json> jsonResponse;
    var okResp = check checkOk(jsonPayload);
    json|error threadId = jsonPayload.ts;
    if (threadId is error) {
        return setJsonResError(threadId);
    } else {
        return threadId.toString();
    }
}

function createChannel(http:Client slackClient, string url) returns @tainted Channel|Error {
    http:Response|error response = slackClient->post(url, EMPTY_STRING);
    if (response is http:Response) {
        return mapChannelInfo(response);
    } else {
        return setResError(response);
    }
}

function mapChannelInfo(http:Response response) returns @tainted Channel|Error {
    var jsonResponse = response.getJsonPayload();
    if (jsonResponse is error) {
        return setJsonResError(jsonResponse);
    }
    json jsonPayload = <json> jsonResponse;
    json|error okResp = jsonPayload.ok;
    if (okResp is error) {
        return setJsonResError(okResp);
    }
    json ok = <json> okResp;
    if (ok == true) {                    
        var ch = jsonPayload.'channel;
        if (ch is map<json>) {
            Channel|error slackCh = Channel.constructFrom(ch);
            if (slackCh is error) {
                return Error(message = "Channel does not exist", cause = slackCh);
            } else {
                return slackCh;
            }            
        } else {
            return Error(message = "Channel does not exist");
        }
    } else {
        return Error(message = "Retrieving channel information failed: " + 
                        (jsonPayload.'error).toString());
    }    
}

function mapConversationInfo(json channelList) returns Conversations|Error {
    var conversations = Conversations.constructFrom(channelList);
    if (conversations is error) {
        return Error(message = "Response cannot be converted to Conversations record", cause = conversations);
    } else {
        return conversations;
    }
}

function joinConversation(http:Client slackClient, string channelId) returns @tainted Error? {
    string url = CONVERSATIONS_JOIN_PATH + channelId;
    return handleOkResp(slackClient, url);
}

function leaveConversation(http:Client slackClient, string channelId) returns @tainted Error? {
    string url = LEAVE_CHANNEL_PATH + channelId;
    return handleOkResp(slackClient, url);
}

function getUserInfo(http:Client slackClient, string userId) returns @tainted Error|User {
    string url = GET_USER_INFO_PATH + userId;
    http:Response|error response = slackClient->get(url);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var userInfo = resp.getJsonPayload();
    if (userInfo is error) {
        return setJsonResError(userInfo);
    }
    json userInfoPayload = <json> userInfo;
    var checkOk = check checkOk(userInfoPayload);
    json|error user = userInfoPayload.user;
    if (user is error) {
        return setJsonResError(user);
    }
    json userJson = <json> user;
    var  userRec = User.constructFrom(userJson);
    if (userRec is error) {
        return Error(message = "Response cannot be converted to User record", cause = userRec);
    } else {
        return userRec;
    }
}

function renameConversation(http:Client slackClient, string channelId, string newName) returns @tainted Channel|Error {
    string url = RENAME_CHANNEL_PATH + channelId + NAME_ARG + newName;
    http:Response|error response = slackClient->post(url, EMPTY_STRING);
    if (response is http:Response) {
        return mapChannelInfo(response);
    } else {
        return setResError(response);
    }
}

function checkOk(json respPayload) returns Error? {
    json|error ok = respPayload.ok;
    if (ok is error) {
        return setJsonResError(ok);
    }
    if (ok == false) {
        json|error errorRes = respPayload.'error;
        if (errorRes is json) {
            return Error(message = errorRes.toString());
        }
    }
}

function deleteMessage(http:Client slackClient, string channelId, string threadTs) returns @tainted Error? {
    string url = DELETE_CONVERSATION_PATH + channelId + DELETE_CONVERSATION_TS_ARG + threadTs;
    return handleOkResp(slackClient, url);
}

function deleteFile(http:Client slackClient, string fileId) returns @tainted Error? {
    string url = DELETE_FILE_PATH + fileId;
    return handleOkResp(slackClient, url);
}

function listFiles(http:Client slackClient, string? channelId, int? count, string? tsFrom, 
                            string? tsTo, string? types, string? user) returns @tainted FileInfo[]|Error {
    string url = LIST_FILES_PATH;
    if (channelId is string && channelId != EMPTY_STRING) {
        url = url + CHANNEL_ARG + channelId;
    }
    if (count is int) {
        url = (stringutils:contains(url, QUESTION_MARK)) ? url + COUNT_AS_SECOND_PARAM + count.toString() : 
                url + COUNT_AS_FIRST_PARAM + count.toString();
    }  
    if (tsFrom is string) {
        url = (!stringutils:contains(url, QUESTION_MARK)) ? url + TS_FROM_AS_FIRST_PARAM + tsFrom.toString() : 
                url + TS_FROM_AS_SECOND_PARAM + tsFrom.toString();
    }
    if (tsTo is string) {
        url =  (stringutils:contains(url, QUESTION_MARK)) ? url + TS_TO_AS_SECOND_PARAM + tsTo.toString() : 
                url + TS_TO_AS_FIRST_PARAM + tsTo.toString();
    }    
    if (types is string) {
        url = (stringutils:contains(url, QUESTION_MARK)) ? url + TYPES_AS_SECOND_PARAM + types.toString() :     
                url + TYPES_AS_FIRST_PARAM + types.toString();
    }  
    if (user is string && user != EMPTY_STRING) {
        url = (stringutils:contains(url, QUESTION_MARK)) ? url + USER_AS_SECOND_PARAM + user.toString() : 
                url + USER_AS_FIRST_PARAM + user.toString();
    }         
    http:Response|error response = slackClient->post(url, EMPTY_STRING);
    if (response is error) {
        return setResError(response);
    }
    http:Response httpResp = <http:Response> response;
    var fileList = httpResp.getJsonPayload();
    if (fileList is error) {
        return setJsonResError(fileList);
    }
    json fileListPayload = <json> fileList;
    var checkOk = check checkOk(fileListPayload);
    var files = fileListPayload.files;
    if (files is error) {
        return setJsonResError(files);
    }
    json fileJson = <json> files;
    var fileRec = FileInfo[].constructFrom(fileJson);
    if (fileRec is error) {
        return Error(message = "Response cannot be converted to FileInfo array", cause = fileRec);
    } else {
        return fileRec;
    }
}

function uploadFile(string filePath, http:Client slackClient, string? channelId, string? title = (), 
                    string? initialComment = (), string? threadTs = ()) returns @tainted FileInfo|Error {
    string url = UPLOAD_FILES_PATH;
    if (channelId is string) {
        url = url + CHANNELS_PARAM + channelId;
    }
    if (title is string) {
        url = (stringutils:contains(url, QUESTION_MARK)) ? url + TITLE_AS_SECOND_PARAM + title : 
                url + TITLE_AS_FIRST_PARAM + title;
    }  
    if (initialComment is string) {
        url = (stringutils:contains(url, QUESTION_MARK)) ? url + INITIAL_COMMENT_AS_SECOND_PARAM + initialComment : 
                url + INITIAL_COMMENT_AS_FIRST_PARAM + initialComment;
    }
    if (threadTs is string) {
        url = (stringutils:contains(url, QUESTION_MARK)) ? url + THREAD_TS_AS_SECOND_PARAM + threadTs : 
                url + THREAD_TS_AS_FIRST_PARAM + threadTs;
    }              
    http:Request request = new;
    mime:Entity filePart = new;
    filePart.setContentDisposition(getContentDispositionForFormData(FILE, filePath));

    filePart.setFileAsEntityBody(filePath);
    mime:Entity[] bodyParts = [<@untainted> filePart];
    request.setBodyParts(bodyParts, contentType = mime:MULTIPART_FORM_DATA);
    http:Response|error response = slackClient->post(url, request);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var fileInfo = resp.getJsonPayload();
    if (fileInfo is error) {
        return setJsonResError(fileInfo);
    }
    json fileInfoPayload = <json> fileInfo;  
    var checkOk = check checkOk(fileInfoPayload);    
    var file = fileInfoPayload.file;
    if (file is error) {
        return setJsonResError(file);
    }
    json fileJson = <json> file;
    var fileRec = FileInfo.constructFrom(fileJson);
    if (fileRec is error) {
        return Error(message = "Unable to convert the response to FileInfo record", cause = fileRec);
    } else {
        return fileRec;
    }
}

function getFileInfo(http:Client slackClient, string fileId) returns @tainted FileInfo|Error {
    string url = GET_FILE_INFO_PATH + fileId;
    http:Response|error response = slackClient->get(url);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var fileInfo = resp.getJsonPayload();
    if (fileInfo is error) {
        return setJsonResError(fileInfo);
    }
    json fileInfoPayload = <json> fileInfo;
    var checkOk = check checkOk(fileInfoPayload);
    var file = fileInfoPayload.file;
    if (file is error) {
        return setJsonResError(file);
    }
    json fileJson = <json> file;
    var fileRec = FileInfo.constructFrom(fileJson);
    if (fileRec is error) {
        return Error(message = "Unable to convert the response to FileInfo record", cause = fileRec);
    } else {
        return fileRec;
    }
}

function getContentDispositionForFormData(string partName, string filePath) returns (mime:ContentDisposition) {
    mime:ContentDisposition contentDisposition = new;
    contentDisposition.name = partName;
    contentDisposition.disposition = DISPOSITION;
    contentDisposition.fileName = getFileName(filePath);
    return contentDisposition;
}

function getFileName(string filePath) returns string {
    int lastIndex = stringutils:lastIndexOf(filePath, BACK_SLASH);
    return filePath.substring(lastIndex + 1);
}

function handleOkResp(http:Client slackClient, string url) returns @tainted Error? {
    http:Response|error response = slackClient->post(url, EMPTY_STRING);
    if (response is error) {
        return setResError(response);
    }
    http:Response resp = <http:Response> response;
    var jsonResp = resp.getJsonPayload();
    if (jsonResp is error) {
        return setJsonResError(jsonResp);
    }
    json jsonPayload = <json> jsonResp;
    var checkOkResp = checkOk(jsonPayload);
}

function setResError(error errorResponse) returns Error {
    return Error(message = "Error received from the slack server", cause = errorResponse);
}

function setJsonResError(error errorResponse) returns Error {
    return Error(message = "Error occurred while accessing the JSON payload of the response", 
                        cause = errorResponse);
}
