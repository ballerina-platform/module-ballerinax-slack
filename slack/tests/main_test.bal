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

import ballerina/os;
import ballerina/test;

configurable string & readonly slackToken = os:getEnv("SLACK_TOKEN");
configurable string & readonly slackUserName = os:getEnv("SLACK_USERNAME");

ConnectionConfig slackConfig = {
    auth: {
        token: slackToken
    }
};

Client slackClient = check new (slackConfig);

string channelName1 = "test-slack-connector";
string channelName2 = "channel2";
string fileId = "";
string filePath = "tests/resources/test.txt";
string threadId = "";
string userId = "";

Message messageParams = {
    channelName: channelName1,
    text: "Hello",
    attachments: [{
        "pretext": "pre-hello",
        "text": "text-world"
    }],
    blocks: [{
        "type": "section",
        "text": {
            "type": "plain_text",
            "text": "Hello world"
        }
    }]
};

UpdateMessage updateMessageParams = {
    channelName: channelName1,
    ts: "",
    text: "updated message"
};

@test:Config {}
function testGetConversationHistory() returns error? {
    stream<MessageInfo,error?>|error resultStream = slackClient->getConversationHistory(channelName1);
    if resultStream is stream<MessageInfo,error?> {        
        record {|MessageInfo value;|}|error? res = check resultStream.next(); 
        if res is record {|MessageInfo value;|} {
            test:assertEquals(res.value.'type, "message");
        }
    } else {
        test:assertFail("Error in getting stream");
    }
    return;
}

@test:Config {}
function testGetConversationMembers() returns error? {
    stream<string,error?>resultStream = check slackClient->getConversationMembers(channelName1);
    error? e = resultStream.forEach(isolated function (string memberId) {});
    if e is error {
        test:assertFail(e.message());
    }
    return;
}

@test:Config {dependsOn: [testGetConversationMembers]}
function testPostTextMessage() {
    string|error response = slackClient->postMessage(messageParams);
    if response is string {
        threadId = <@untainted>response;
        updateMessageParams.ts = threadId;
        string|error updateResponse = slackClient->updateMessage(updateMessageParams);
        if updateResponse is string {
            test:assertEquals(updateResponse, threadId);
        } else {
            test:assertFail(msg = response.toString());
        }
    } else {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    dependsOn: [testPostTextMessage]
}
function testDeleteMessage() {
    error? response = slackClient->deleteMessage(channelName1, threadId);
    if response is error {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {}
function testListConversations() {
    Conversations|error response = slackClient->listConversations();
    if response is error {
        test:assertFail(msg = response.message());
    }
}

@test:Config {}
function testGetConversationInfo() {
    Channel|error response = slackClient->getConversationInfo(channelName1);
    if response is error {
        test:assertFail(msg = response.message());
    }
}

@test:Config {}
function testGetUserInfoByUsername() {
    User|error response = slackClient->getUserInfoByUsername(slackUserName);
    if response is error {
        test:assertFail(msg = response.message());
    } else {
        userId = <@untainted>response.id;
        test:assertEquals(response.name, slackUserName);
    }
}

@test:Config {dependsOn: [testGetUserInfoByUsername]}
function testGetUserInfoByUserId() {
    User|error response = slackClient->getUserInfoByUserId(userId);
    if response is error {
        test:assertFail(msg = response.message());
    } else {
        test:assertEquals(response.name, slackUserName);
    }
}

@test:Config {
    dependsOn: [testUploadFile]
}
function testListFiles() {
    FileInfo[]|error response = slackClient->listFiles(channelName1);
    if response is error {
        test:assertFail(msg = response.message());
    }
}

@test:Config {
    dependsOn: [testUploadFile]
}
function testGetFileInfo() {
    FileInfo|error response = slackClient->getFileInfo(fileId);
    if response is error {
        test:assertFail(msg = response.message());
    } else {
        test:assertEquals(response.name, "test.txt");
    }
}

@test:Config {}
function testUploadFile() {
    FileInfo|error response = slackClient->uploadFile(filePath, channelName1);
    if response is error {
        test:assertFail(msg = response.message());
    } else {
        fileId = <@untainted>response.id;
    }
}

@test:Config {
    dependsOn: [testGetFileInfo, testListFiles]
}
function testDeleteFile() {
    error? response = slackClient->deleteFile(fileId);
    if response is error {
        test:assertFail(msg = response.message());
    }
}

@test:Config {}
function testRemoveUser() {
    error? response = slackClient->removeUserFromConversation(channelName1, slackUserName);
    if response is error {
        test:assertTrue(response.toString().includes("cant_kick_self"));
    }
}

// Commenting this test case as it grows the previousNames field of the response.
// Uncomment and test it when testing it locally.
// @test:Config {}
// function testRenameConversation() {
//     Channel|error response = slackClient->renameConversation(channelName1, channelName2);
//     if response is error {
//         test:assertFail(msg = response.toString());
//     } else {
//         test:assertEquals(response.name, channelName2);
//     }
// }
// @test:Config{
//     dependsOn: [testRenameConversation]
// }
// function renameAfterTest() {
//     Channel|error response = slackClient->renameConversation(channelName2, channelName1);
//     if response is error {
//         test:assertFail(msg = response.toString());
//     } 
// }

@test:Config {
    dependsOn: [testArchiveConversation]
}
function testUnarchiveConveration() {
    error? response = slackClient->unArchiveConversation(channelName1);
    if response is error {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {}
function testArchiveConversation() {
    error? response = slackClient->archiveConversation(channelName1);
    if response is error {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {dependsOn: [testGetUserInfoByUserId]}
function testLeaveConversation() {
    error? response = slackClient->leaveConversation(channelName1);
    if response is error {
        test:assertFail(msg = response.toString());
    }
}

@test:Config {
    dependsOn: [testLeaveConversation]
}
function testJoinConversation() {
    error? response = slackClient->joinConversation(channelName1);
    if response is error {
        test:assertFail(msg = response.message());
    }
}

@test:Config {}
function testListUserConversations() {
    Conversations|error response = slackClient->listUserConversations(noOfItems = 10, types = "public_channel", 
        user = slackUserName);
    if response is error {
        test:assertFail(msg = response.toString());
    }
}
