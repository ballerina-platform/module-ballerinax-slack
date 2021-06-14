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
import ballerina/log;

isolated service class HttpService {
    private final boolean isOnAppMentionAvailable;
    private final boolean isOnChannelCreatedAvailable;
    private final boolean isOnEmojiChangedAvailable;
    private final boolean isOnFileSharedAvailable;
    private final boolean isOnMemberJoinedChannelAvailable;
    private final boolean isOnMessageAvailable;
    private final boolean isOnReactionAddedAvailable;
    private final boolean isOnTeamJoinAvailable;

    private final HttpToSlackAdaptor adaptor;
    private final string verificationToken;

    isolated function init(HttpToSlackAdaptor adaptor, string verificationToken) {
        self.adaptor = adaptor;
        self.verificationToken = verificationToken;

        // Get names of the resource functions implemented by the user.
        string[] methodNames = adaptor.getServiceMethodNames();
        self.isOnAppMentionAvailable = isMethodAvailable("onAppMention", methodNames);
        self.isOnChannelCreatedAvailable = isMethodAvailable("onChannelCreated", methodNames);
        self.isOnEmojiChangedAvailable = isMethodAvailable("onEmojiChanged", methodNames);
        self.isOnFileSharedAvailable = isMethodAvailable("onFileShared", methodNames);
        self.isOnMemberJoinedChannelAvailable = isMethodAvailable("onMemberJoinedChannel", methodNames);
        self.isOnMessageAvailable = isMethodAvailable("onMessage", methodNames);
        self.isOnReactionAddedAvailable = isMethodAvailable("onReactionAdded", methodNames);
        self.isOnTeamJoinAvailable = isMethodAvailable("onTeamJoin", methodNames);

        if (methodNames.length() > 0) {
            foreach string methodName in methodNames {
                log:printError("Unrecognized method [" + methodName + "] found in user implementation."); 
            }
        }
    }

    # Handle POST requests sent from Slack.
    # 
    # + caller - HTTP caller
    # + request - HTTP request
    # + return - Error if it is a failure
    isolated resource function post events (http:Caller caller, http:Request request) returns @tainted error? {
        json payload = check request.getJsonPayload();
        string eventOrVerification = check payload.'type;

        if (payload.token !== self.verificationToken) {
            return error("Verification token mismatch");
        }

        if (eventOrVerification == URL_VERIFICATION) {
            check self.verifyURL(caller, payload);
        } else if (eventOrVerification == EVENT_CALLBACK) {
            http:Response response = new;
            response.statusCode = http:STATUS_OK;
            check caller->respond(response);

            json eventTypeJson = check payload.event.'type;
            string eventType = eventTypeJson.toString();

            // Handle the events based on the category of the event.
            if (eventType.startsWith("app_")) {
                AppMentionEvent slackEvent = check payload.cloneWithType(AppMentionEvent);
                check self.handleAppEvents(eventType, slackEvent);
            } else if (eventType.startsWith("channel_")) {
                ChannelCreatedEvent slackEvent = check payload.cloneWithType(ChannelCreatedEvent);
                check self.handleChannelEvents(eventType, slackEvent);
            } else if (eventType.startsWith("emoji_")) {
                EmojiChangedEvent slackEvent = check payload.cloneWithType(EmojiChangedEvent);
                check self.handleEmojiEvents(eventType, slackEvent);
            } else if (eventType.startsWith("file_")) {
                FileSharedEvent slackEvent = check payload.cloneWithType(FileSharedEvent);
                check self.handleFileEvents(eventType, slackEvent);
            } else if (eventType.startsWith("member_")) {
                MemberJoinedChannelEvent slackEvent = check payload.cloneWithType(MemberJoinedChannelEvent);
                check self.handleMemberEvents(eventType, slackEvent);
            } else if (eventType == "message") {
                MessageEvent slackEvent = check payload.cloneWithType(MessageEvent);
                check self.adaptor.callOnMessage(slackEvent);
            } else if (eventType.startsWith("reaction_")) {
                ReactionAddedEvent slackEvent = check payload.cloneWithType(ReactionAddedEvent);
                check self.handleReactionEvents(eventType, slackEvent);
            } else if (eventType.startsWith("team_")) {
                TeamJoinEvent slackEvent = check payload.cloneWithType(TeamJoinEvent);
                check self.handleTeamEvents(eventType, slackEvent);
            }
        } else {
            return error("Unidentified Request Type");
        }
    }

    # Handle App related events.
    # 
    # + eventType - Type of the Slack event
    # + slackEvent - Slack event record
    # + return - Error if it is a failure
    isolated function handleAppEvents(string eventType, AppMentionEvent slackEvent) returns error? {
        if (self.isOnAppMentionAvailable && eventType == "app_mention") {
            check self.adaptor.callOnAppMention(slackEvent);
        }
    }

    # Handle Channel related events.
    # 
    # + eventType - Type of the Slack event
    # + slackEvent - Slack event record
    # + return - Error if it is a failure
    isolated function handleChannelEvents(string eventType, ChannelCreatedEvent slackEvent) returns error? {
        if (self.isOnChannelCreatedAvailable && eventType == "channel_created") {
            check self.adaptor.callOnChannelCreated(slackEvent);
        }
    }

    # Handle Emoji related events.
    # 
    # + eventType - Type of the Slack event
    # + slackEvent - Slack event record
    # + return - Error if it is a failure
    isolated function handleEmojiEvents(string eventType, EmojiChangedEvent slackEvent) returns error? {
        if (self.isOnEmojiChangedAvailable && eventType == "emoji_changed") {
            check self.adaptor.callOnEmojiChanged(slackEvent);
        }
    }

    # Handle File related events.
    # 
    # + eventType - Type of the Slack event
    # + slackEvent - Slack event record
    # + return - Error if it is a failure
    isolated function handleFileEvents(string eventType, FileSharedEvent slackEvent) returns error? {
        if (self.isOnFileSharedAvailable && eventType == "file_shared") {
            check self.adaptor.callOnFileShared(slackEvent);
        } 
    }

    # Handle Member related events.
    # 
    # + eventType - Type of the Slack event
    # + slackEvent - Slack event record
    # + return - Error if it is a failure
    isolated function handleMemberEvents(string eventType, MemberJoinedChannelEvent slackEvent) returns error? {
        if (self.isOnMemberJoinedChannelAvailable && eventType == "member_joined_channel") {
            check self.adaptor.callOnMemberJoinedChannel(slackEvent);
        }
    }

    # Handle Reaction related events.
    # 
    # + eventType - Type of the Slack event
    # + slackEvent - Slack event record
    # + return - Error if it is a failure
    isolated function handleReactionEvents(string eventType, ReactionAddedEvent slackEvent) returns error? {
        if (self.isOnReactionAddedAvailable && eventType == "reaction_added") {
            check self.adaptor.callOnReactionAdded(slackEvent);
        }
    }

    # Handle Team related events.
    # 
    # + eventType - Type of the Slack event
    # + slackEvent - Slack event record
    # + return - Error if it is a failure
    isolated function handleTeamEvents(string eventType, TeamJoinEvent slackEvent) returns error? {
        if (self.isOnTeamJoinAvailable && eventType == "team_join") {
            check self.adaptor.callOnTeamJoin(slackEvent);
        }
    }

    # Respond to the URL verification request with the challenge in the payload.
    # 
    # + caller - HTTP caller
    # + payload - Json payload of the request
    # + return - Error if it is a failure
    isolated function verifyURL(http:Caller caller, json payload) returns @untainted error? {
        http:Response response = new;
        response.statusCode = http:STATUS_OK;
        response.setPayload({challenge: check <@untainted>payload.challenge});
        check caller->respond(response);
        log:printInfo("Request URL Verified");
    }
}

# Retrieves whether the particular remote method is available.
#
# + methodName - Name of the required method
# + methods - All available methods
# + return - `true` if method available or else `false`
isolated function isMethodAvailable(string methodName, string[] methods) returns boolean {
    boolean isAvailable = methods.indexOf(methodName) is int;
    if (isAvailable) {
        var index = methods.indexOf(methodName);
        if (index is int) {
            _ = methods.remove(index);
        }
    }
    return isAvailable;
}
