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

string channelName = "survey-coordination";
string surveyRequestMessage = "Reply to this survey message to give input on the company";

type MessagesItem record {
    string text;
    string thread_ts;
    string ts;
    string 'type;
    string user;
    string parent_user_id?;
    string last_read?;
    int reply_count?;
    boolean subscribed?;
    int unread_count?;
};

type Response_metadata record {
    string next_cursor;
};

type RepliesResponse record {
    boolean has_more;
    MessagesItem[] messages;
    boolean ok;
    Response_metadata response_metadata;
};

final slack:Client slack = check new ({
    auth: {
        token
    }
});

public function main() returns error? {

    // Create a new channel for the survey
    json|error createChannelResponse = check slack->/conversations\.create.post({name: channelName});
    if createChannelResponse is error {
        log:printError("Error creating the survey conversation: ", createChannelResponse);
        return;
    }

    // Post a message to the conversation created and get the timestamp of the message
    json|error sendMsgResponse = slack->/chat\.postMessage.post({channel: channelName, text: surveyRequestMessage});
    if sendMsgResponse is error {
        log:printError("Error posting the survey message: ", sendMsgResponse);
        return;
    }
    string messageTimestamp = check sendMsgResponse.message.ts;

    // Check for replies to the survey message
    json|error repliesResponse = slack->/conversations\.replies({channel: channelName, ts: messageTimestamp});
    if repliesResponse is error {
        log:printError("Error getting replies to the survey message: ", repliesResponse);
        return;
    }

    RepliesResponse|error replies = repliesResponse.cloneWithType();
    if replies is error {
        log:printError("Error mapping the JSON response to the RepliesResponse type: ", replies);
        return;
    }

    // Get the messages from the replies
    MessagesItem[] messages = replies.messages;

    // Print the survey responses
    io:println("Replies to the survey message:");
    io:println("-----------------------------");
    int counter = 1;
    foreach MessagesItem message in messages {
        io:println(string `Reply ${counter}: ${message.text}`);
        counter += 1;
    }
}
