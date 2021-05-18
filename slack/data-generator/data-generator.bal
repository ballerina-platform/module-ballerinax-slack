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
import ballerina/io;
import ballerina/log;
import ballerinax/slack;

string slackToken = os:getEnv("SLACK_TOKEN");
string slackUserName = os:getEnv("SLACK_USERNAME");

slack:Configuration slackConfig = {
    bearerTokenConfig: {
        token: slackToken
    }
};

slack:Client slackClient = check new (slackConfig);
string connecterVersion = "0.9.8";

// Constants
string COMMA = ",";
string SQUARE_BRACKET_LEFT = "[";
string SQUARE_BRACKET_RIGHT = "]";

// Sample Channel Names
string channelName1 = "test-slack-connector";
string channelName2 = "test3";
string channelName3 = "random";

// Sample UserID's
string testUserId1 = "U0217DR97DW";
string testUserId2 = "U021LT2GGMN";
string testUserId3 = "U972U3HU2";

// Sample UserID's
string testFileId1 = "F020YB0AREF";
string testFileId2 = "F021ANLRT33";
string testFileId3 = "F022QC9P988";

string fileId = "";
string filePath = "tests/resources/test.txt";
string threadId = "";
string userId = "";

slack:Message updateMessageParams = {
    channelName: channelName1,
    threadTs: "",
    text: "updated message"
};

// Configuration related to data generation
final string rootPath = "./data/";
final string fileExtension = "_data.json";

// Output files
string MessageInfo = rootPath + "MessageInfo"+fileExtension;
string Channel = rootPath + "Channel"+fileExtension;
string Conversations = rootPath + "Conversations"+fileExtension;
string User = rootPath + "User"+fileExtension;
string FileInfo = rootPath + "FileInfo"+fileExtension;
string Message = rootPath + "Message"+fileExtension;

public function main() returns error? {
    _ = check generateMessageInfoData();
    _ = check generateMessageData();
    _ = check generateChannelInfoData();
    _ = check generateConversationsData();
    _ = check generateUserData();
    _ = check generateFileInfoData();
}

function generateMessageInfoData() returns error? {
    log:printInfo("SampleDataGenerator -> generateMessageInfoData()");
    stream<slack:MessageInfo,error>|error? resultStream = slackClient->getConversationHistory(channelName1);
    if (resultStream is stream<slack:MessageInfo,error>) {        
        record {|slack:MessageInfo value;|} res1 = check resultStream.next();
        record {|slack:MessageInfo value;|} res2 = check resultStream.next();
        record {|slack:MessageInfo value;|} res3 = check resultStream.next();

        string array = SQUARE_BRACKET_LEFT + res1?.value.toJsonString() + COMMA 
                                + res2?.value.toJsonString() + COMMA + res3?.value.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
        string preparedJson = "{"+"\"ballerinax/slack:"+connecterVersion+":MessageInfo\""+":"+array+"}";
        check io:fileWriteJson(MessageInfo, check preparedJson.cloneWithType(json));         
    }
}
function generateChannelInfoData() returns error? {
    log:printInfo("SampleDataGenerator -> generateChannelInfoData()");
    slack:Channel res1 = check slackClient->getConversationInfo(channelName1);
    slack:Channel res2 = check slackClient->getConversationInfo(channelName2);
    slack:Channel res3 = check slackClient->getConversationInfo(channelName3);
    
    string array = SQUARE_BRACKET_LEFT + res1.toJsonString() + COMMA 
                                + res2.toJsonString() + COMMA + res3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/slack:"+connecterVersion+":Channel\""+":"+array+"}";
    check io:fileWriteJson(Channel, check preparedJson.cloneWithType(json));
}
function generateConversationsData() returns error? {
    log:printInfo("SampleDataGenerator -> generateConversationsData()");
    slack:Conversations res1 = check slackClient->listConversations();
    string array = SQUARE_BRACKET_LEFT + res1.toJsonString() + COMMA 
                                + res1.toJsonString() + COMMA + res1.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/slack:"+connecterVersion+":Conversations\""+":"+array+"}";
    check io:fileWriteJson(Conversations, check preparedJson.cloneWithType(json));
}

function generateUserData() returns error? {
    log:printInfo("SampleDataGenerator -> generateUserData()");
    slack:User? res1 = check slackClient->getUserInfoByUserId(testUserId1);
    slack:User? res2 = check slackClient->getUserInfoByUserId(testUserId2);
    slack:User? res3 = check slackClient->getUserInfoByUserId(testUserId3);

    string array = SQUARE_BRACKET_LEFT + res1.toJsonString() + COMMA 
                                + res2.toJsonString() + COMMA + res3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/slack:"+connecterVersion+":User\""+":"+array+"}";
    check io:fileWriteJson(User, check preparedJson.cloneWithType(json));
}

function generateFileInfoData() returns error? {
    log:printInfo("SampleDataGenerator -> generateFileInfoData()");
    var res1 = check slackClient->uploadFile(MessageInfo);
    var res2 = check slackClient->uploadFile(Channel);
    var res3 = check slackClient->uploadFile(User);

    string array = SQUARE_BRACKET_LEFT + res1.toJsonString() + COMMA 
                                + res2.toJsonString() + COMMA + res3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/slack:"+connecterVersion+":FileInfo\""+":"+array+"}";
    check io:fileWriteJson(FileInfo, check preparedJson.cloneWithType(json));
}
function generateMessageData() returns error? {
    log:printInfo("SampleDataGenerator -> generateMessageData()");
    slack:Message messageParams1 = {
        channelName: channelName1,
        text: "Hello123",
        attachments: [{
            "pretext": "pre-hello123",
            "text": "text-world123"
        }],
        blocks: [{
            "type": "section",
            "text": {
                "type": "plain_text123",
                "text": "Hello world123"
            }
        }]
    };
    slack:Message messageParams2 = {
        channelName: channelName1,
        text: "Hello456",
        attachments: [{
            "pretext": "pre-hello123",
            "text": "text-world123"
        }],
        blocks: [{
            "type": "section",
            "text": {
                "type": "plain_text123",
                "text": "Hello world123"
            }
        }]
    };
    slack:Message messageParams3 = {
        channelName: channelName1,
        text: "Hello789",
        attachments: [{
            "pretext": "pre-hello455",
            "text": "text-world456"
        }],
        blocks: [{
            "type": "section",
            "text": {
                "type": "plain_text456",
                "text": "Hello world456"
            }
        }]
    };

    string array = SQUARE_BRACKET_LEFT + messageParams1.toJsonString() + COMMA 
                                + messageParams2.toJsonString() + COMMA + messageParams3.toJsonString() 
                                + SQUARE_BRACKET_RIGHT;
    string preparedJson = "{"+"\"ballerinax/slack:"+connecterVersion+":Message\""+":"+array+"}";
    check io:fileWriteJson(Message, check preparedJson.cloneWithType(json));
}
