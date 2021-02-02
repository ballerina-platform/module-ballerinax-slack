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

// todo - implement support to the resource related events, subteam related events, team related events, workflow related events

# Record representing the configuration for the Slack Listener.
#
# + verificationToken - the verification token mentioned in your slack app settings - basic information section
public type ListenerConfiguration record {|
    string verificationToken;
|};

public type ValidationRequest record {|
    string token;
    string challenge;
    string 'type;
|};

public type AppEvent record {
    string 'type;
    string user;
    string channel;
    string event_ts;
    string tab?;
    string text?;
    string ts?;
};

public type CallEvent record {
    string 'type;
    string call_id;
    string user_id;
    string channel_id;
    string external_unique_id;
};

public type MessageEvent record {
    string 'type;
    string channel;
    string user;
    string text;
    string ts;
    Edited edited?;
    string subtype?;
    boolean hidden?;
    string deleted_ts?;
    string event_ts?;
    boolean is_starred?;
    string channel_type?;
};

public type MemberEvent record {
    string 'type;
    string user;
    string channel;
    string channel_type?;
    string team?;
    string inviter?;
};

public type DNDEvent record {
    string 'type;
    string user;
    DND_Detail dnd_status;
};

public type GridMigrationEvent record {
    string 'type;
    string enterprise_id;
};

public type InviteRequestedEvent record {
    string 'type;
    InviteRequest invite_request;
};

public type ReactionEvent record {
    string 'type;
    string user;
    string reaction;
    string item_user?;
    ReactionItem item;
    string event_ts;
};

public type FileEvent record {
    string 'type;
    string file_id;
    FileDetails file?;
    string|string[]|json|json[] comment?;
    string event_ts?;
};

public type GenericSlackEvent record {
    string 'type;
    string|Channel channel?;
    string user?;
    string text?;
    string latest?;
    string ts?;
    string event_ts?;
    string connected_team_id?;
    string previously_connected_team_id?;
    boolean is_ext_shared?;
    string subtype?;
    string[] names?;
    string message_ts?;
    string thread_ts?;
    json[]|json links?;
    boolean is_bot_user_member?;
    boolean has_pins?;
    string|string[] scopes?;
    string trigger_id?;
    json[]|json item?;
    string subteam_id?;
};

public type Edited record {
    string user;
    string ts;
};

public type Channel record {
    string id;
    string name;
    int created;
    string creator?;
};

public type DND_Detail record {
    boolean dnd_enabled;
    int? next_dnd_start_ts;
    int? next_dnd_end_ts;
    boolean snooze_enabled?;
    int? snooze_endtime?;
};

public type InviteRequest record {
    string id;
    string email;
    int date_created;
    string[] requester_ids;
    string[] channel_ids;
    string invite_type;
    string real_name;
    int date_expire;
    string request_reason?;
    Team team?;
};

public type Team record {
    string id;
    string name?;
    string domain?;
};

public type FileDetails record {
    string id;
};

public type ReactionItem record {
    string 'type;
    string channel?;
    string ts?;
    string file?;
    string file_comment?;
};

public type SlackEvent GenericSlackEvent|ValidationRequest|InviteRequestedEvent|AppEvent|CallEvent|MessageEvent|FileEvent|DNDEvent|ReactionEvent|MemberEvent;

public type AppEventType APP_MENTION|APP_HOME_OPENED;

public type CallEventType CALL_REJECTED;

public type MessageEventType MESSAGE;

public type FileEventType FILE_CHANGED|FILE_COMMENT_ADDED|FILE_COMMENT_DELETED|FILE_CREATED|FILE_DELETED|FILE_PUBLIC|FILE_SHARED|FILE_UNSHARED;

public type DNDEventType DND_UPDATED|DND_UPDATED_USER;

public type InviteRequestedEventType INVITE_REQUESTED;

public type ReactionEventType REACTION_ADDED|REACTION_REMOVED;

public type MemberEventType MEMBER_LEFT_CHANNEL|MEMBER_JOINED_CHANNEL;
