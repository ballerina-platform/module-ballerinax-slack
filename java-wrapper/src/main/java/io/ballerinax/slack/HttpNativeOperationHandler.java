// Copyright (c) 2021, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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

package io.ballerinax.slack;

import io.ballerina.runtime.api.Environment;
import io.ballerina.runtime.api.Future;
import io.ballerina.runtime.api.Module;
import io.ballerina.runtime.api.async.Callback;
import io.ballerina.runtime.api.async.StrandMetadata;
import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.types.MethodType;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BObject;
import io.ballerina.runtime.api.values.BString;

import java.util.ArrayList;
import static io.ballerina.runtime.api.utils.StringUtils.fromString;

public class HttpNativeOperationHandler {
    // App Events
    public static Object callOnAppHomeOpened(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnAppHomeOpened", "onAppHomeOpened");
    }

    public static Object callOnAppMention(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnAppMention", "onAppMention");
    }

    public static Object callOnAppRateLimited(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnAppRateLimited", "onAppRateLimited");
    }

    public static Object callOnAppRequested(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnAppRequested", "onAppRequested");
    }

    public static Object callOnAppUninstalled(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnAppUninstalled", "onAppUninstalled");
    }

    // Call Events
    public static Object callOnCallRejected(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnCallRejected", "onCallRejected");
    }

    // Channel Events
    public static Object callOnChannelArchive(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelArchive", "onChannelArchive");
    }

    public static Object callOnChannelCreated(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelCreated", "onChannelCreated");
    }

    public static Object callOnChannelDeleted(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelDeleted", "onChannelDeleted");
    }

    public static Object callOnChannelHistoryChanged(Environment env, BObject bHttpService, BMap<BString, 
                                                     Object> message) { 
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelHistoryChanged", 
            "onChannelHistoryChanged");
    }

    public static Object callOnChannelIdChanged(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelIdChanged", "onChannelIdChanged");
    }

    public static Object callOnChannelLeft(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelLeft", "onChannelLeft");
    }

    public static Object callOnChannelRename(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelRenamee", "onChannelRename");
    }

    public static Object callOnChannelUnarchive(Environment env, BObject bHttpService, 
                                                BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnChannelUnarchive", "onChannelUnarchive");
    }

    // DND Events
    public static Object callOnDndUpdated(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnDndUpdated", "onDndUpdated");
    }

    public static Object callOnDndUpdatedUser(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnDndUpdatedUser", "onDndUpdatedUser");
    }

    // Email Domain Events
    public static Object callOnEmailDomainChanged(Environment env, BObject bHttpService, 
                                                  BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnEmailDomainChanged", "onEmailDomainChanged");
    }

    // Emoji Events
    public static Object callOnEmojiChanged(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnEmojiChanged", "onEmojiChanged");
    }

    // File Events
    public static Object callOnFileChange(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileChange", "onFileChange");
    }

    public static Object callOnFileCommentAdded(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileCommentAdded", "onFileCommentAdded");
    }

    public static Object callOnFileCommentDeleted(Environment env, BObject bHttpService, 
                                                  BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileCommentDeleted", "onFileCommentDeleted");
    }

    public static Object callOnFileCommentEdited(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileCommentEdited", "onFileCommentEdited");
    }

    public static Object callOnFileCreated(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileCreated", "onFileCreated");
    }

    public static Object callOnFileDeleted(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileDeleted", "onFileDeleted");
    }

    public static Object callOnFilePublic(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFilePublic", "onFilePublic");
    }

    public static Object callOnFileShared(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileShared", "onFileShared");
    }

    public static Object callOnFileUnshared(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnFileUnshared", "onFileUnshared");
    }

    // Grid Migration Events
    public static Object callOnGridMigrationFinished(Environment env, BObject bHttpService, BMap<BString, 
                                                     Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGridMigrationFinished", 
            "onGridMigrationFinished");
    }

    public static Object callOnGridMigrationStarted(Environment env, BObject bHttpService, 
                                                    BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGridMigrationStarted", "onGridMigrationStarted");
    }


    // Group Events
    public static Object callOnGroupArchive(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupArchive", "onGroupArchive");
    }

    public static Object callOnGroupClose(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupClose", "onGroupClose");
    }

    public static Object callOnGroupDeleted(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupDeleted", "onGroupDeleted");
    }

    public static Object callOnGroupHistoryChanged(Environment env, BObject bHttpService, 
                                                    BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupHistoryChanged", "onGroupHistoryChanged");
    }

    public static Object callOnGroupLeft(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupLeft", "onGroupLeft");
    }

    public static Object callOnGroupOpen(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupOpen", "onGroupOpen");
    }

    public static Object callOnGroupRename(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupRename", "onGroupRename");
    }

    public static Object callOnGroupUnarchive(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnGroupUnarchive", "onGroupUnarchive");
    }

    // Im Events
    public static Object callOnImClose(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnImClose", "onImClose");
    }
    public static Object callOnImCreated(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnImCreated", "onImCreated");
    }
    public static Object callOnImHistoryChanged(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnImHistoryChanged", "onImHistoryChanged");
    }
    public static Object callOnImOpen(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnImOpen", "onImOpen");
    }

    // Invite Events
    public static Object callOnInviteRequested(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnInviteRequested", "onInviteRequested");
    }

    // Link Events
    public static Object callOnLinkShared(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnLinkShared", "onLinkShared");
    }

    // Member Events
    public static Object callOnMemberJoinedChannel(Environment env, BObject bHttpService, 
                                                    BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnMemberJoinedChannel", "onMemberJoinedChannel");
    }
    public static Object callOnMemberLeftChannel(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnMemberLeftChannel", "onMemberLeftChannel");
    }

    // Message events
    public static Object callOnMessage(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnMessage", "onMessage");
    }

    // Pin Events
    public static Object callOnPinAdded(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnPinAdded", "onPinAdded");
    }

    public static Object callOnPinRemoved(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnPinRemoved", "onPinRemoved");
    }

    // Reaction Events
    public static Object callOnReactionAdded(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnReactionAdded", "onReactionAdded");
    }

    public static Object callOnReactionRemoved(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnReactionRemoved", "onReactionRemoved");
    }

    // Resources Events
    public static Object callOnResourcesAdded(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnResourcesAdded", "onResourcesAdded");
    }
    public static Object callOnResourcesRemoved(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnResourcesRemoved", "onResourcesRemoved");
    }

    // Scope Events
    public static Object callOnScopeDenied(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnScopeDenied", "onScopeDenied");
    }

    public static Object callOnScopeGranted(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnScopeGranted", "onScopeGranted");
    }

    // Star Events
    public static Object callOnStarAdded(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnStarAdded", "onStarAdded");
    }

    public static Object callOnStarRemoved(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnStarRemoved", "onStarRemoved");
    }

    // Subteam Events
    public static Object callOnSubteamCreated(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnSubteamCreated", "onSubteamCreated");
    }

    public static Object callOnSubteamMembersChanged(Environment env, BObject bHttpService, 
                                                     BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnSubteamMembersChanged", 
            "onSubteamMembersChanged");
    }

    public static Object callOnSubteamSelfAdded(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnSubteamSelfAdded", "onSubteamSelfAdded");
    }

    public static Object callOnSubteamSelfRemoved(Environment env, BObject bHttpService, 
                                                  BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnSubteamSelfRemoved", "onSubteamSelfRemoved");
    }

    public static Object callOnSubteamUpdated(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnSubteamUpdated", "onSubteamUpdated");
    }

    // Team Events
    public static Object callOnTeamAccessGranted(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnTeamAccessGranted", "onTeamAccessGranted");
    }

    public static Object callOnTeamAccessRevoked(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnTeamAccessRevoked", "onTeamAccessRevoked");
    }

    public static Object callOnTeamDomainChange(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnTeamDomainChange", "onTeamDomainChange");
    }

    public static Object callOnTeamJoin(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnTeamJoin", "onTeamJoin");
    }

    public static Object callOnTeamRename(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnTeamRename", "onTeamRename");
    }

    // Tokens Evens
    public static Object callOnTokensRevoked(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnTokensRevoked", "onTokensRevoked");
    }

    // User Events
    public static Object callOnUserChange(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnUserChange", "onUserChange");
    }

    public static Object callOnUserResourceDenied(Environment env, BObject bHttpService, 
                                                  BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnUserResourceDenied", "onUserResourceDenied");
    }

    public static Object callOnUserResourceGranted(Environment env, BObject bHttpService, 
                                                   BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnUserResourceGranted", "onUserResourceGranted");
    }

    public static Object callOnUserResourceRemoved(Environment env, BObject bHttpService, 
                                                   BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnUserResourceRemoved", "onUserResourceRemoved");
    }

    // Workflow Events
    public static Object callOnWorkflowDeleted(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnWorkflowDeleted", "onWorkflowDeleted");
    }

    public static Object callOnWorkflowPublished(Environment env, BObject bHttpService, BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnWorkflowPublished", "onWorkflowPublished");
    }

    public static Object callOnWorkflowStepDeleted(Environment env, BObject bHttpService, 
                                                   BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnWorkflowStepDeleted", "onWorkflowStepDeleted");
    }

    public static Object callOnWorkflowStepExecute(Environment env, BObject bHttpService, BMap<BString, 
                                                   Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnWorkflowStepExecute", "onWorkflowStepExecute");
    }

    public static Object callOnWorkflowUnPublished(Environment env, BObject bHttpService, 
                                                   BMap<BString, Object> message) {
        return invokeRemoteFunction(env, bHttpService, message, "callOnWorkflowUnPublished", "onWorkflowUnPublished");
    }

    public static BArray getServiceMethodNames(BObject bSubscriberService) {
        ArrayList<BString> methodNamesList = new ArrayList<>();
        for (MethodType method : bSubscriberService.getType().getMethods()) {
            methodNamesList.add(StringUtils.fromString(method.getName()));
        }
        return ValueCreator.createArrayValue(methodNamesList.toArray(BString[]::new));
    }

    private static Object invokeRemoteFunction(Environment env, BObject bHttpService, BMap<BString, Object> message,
                                               String parentFunctionName, String remoteFunctionName) {
        Future balFuture = env.markAsync();
        Module module = ModuleUtils.getModule();
        StrandMetadata metadata = new StrandMetadata(module.getOrg(), module.getName(), module.getVersion(),
                parentFunctionName);
        Object[] args = new Object[]{message, true};
        env.getRuntime().invokeMethodAsync(bHttpService, remoteFunctionName, null, metadata, new Callback() {
            @Override
            public void notifySuccess(Object result) {
                balFuture.complete(result);
            }

            @Override
            public void notifyFailure(BError bError) {
                BString errorMessage = fromString("service method invocation failed: " + bError.getErrorMessage());
                BError invocationError = ErrorCreator.createError(errorMessage, bError);
                balFuture.complete(invocationError);
            }
        }, args);
        return null;
    }
}
