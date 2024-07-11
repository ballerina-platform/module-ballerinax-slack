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

import ballerina/io;
import ballerina/log;
import ballerinax/slack;

configurable string token = ?;

const CHANNEL_NAME = "survey-coordination";
const SURVEY_REQUEST_MSG = "Reply to this survey message to give input on the company";

final slack:Client slack = check new ({
    auth: {
        token
    }
});

public function main() returns error? {

    // Create a new channel for the survey
    slack:ConversationsCreateResponse|error createChannelResponse = slack->/conversations\.create.post({name: CHANNEL_NAME});
    if createChannelResponse is error {
        log:printError("Error creating the survey conversation: " + createChannelResponse.message());
        return;
    }

    // Post a message to the conversation created and get the timestamp of the message
    slack:ChatPostMessageResponse|error sendMsgResponse = slack->/chat\.postMessage.post({channel: CHANNEL_NAME, text: SURVEY_REQUEST_MSG});
    if sendMsgResponse is error {
        log:printError(sendMsgResponse.message());
        return;
    }
    string messageTimestamp = sendMsgResponse.message.ts;

    // Check for replies to the survey message
    slack:ConversationsRepliesResponse|error repliesResponse = slack->/conversations\.replies({channel: CHANNEL_NAME, ts: messageTimestamp});
    if repliesResponse is error {
        log:printError(repliesResponse.message());
        return;
    }

    // Get the messages from the replies
    var messages = repliesResponse.messages;

    // Print the survey responses
    io:println("Replies to the survey message:");
    io:println("-----------------------------");
    int counter = 1;
    foreach var message in messages {
        io:println(string `Reply ${counter}: ${message.toString()}`);
        counter += 1;
    }
}
