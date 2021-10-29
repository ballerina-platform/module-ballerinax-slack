
// Copyright (c) 2021 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

class ConversationHistoryStream {
    private MessageInfo[] currentEntries = [];
    private int index = 0;
    private final http:Client httpClient;
    private string channelId;
    private string? startOfTimeRange;
    private string? endOfTimeRange;
    private string? nextCursor;

    isolated function init(http:Client httpClient, string channelId, string? startOfTimeRange, string? endOfTimeRange) 
            returns error? {
        self.httpClient = httpClient;
        self.channelId = channelId;
        self.startOfTimeRange = startOfTimeRange;
        self.endOfTimeRange = endOfTimeRange;
        self.nextCursor = ();
        self.currentEntries =  check self.fetchMessages();
        return;
    }

    public isolated function next() returns @tainted record {| MessageInfo value; |}|error? {
        if (self.index < self.currentEntries.length()) {
            record {| MessageInfo value; |} message = {value: self.currentEntries[self.index]};
            self.index += 1;
            return message;
        }

        if (self.nextCursor is string) {
            self.index = 0;
            self.currentEntries = check self.fetchMessages();
            record {| MessageInfo value; |} message = {value: self.currentEntries[self.index]};
            self.index += 1;
            return message;
        }
        return;
    }

    isolated function fetchMessages() returns @tainted MessageInfo[]|error {
        string url = GET_CONVERSATION_HISTORY_PATH + self.channelId;
        if (self.nextCursor is string) {
            url = url + CURSOR + self.nextCursor.toString();
        }
        if (self.startOfTimeRange is string) {
            url = url + OLDEST + self.startOfTimeRange.toString();
        }
        if (self.endOfTimeRange is string) {
            url = url + LATEST + self.endOfTimeRange.toString();
        }
        if (self.startOfTimeRange is string || self.endOfTimeRange is string) {
            url = url + INCLUSIVE;
        }
        http:Response response = check self.httpClient->get(url); 
        json payload = check response.getJsonPayload();
        _ = check checkOk(payload); 
        convertJsonToCamelCase(payload);
        ConversationHistoryResponse res = check payload.cloneWithType(ConversationHistoryResponse);
        if (res.hasMore === true) {
            var responseMetadata = check payload.responseMetadata;
            self.nextCursor = check responseMetadata.nextCursor;
        } else {
            self.nextCursor = ();
        }
        return res.messages;
    }
}

class ConversationMembersStream {
    private string[] currentEntries = [];
    private int index = 0;
    private final http:Client httpClient;
    private string channelId;
    private string? nextCursor;

    isolated function init(http:Client httpClient, string channelId) returns error? {
        self.httpClient = httpClient;
        self.channelId = channelId;
        self.nextCursor = ();
        self.currentEntries =  check self.fetchMembers();
        return;
    }

    public isolated function next() returns @tainted record {| string value; |}|error? {
        if (self.index < self.currentEntries.length()) {
            record {| string value; |} member = {value: self.currentEntries[self.index]};
            self.index += 1;
            return member;
        }

        if (self.nextCursor is string) {
            self.index = 0;
            self.currentEntries = check self.fetchMembers();
            record {| string value; |} member = {value: self.currentEntries[self.index]};
            self.index += 1;
            return member;
        }
        return;
    }

    isolated function fetchMembers() returns @tainted string[]|error {
        string url = GET_CONVERSATION_MEMBERS_PATH + self.channelId;
        if (self.nextCursor is string) {
            url = url + CURSOR + self.nextCursor.toString();
        }
        http:Response response = check self.httpClient->get(url); 
        json payload = check response.getJsonPayload();
        _ = check checkOk(payload); 
        convertJsonToCamelCase(payload);
        ConversationMembersResponse res = check payload.cloneWithType(ConversationMembersResponse);
        string nextCursor = res.responseMetadata.nextCursor;
        if (nextCursor !== EMPTY_STRING) {
            self.nextCursor = nextCursor;
        } else {
            self.nextCursor = ();
        }
        return res.members;
    }
}
