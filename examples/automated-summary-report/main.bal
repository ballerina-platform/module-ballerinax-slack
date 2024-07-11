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

import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerinax/slack;

configurable string token = ?;

// Initialize the Slack client with the provided token.
final slack:Client slack = check new Client({
    auth: {
        token
    }
});

public function main() returns error? {
    // Fetch the list of channels.
    slack:ConversationsListResponse channelResponse = check slack->/conversations\.list();

    // Array to store the latest text messages from each channel.
    string[] latestText;

    // Iterate through each channel to get the latest message.
    foreach slack:ConversationObj channel in channelResponse.channels {
        // Fetch the conversation history for the current channel.
        slack:ConversationsHistoryResponse historyResponse = check slack->/conversations\.history({channel: channel.toString()});

        // Get the latest text message from the conversation history.
        slack:MessageObj[] messages = historyResponse.messages;
        latestText.push(messages[0].text);
    }

    // Construct the stand-up report message.
    string textMessage = string `Automated Stand Up Report: ${"\n"}${
        <string>from [int, string] [index, text] in latestText.enumerate()
        select string `${index + 1}. ${text}${"\n"}`
    }`;

    // Post the stand-up report message to the "general" channel.
    slack:ChatPostMessageResponse|error postMessageResult = slack->/chat\.postMessage.post({channel: "general", text: textMessage});

    if postMessageResult is error {
        log:printError("Failed to post message to Slack", postMessageResult);
    } else {
        log:printInfo("Message posted successfully");
    }
}
