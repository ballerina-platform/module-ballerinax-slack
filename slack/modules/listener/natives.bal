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

import ballerina/jballerina.java;

isolated class HttpToSlackAdaptor {
    isolated function init(SimpleHttpService serviceObj) returns error? {
        externInit(self, serviceObj);
    }

    // App Events
    isolated function callOnAppHomeOpened(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnAppMention(AppMentionEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnAppRateLimited(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnAppRequested(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnAppUninstalled(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Call Events
    isolated function callOnCallRejected(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Channel Events
    isolated function callOnChannelArchive(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnChannelCreated(ChannelCreatedEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnChannelDeleted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnChannelHistoryChanged(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnChannelIdChanged(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnChannelLeft(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnChannelRename(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnChannelUnarchive(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // DND Events
    isolated function callOnDndUpdated(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnDndUpdatedUser(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Email Domain Events
    isolated function callOnEmailDomainChanged(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Emoji Events
    isolated function callOnEmojiChanged(EmojiChangedEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // File Events
    isolated function callOnFileChange(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFileCommentAdded(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFileCommentDeleted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFileCommentEdited(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFileCreated(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFileDeleted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFilePublic(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFileShared(FileSharedEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnFileUnshared(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Grid Migration Events
    isolated function callOnGridMigrationFinished(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGridMigrationStarted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Group Events
    isolated function callOnGroupArchive(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGroupClose(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGroupDeleted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGroupHistoryChanged(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGroupLeft(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGroupOpen(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGroupRename(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnGroupUnarchive(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Im Events
    isolated function callOnImClose(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnImCreated(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnImHistoryChanged(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnImOpen(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Invite Events
    isolated function callOnInviteRequested(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Link Events
    isolated function callOnLinkShared(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Member Events
    isolated function callOnMemberJoinedChannel(MemberJoinedChannelEvent event) 
    returns error? = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnMemberLeftChannel(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Message events
    isolated function callOnMessage(MessageEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Pin Events
    isolated function callOnPinAdded(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnPinRemoved(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Reaction Events
    isolated function callOnReactionAdded(ReactionAddedEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnReactionRemoved(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Resources Events
    isolated function callOnResourcesAdded(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnResourcesRemoved(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Scope Events
    isolated function callOnScopeDenied(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnScopeGranted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Star Events
    isolated function callOnStarAdded(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnStarRemoved(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Subteam Events
    isolated function callOnSubteamCreated(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnSubteamMembersChanged(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnSubteamSelfAdded(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnSubteamSelfRemoved(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnSubteamUpdated(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Team Events
    isolated function callOnTeamAccessGranted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnTeamAccessRevoked(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnTeamDomainChange(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnTeamJoin(TeamJoinEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnTeamRename(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Tokens Evens
    isolated function callOnTokensRevoked(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // User Events
    isolated function callOnUserChange(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnUserResourceDenied(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnUserResourceGranted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnUserResourceRemoved(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    // Workflow Events
    isolated function callOnWorkflowDeleted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnWorkflowPublished(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnWorkflowStepDeleted(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnWorkflowStepExecute(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    isolated function callOnWorkflowUnPublished(SlackEvent event) returns error? 
    = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;

    # Invoke native method to retrive implemented method names in the subscriber service
    #
    # + return - {@code string[]} containing the method-names in current implementation
    isolated function getServiceMethodNames() returns string[] = @java:Method {
        'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
    } external;
}

isolated function externInit(HttpToSlackAdaptor adaptor, SimpleHttpService serviceObj) = @java:Method {
    'class: "io.ballerinax.slack.NativeHttpToSlackAdaptor"
} external;
