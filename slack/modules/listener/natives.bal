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

// App Events
isolated function callOnAppHomeOpened(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnAppMention(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnAppRateLimited(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnAppRequested(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnAppUninstalled(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Call Events
isolated function callOnCallRejected(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Channel Events
isolated function callOnChannelArchive(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnChannelCreated(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnChannelDeleted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnChannelHistoryChanged(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnChannelIdChanged(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnChannelLeft(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnChannelRename(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnChannelUnarchive(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// DND Events
isolated function callOnDndUpdated(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnDndUpdatedUser(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Email Domain Events
isolated function callOnEmailDomainChanged(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Emoji Events
isolated function callOnEmojiChanged(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// File Events
isolated function callOnFileChange(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFileCommentAdded(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFileCommentDeleted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFileCommentEdited(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFileCreated(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFileDeleted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFilePublic(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFileShared(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnFileUnshared(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Grid Migration Events
isolated function callOnGridMigrationFinished(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGridMigrationStarted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

 // Group Events
isolated function callOnGroupArchive(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGroupClose(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGroupDeleted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGroupHistoryChanged(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGroupLeft(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGroupOpen(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGroupRename(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnGroupUnarchive(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Im Events
isolated function callOnImClose(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnImCreated(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnImHistoryChanged(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnImOpen(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Invite Events
isolated function callOnInviteRequested(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Link Events
isolated function callOnLinkShared(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Member Events
isolated function callOnMemberJoinedChannel(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnMemberLeftChannel(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Message events
isolated function callOnMessage(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Pin Events
isolated function callOnPinAdded(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnPinRemoved(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Reaction Events
isolated function callOnReactionAdded(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnReactionRemoved(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Resources Events
isolated function callOnResourcesAdded(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnResourcesRemoved(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Scope Events
isolated function callOnScopeDenied(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnScopeGranted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Star Events
isolated function callOnStarAdded(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnStarRemoved(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Subteam Events
isolated function callOnSubteamCreated(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnSubteamMembersChanged(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnSubteamSelfAdded(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnSubteamSelfRemoved(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnSubteamUpdated(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Team Events
isolated function callOnTeamAccessGranted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnTeamAccessRevoked(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnTeamDomainChange(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnTeamJoin(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnTeamRename(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Tokens Evens
isolated function callOnTokensRevoked(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// User Events
isolated function callOnUserChange(SimpleHttpService httpService, SlackEvent event) returns error?
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnUserResourceDenied(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnUserResourceGranted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnUserResourceRemoved(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

// Workflow Events
isolated function callOnWorkflowDeleted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnWorkflowPublished(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnWorkflowStepDeleted(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnWorkflowStepExecute(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

isolated function callOnWorkflowUnPublished(SimpleHttpService httpService, SlackEvent event) returns error? 
    = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;

# Invoke native method to retrive implemented method names in the subscriber service
#
# + httpService - current http service
# + return - {@code string[]} containing the method-names in current implementation
isolated function getServiceMethodNames(SimpleHttpService httpService) returns string[] = @java:Method {
    'class: "io.ballerinax.slack.HttpNativeOperationHandler"
} external;
