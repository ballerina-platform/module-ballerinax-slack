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
import ballerina/regex;
import ballerina/url;

isolated function getChannelId(http:Client slackClient, string channelName) returns @tainted string|error {
    http:Response response = <http:Response> check slackClient->get(LIST_CONVERSATIONS_PATH);
    json channelList = check response.getJsonPayload();
    map<json> channelListJson = <map<json>> channelList;
    var checkOkResp = check checkOk(channelListJson);
    json channels = check channelListJson.channels;

    json[] channelsArr = <json[]> channels;
    foreach var ch in channelsArr {
        if (ch.name === channelName) {
            return <string> check ch.id;
        }
    }
    return error("Channel " + channelName + " does not exist");
}

isolated function archiveConversation(http:Client slackClient, string channelId) returns @tainted error? {
    string url = ARCHIVE_CHANNEL_PATH + channelId;
    return handleArchiveResponse(slackClient, url);
}

isolated function unArchiveConversation(http:Client slackClient, string channelId) returns @tainted error? {
    string url = UNARCHIVE_CHANNEL_PATH + channelId;
    return handleArchiveResponse(slackClient, url);
}

isolated function handleArchiveResponse(http:Client slackClient, string url) returns @tainted error? {
    http:Response response = <http:Response> check slackClient->post(url, EMPTY_STRING);
    json payload = check response.getJsonPayload();
    var checkOk = check checkOk(payload);       
}

isolated function getUserIds(http:Client slackClient, string[] users) returns @tainted string|error {
    string usersList = EMPTY_STRING;
    http:Response response = <http:Response> check slackClient->get(LIST_USERS_PATH);
    json payload = check response.getJsonPayload();
    map<json> jsonPayload = <map<json>> payload;
    var checkOk = check checkOk(jsonPayload);
    json members = check jsonPayload.members;
    json[] memberList = <json[]> members;
    foreach var user in users {
        foreach var member in memberList {
            if (member.name === user) {
                string memberId = <string> check member.id;
                usersList = usersList + memberId + ",";
            }
        }
    } 
    if (usersList == EMPTY_STRING) {
        return error("Unable to find user ids of the given users");
    }
    return usersList;
}

isolated function getUserId(http:Client slackClient, string user) returns @tainted string|error {
    http:Response response = <http:Response> check slackClient->get(LIST_USERS_PATH);
    json payload = check response.getJsonPayload();
    map<json> jsonPayload = <map<json>> payload;
    var checkOk = check checkOk(jsonPayload);
    json members = check jsonPayload.members;
    json[] memArr = <json[]> members;
    foreach var member in memArr {
        if (member.name === user) {
            return <string> check (member.id);
        }
    } 
    return error("Unable to find the user id for the user " + user);
}

isolated function listConversationsOfUser(http:Client slackClient, string user, boolean excludeArchived, 
                                         int? noOfItems = (), string? types = ()) returns @tainted Conversations|error {
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
    http:Response response = <http:Response> check slackClient->get(url);
    json payload = check response.getJsonPayload();
    var checkOk = check checkOk(payload);
    return mapConversationInfo(payload);      
}

isolated function removeUserFromConversation(http:Client slackClient, string user, string channelId) 
                                             returns @tainted error? {
    string url = KICK_USER_FROM_CHANNEL_PATH + channelId + USER_ARG + user;
    return handleOkResp(slackClient, url);
}

isolated function inviteUsersToConversation(http:Client slackClient, string channelId, string users) 
                                            returns @tainted error|Channel {
    string url = INVITE_USERS_TO_CHANNEL_PATH + channelId + USER_IDS_ARG + users;
    http:Response response = <http:Response> check slackClient->post(url, EMPTY_STRING);
    json payload = check response.getJsonPayload();
    var checkOk = check checkOk(payload);
    return mapChannelInfo(response);
}

isolated function getConversationInfo(http:Client slackClient, string channelId, boolean? includeLocale = false,
                                      boolean? memberCount = false) returns @tainted Channel|error {
    string url = GET_CONVERSATION_INFO_PATH + channelId + INCLUDE_LOCALE + includeLocale.toString() + 
                    INCLUDE_NUM_MEMBERS + memberCount.toString();
    http:Response|http:PayloadType|error response = slackClient->get(url);
    if (response is error) {
        return setResError(response);
    } else {
        http:Response resp = <http:Response> response;
        return mapChannelInfo(resp);
    }
}

isolated function lookupUserByEmail(http:Client slackClient, string email) returns @tainted User|error? {
    string url = LOOKUP_BY_EMAIL_PATH + email;
    http:Response response = check slackClient->get(url);
    json payload = check response.getJsonPayload();
    _ = check checkOk(payload);
    json user = check payload.user;
    convertJsonToCamelCase(user);
    return check user.cloneWithType(User);
}

isolated function postMessage(http:Client slackClient, string channelId, Message message) 
                              returns @tainted string|error {    
    string url = POST_MESSAGE_PATH + channelId + createQuery(message);
    return handlePostMessage(slackClient, url);
}

isolated function createQuery(Message message) returns string {  
    string queryString = "";  
    foreach [string, any] [key, value] in message.entries() {
        if (key != CHANNEL_NAME) {
            if (key == BLOCKS || key == ATTACHMENTS) {
                queryString = queryString + AND + fillWithUnderscore(key) + EQUAL + getEncodedUri(value.toJsonString());
            } else {
                queryString = queryString + AND + fillWithUnderscore(key) + EQUAL + getEncodedUri(value.toString());
            }              
        }      
    }
    return queryString;
}

isolated function getEncodedUri(string value) returns string {
    string|error encoded = url:encode(value, UTF8);
    if (encoded is string) {
        return encoded;
    } else {
        return value;
    }
}

isolated function fillWithUnderscore(string camelCaseString) returns string {
    string stringWithUnderScore = regex:replaceAll(camelCaseString, "([A-Z])", "_$1");
    return stringWithUnderScore.toLowerAscii();
}

isolated function updateMessage(http:Client slackClient, string channelId, Message message) 
                                returns @tainted string|error {
    string updateQuery = createQuery(message);
    updateQuery = regex:replaceAll(updateQuery, THREAD_TS_ARG, THREAD_TS_ARG_FOR_UPDATING);    
    string url = UPDATE_MESSAGE_PATH + channelId + updateQuery;
    return handlePostMessage(slackClient, url);
}

isolated function handlePostMessage(http:Client slackClient, string url) returns @tainted string|error {
    http:Response response = <http:Response> check slackClient->post(<@untainted> url, EMPTY_STRING);
    json payload = check response.getJsonPayload();
    var okResp = check checkOk(payload);
    json threadId = check payload.ts;
    return threadId.toString();
}

isolated function createChannel(http:Client slackClient, string url) returns @tainted Channel|error {
    http:Response|http:PayloadType|error response = slackClient->post(url, EMPTY_STRING);
    if (response is http:Response) {
        return mapChannelInfo(response);
    } else if (response is http:PayloadType) {
        return error("Response cannot be in http payload");
    } else {
        return setResError(response);
    }
}

isolated function mapChannelInfo(http:Response response) returns @tainted Channel|error {
    json payload = check response.getJsonPayload();
    json ok = check payload.ok;
    if (ok == true) {                    
        var ch = payload.'channel;
        if (ch is map<json>) {
            convertJsonToCamelCase(ch);
            Channel|error slackCh = ch.cloneWithType(Channel);
            if (slackCh is error) {
                return error("Channel does not exist", slackCh);
            } else {
                return slackCh;
            }            
        } else {
            return error("Channel does not exist");
        }
    } else {
        return error("Retrieving channel information failed: " + <string> check (payload.'error));
    }    
}

isolated function mapConversationInfo(json channelList) returns Conversations|error {
    convertJsonToCamelCase(channelList);
    var conversations = channelList.cloneWithType(Conversations);
    if (conversations is error) {
        return error("Response cannot be converted to Conversations record", conversations);
    } else {
        return conversations;
    }
}

isolated function joinConversation(http:Client slackClient, string channelId) returns @tainted error? {
    string url = CONVERSATIONS_JOIN_PATH + channelId;
    return handleOkResp(slackClient, url);
}

isolated function leaveConversation(http:Client slackClient, string channelId) returns @tainted error? {
    string url = LEAVE_CHANNEL_PATH + channelId;
    return handleOkResp(slackClient, url);
}

isolated function getUserInfo(http:Client slackClient, string userId) returns @tainted error|User {
    string url = GET_USER_INFO_PATH + userId;
    http:Response response = <http:Response> check slackClient->get(url);
    json userInfo = check response.getJsonPayload();
    var checkOk = check checkOk(userInfo);
    json user = check userInfo.user;
    convertJsonToCamelCase(user);
    var  userRec = user.cloneWithType(User);
    if (userRec is error) {
        return error("Response cannot be converted to User record", userRec);
    } else {
        return userRec;
    }
}

isolated function renameConversation(http:Client slackClient, string channelId, string newName) returns @tainted 
            Channel|error {
    string url = RENAME_CHANNEL_PATH + channelId + NAME_ARG + newName;
    http:Response|http:PayloadType|error response = slackClient->post(url, EMPTY_STRING);
    if (response is http:Response) {
        return mapChannelInfo(response);
    } else if (response is http:PayloadType) {       
        return error("Response cannot be in http payload");
    } else {
        return setResError(response);
    }
}

isolated function checkOk(json respPayload) returns error? {
    json|error ok = respPayload.ok;
    if (ok is error) {
        return setJsonResError(ok);
    }
    if (ok === false) {
        json|error errorRes = respPayload.'error;
        if (errorRes is json) {
            return error(errorRes.toString());
        }
    }
}

isolated function deleteMessage(http:Client slackClient, string channelId, string threadTs) returns @tainted error? {
    string url = DELETE_CONVERSATION_PATH + channelId + DELETE_CONVERSATION_TS_ARG + threadTs;
    return handleOkResp(slackClient, url);
}

isolated function deleteFile(http:Client slackClient, string fileId) returns @tainted error? {
    string url = DELETE_FILE_PATH + fileId;
    return handleOkResp(slackClient, url);
}

isolated function listFiles(http:Client slackClient, string? channelId, int? count, string? tsFrom, string? tsTo, 
                            string? types, string? user) returns @tainted FileInfo[]|error {
    string url = LIST_FILES_PATH;
    if (channelId is string && channelId != EMPTY_STRING) {
        url = url + CHANNEL_ARG + channelId;
    }
    if (count is int) {
        url = (string:includes(url, QUESTION_MARK)) ? url + COUNT_AS_SECOND_PARAM + count.toString() : 
                url + COUNT_AS_FIRST_PARAM + count.toString();
    }  
    if (tsFrom is string) {
        url = (!string:includes(url, QUESTION_MARK)) ? url + TS_FROM_AS_FIRST_PARAM + tsFrom.toString() : 
                url + TS_FROM_AS_SECOND_PARAM + tsFrom.toString();
    }
    if (tsTo is string) {
        url =  (string:includes(url, QUESTION_MARK)) ? url + TS_TO_AS_SECOND_PARAM + tsTo.toString() : 
                url + TS_TO_AS_FIRST_PARAM + tsTo.toString();
    }    
    if (types is string) {
        url = (string:includes(url, QUESTION_MARK)) ? url + TYPES_AS_SECOND_PARAM + types.toString() :     
                url + TYPES_AS_FIRST_PARAM + types.toString();
    }  
    if (user is string && user != EMPTY_STRING) {
        url = (string:includes(url, QUESTION_MARK)) ? url + USER_AS_SECOND_PARAM + user.toString() : 
                url + USER_AS_FIRST_PARAM + user.toString();
    }         
    http:Response response = <http:Response> check slackClient->post(url, EMPTY_STRING);
    json fileList = check response.getJsonPayload();
    var checkOk = check checkOk(fileList);
    json files = check fileList.files;
    json[] fileJson = <json[]> files;
    convertJsonArrayToCamelCase(fileJson);
    var fileRec = fileJson.cloneWithType(FileInfoArray);
    if (fileRec is error) {
        return error("Response cannot be converted to FileInfo array", fileRec);
    } else {
        return fileRec;
    }
}

isolated function uploadFile(string filePath, http:Client slackClient, string? channelId, string? title = (), 
                             string? initialComment = (), string? threadTs = ()) returns @tainted FileInfo|error {
    string url = UPLOAD_FILES_PATH;
    if (channelId is string) {
        url = url + CHANNELS_PARAM + channelId;
    }
    if (title is string) {
        url = (string:includes(url, QUESTION_MARK)) ? (url + TITLE_AS_SECOND_PARAM + title) : 
                url + TITLE_AS_FIRST_PARAM + title;
    }  
    if (initialComment is string) {
        url = (string:includes(url, QUESTION_MARK)) ? (url + INITIAL_COMMENT_AS_SECOND_PARAM + initialComment) : 
                url + INITIAL_COMMENT_AS_FIRST_PARAM + initialComment;
    }
    if (threadTs is string) {
        url = (string:includes(url, QUESTION_MARK)) ? (url + THREAD_TS_AS_SECOND_PARAM + threadTs) : 
                url + THREAD_TS_AS_FIRST_PARAM + threadTs;
    }              
    http:Request request = new;
    mime:Entity filePart = new;
    filePart.setContentDisposition(getContentDispositionForFormData(FILE, filePath));

    filePart.setFileAsEntityBody(filePath);
    mime:Entity[] bodyParts = [<@untainted> filePart];
    request.setBodyParts(bodyParts, contentType = mime:MULTIPART_FORM_DATA);
    http:Response response = <http:Response> check slackClient->post(url, request);

    json fileInfo = check response.getJsonPayload();
    json fileInfoPayload = fileInfo;  
    var checkOk = check checkOk(fileInfoPayload);    
    json file = check fileInfoPayload.file;
    convertJsonToCamelCase(file);
    var fileRec = file.cloneWithType(FileInfo);
    if (fileRec is error) {
        return error("Unable to convert the response to FileInfo record", fileRec);
    } else {
        return fileRec;
    }
}

isolated function getFileInfo(http:Client slackClient, string fileId) returns @tainted FileInfo|error {
    string url = GET_FILE_INFO_PATH + fileId;
    http:Response response = <http:Response> check slackClient->get(url);
    json fileInfo = check response.getJsonPayload();
    var checkOk = check checkOk(fileInfo);
    var file = fileInfo.file;
    if (file is error) {
        return setJsonResError(file);
    }
    json fileJson = <json> check file;
    convertJsonToCamelCase(fileJson);
    var fileRec = fileJson.cloneWithType(FileInfo);
    if (fileRec is error) {
        return error("Unable to convert the response to FileInfo record", fileRec);
    } else {
        return fileRec;
    }
}

isolated function getContentDispositionForFormData(string partName, string filePath) returns (mime:ContentDisposition) {
    mime:ContentDisposition contentDisposition = new;
    contentDisposition.name = partName;
    contentDisposition.disposition = DISPOSITION;
    contentDisposition.fileName = getFileName(filePath);
    return contentDisposition;
}

isolated function getFileName(string filePath) returns string {
    int? lastIndex = string:lastIndexOf(filePath, BACK_SLASH);
    if (lastIndex is int) {
        return filePath.substring(lastIndex + 1);
    } else {
        return filePath;
    }
}

isolated function handleOkResp(http:Client slackClient, string url) returns @tainted error? {
    http:Response response = <http:Response> check slackClient->post(url, EMPTY_STRING);
    json payload = check response.getJsonPayload();
    error? checkOkResp = checkOk(payload);
}

isolated function setResError(error errorResponse) returns error {
    return error("Error received from the slack server", errorResponse);
}

isolated function setJsonResError(error errorResponse) returns error {
    return error("Error occurred while accessing the JSON payload of the response", errorResponse);
}

isolated function convertJsonToCamelCase(json req) {
    map<json> mapValue = <map<json>>req;
    foreach var [key, value] in mapValue.entries() {
        string converted = convertToCamelCase(key);
        if (converted != key) {
            any|error removeResult = mapValue.remove(key);
            mapValue[converted] = value;
        }
        if (value is json[]) {
            json[] innerJson = <json[]>mapValue[converted];
            foreach var item in innerJson {
                // assume no arrays inside array
                if (item is map<json>) {
                    convertJsonToCamelCase(item);
                }
            }
        } else if (value is map<json>) {
            convertJsonToCamelCase(value);
        }
    }
}

isolated function convertJsonArrayToCamelCase(json[] jsonArr) {
    foreach var item in jsonArr {
        convertJsonToCamelCase(item);
    }
}

isolated function convertToCamelCase(string input) returns string {
    string returnResult = "";
    string[] splitResult = regex:split(input, "_");
    int i = 0;
    foreach var item in splitResult {
        if (i == 0) {
            returnResult = item;
        } else {
            returnResult = returnResult + item.substring(0,1).toUpperAscii() + item.substring(1, item.length());
        }
        i = i + 1;
    }
    return returnResult;
}
