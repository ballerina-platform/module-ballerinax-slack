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

import ballerina/test;
//import ballerina/system;
import ballerina/config;

string token = config:getAsString("SLACK_TOKEN");

Configuration slackConfig1 = {
    oauth2Config: {
        accessToken: token
    }
};

Client slackClient = new(slackConfig1);
ConversationClient convClient = slackClient.getConversationClient();
ChatClient chatClient = slackClient.getChatClient();
FileClient fileClient = slackClient.getFileClient();
UserClient userClient = slackClient.getUserClient();

string channelName1 = "test-slack-connector";
string channelName2 = "channel2";
string channelId = "CU31FE5EC";
string userName = config:getAsString("SLACK_USERNAME");
string fileId = "";
string filePath = "tests/resources/test.txt";
string threadId = "";

Message messageParams = {
    channelName: "test-slack-connector",
    text: "Hello",
    attachments: [{"pretext": "pre-hello", "text": "text-world"}],
    blocks: [{"type": "section", "text": {"type": "plain_text", "text": "Hello world"}}]
};

Message udateMessageParams = {
    channelName: "test-slack-connector",
    threadTs: "",
    text: "updated message"
};

@test:Config {
    after: "deleteMessageAfterTest"
}
function testPostTextMessage() {
    var response = chatClient->postMessage(messageParams);
    if (response is string) {
        threadId = <@untainted> response;
        udateMessageParams.threadTs = threadId;
        var updateResponse = chatClient->updateMessage(udateMessageParams);
        if (updateResponse is string) {
            test:assertEquals(updateResponse, threadId);
        } else {
            test:assertFail(msg = response.toString());
        }
    } else {
        test:assertFail(msg = response.message());
    }
}

function deleteMessageAfterTest() {
    var response = chatClient->deleteMessage(channelName1, threadId);
    if (response is error) {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {}
function testListConversations() {
    var response = convClient->listConversations();
    if (response is error) {
        test:assertFail(msg = response.message());
    } 
}

@test:Config {}
function testGetConversationInfo() {
    var response = convClient->getConversationInfo(channelName1);
    if (response is error) {
        test:assertFail(msg = response.message());
    } 
}

@test:Config {}
function testGetUserInfo() {
    var response = userClient->getUserInfo(userName);
    if (response is error) {
        test:assertFail(msg = response.message());
    } else {
        test:assertEquals(response.name, userName);
    }
}

@test:Config {
    before:"uploadFileToTest",
    after: "deleteFileAfterTest"
}
function testListFiles() {
    var response = fileClient->listFiles(channelName1);
    if (response is error) {
        test:assertFail(msg = response.message());
    } 
}

@test:Config {
    before:"uploadFileToTest",
    after: "deleteFileAfterTest"
}
function testGetFileInfo() {
    var response = fileClient->getFileInfo(fileId);
    if (response is error) {
        test:assertFail(msg = response.message());
    } else {
        test:assertEquals(response.name, "test.txt");
    }
}

function uploadFileToTest() {
    var response = fileClient->uploadFile(filePath, channelName1);
    if (response is error) {
        test:assertFail(msg = response.message());
    } else {
        fileId = <@untainted> response.id;
    }
}

function deleteFileAfterTest() {
    var response = fileClient->deleteFile(fileId);
    if (response is error) {
        test:assertFail(msg = response.message());
    } 
}

@test:Config {}
function testRemoveUser() {
    var response = convClient->removeUserFromConversation(channelName1, userName);
    if (response is error) {
        test:assertEquals(response.toString(), "error cant_kick_self ");
    } 
}

// Commenting this test case as it grows the previousNames field of the response.
// Uncomment and test it when testing it locally.
// @test:Config {
//     after: "renameAfterTest"
// }
// function testRenameConversation() {
//     var response = convClient->renameConversation(channelName1, channelName2);
//     if (response is error) {
//         test:assertFail(msg = response.toString());
//     } else {
//         test:assertEquals(response.name, channelName2);
//     }
// }

// function renameAfterTest() {
//     var response = convClient->renameConversation(channelName2, channelName1);
//     if (response is error) {
//         test:assertFail(msg = response.toString());
//     } 
// }

@test:Config {
    before: "archiveConvToUseInTests"
}
function testUnarchiveConveration() {
    var response = convClient->unArchiveConversation(channelName1);
    if (response is error) {
        test:assertFail(msg = response.toString());
    } 
}

function archiveConvToUseInTests() {
    var response = convClient->archiveConversation(channelName1);
    if (response is error) {
        test:assertFail(msg = response.toString());
    } 
}

@test:Config {
    after: "testJoinConversation"
}
function testLeaveConveration() {
    var response = convClient->leaveConversation(channelName1);
    if (response is error) {
        test:assertFail(msg = response.toString());
    } 
}

function testJoinConversation() {
    var response = convClient->joinConversation(channelName1);
    if (response is error) {
        test:assertFail(msg = response.message());
    } 
}

@test:Config {}
function testListConverationsOfAUser() {
    var response = userClient->listConversations(noOfItems = 10, types = "public_channel", user = userName);
    if (response is error) {
        test:assertFail(msg = response.toString());
    } 
}
