// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.org).
//
// WSO2 LLC. licenses this file to you under the Apache License,
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

import ballerina/log;
import ballerina/os;
import ballerina/test;

configurable boolean isLiveServer = os:getEnv("IS_LIVE_SERVER") == "true";
configurable string token = isLiveServer ? os:getEnv("SLACK_TOKEN") : "test";
configurable string serviceUrl = isLiveServer ? "https://slack.com/api" : "http://localhost:9090/";

ConnectionConfig slackConfig = {
    auth: {
        token
    }
};

Client slack = test:mock(Client);

@test:BeforeSuite
function setup() returns error? {
    if (isLiveServer) {
        log:printInfo("Running tests on actual server");
    } else {
        log:printInfo("Running tests on mock server");
    }

    slack = check new (slackConfig, serviceUrl);
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetPresence() returns error? {
    APIMethodUsersGetPresence response = check slack->/users\.getPresence();
    test:assertTrue(response.ok, "The ok attribute was not equal to true");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testPostMessage() returns error? {
    ChatPostMessageResponse response = check slack->/chat\.postMessage.post({channel: "general"});
    test:assertTrue(response.ok, "The ok attribute should be true");
    test:assertEquals(response.message.text, "This is a Test", "The message text is not equal to the expected value");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetUsersList() returns error? {
    UsersListResponse response = check slack->/users\.list();
    test:assertTrue(response.ok, "The ok attribute should be true");
}

@test:Config {
    groups: ["mock_tests"]
}
function testLookupUserByEmail() returns error? {
    UsersLookupByEmailResponse response = check slack->/users\.lookupByEmail(email = "jdoe@example.com");
    test:assertTrue(response.ok, "The ok attribute should be true");
    test:assertEquals(response.user.id, "U0123ABCDEF", "The user id is not equal to the expected value");
    test:assertEquals(response.user?.tz, "Asia/Colombo", "The user timezone is not equal to the expected value");
}

@test:Config {
    groups: ["mock_tests"]
}
function testGetUserInfo() returns error? {
    UsersInfoResponse response = check slack->/users\.info(user = "USLACKBOT");
    test:assertTrue(response.ok, "The ok attribute should be true");
    test:assertEquals(response.user.id, "USLACKBOT", "The user id is not equal to the expected value");
    test:assertEquals(response.user.profile?.fields, {}, "The profile fields should be an empty object");
}

@test:Config {
    groups: ["live_tests", "mock_tests"]
}
function testGetUserProfiles() returns error? {
    UsersProfileGetResponse response = check slack->/users\.profile\.get();
    test:assertTrue(response.ok, "The ok attribute should be true");
}

@test:Config {
    groups: ["mock_tests"]
}
function testGetRepliesOfMessageWithoutThread() returns error? {
    ConversationsRepliesResponse response = check slack->/conversations\.replies(channel = "D0C3BBBA890", ts = 1792462400.691309d);
    test:assertTrue(response.ok, "The ok attribute should be true");
    test:assertEquals(response.messages.length(), 1, "Only the requested message should be returned");
    test:assertEquals(response.messages[0].text, "A message without replies", "The message text is not equal to the expected value");
    test:assertEquals(response.messages[0]?.thread_ts, (), "A message without replies should not have a thread_ts");
}

@test:Config {
    groups: ["mock_tests"]
}
function testGetRepliesOfUserThread() returns error? {
    ConversationsRepliesResponse response = check slack->/conversations\.replies(channel = "D0C3BBBA890", ts = 1792466505.885929d);
    test:assertEquals(response.messages.length(), 2, "The parent and its reply should be returned");
    map<anydata> parent = response.messages[0];
    map<anydata> reply = response.messages[1];
    test:assertEquals(parent["reply_count"], 1, "The parent should keep its reply count");
    test:assertFalse(parent.hasKey("parent_user_id"), "The parent should not have a parent_user_id");
    test:assertEquals(reply["parent_user_id"], "U0C3F40S9EG", "The reply should keep its parent_user_id");
}

@test:Config {
    groups: ["mock_tests"]
}
function testGetRepliesOfWebhookThread() returns error? {
    ConversationsRepliesResponse response = check slack->/conversations\.replies(channel = "D0C7HQ67RA4", ts = 1792466432.867219d);
    test:assertEquals(response.messages.length(), 2, "The parent and its reply should be returned");
    foreach var message in response.messages {
        map<anydata> fields = message;
        test:assertFalse(fields.hasKey("user"), "A message posted by an incoming webhook should not have a user");
        test:assertEquals(fields["bot_id"], "B0CA360244X", "The message should keep the webhook's bot_id");
        test:assertEquals(fields["subtype"], "bot_message", "The message should keep its bot_message subtype");
    }
    test:assertEquals(response.messages[1]?.thread_ts, "1792466432.867219", "The reply should keep its thread_ts");
}

@test:Config {
    groups: ["mock_tests"]
}
function testUpdateMessage() returns error? {
    ChatUpdateResponse response = check slack->/chat\.update.post({
        channel: "D0C3BBBA890",
        ts: "1792465147.962269",
        text: "Edited by the Ballerina connector test <https://ballerina.io>"
    });
    test:assertTrue(response.ok, "The ok attribute should be true");
    test:assertEquals(response.message.text, "Edited by the Ballerina connector test <https://ballerina.io>", "The message text is not equal to the expected value");
    record {}[]? blocks = response.message?.blocks;
    test:assertTrue(blocks is record {}[] && blocks.length() == 1, "The message should have one block");
}
